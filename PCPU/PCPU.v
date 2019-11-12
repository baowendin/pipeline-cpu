`timescale 1ns / 1ps
module PCPU(
    input wire clk,
    input wire rst,
    input wire MIO_ready,
    input wire [31:0] data_mem,
    input wire [31:0] inst_mem,
    output wire mem_w,
    output wire [31:0] inst_addr
    output wire [31:0] data_addr,
    output wire CPU_MIO,
);
    // PC
    wire remain_pc; // NOTE: from later stages
    wire [31:0] pc_new; // NOTE: from later stages
    reg [31:0] pc = 0;
    assign inst_mem = pc;
    always @(posedge clk or posedge rst) begin
        pc <= rst ? 0 : (remain_pc ? pc : pc_new);
    end


    // IF stage
    wire branch, stall;
    wire [31:0] branch_target;
    assign pc_new = branch ? branch_target : pc + 4'h4;


    // IF/ID pipeline register
    reg [31:0] ifid_ir, ifid_pc;
    always @(posedge clk or posedge rst) begin
        ifid_pc <= rst ? 0 : pc + 4'h4;
        ifid_ir <= rst ? 0 : (stall ? 0 : inst_mem);
    end


    // ID stage
    wire [5:0] op = ifid_ir[31:26];
    wire [4:0] rs = ifid_ir[25:21];
    wire [4:0] rt = ifid_ir[20:16];
    wire [4:0] rd = ifid_ir[15:11];
    wire [5:0] func = ifid_ir[5:0];
    wire [15:0] imm = ifid_ir[15:0];
    wire [31:0] imm_ext = { {16{sext ? imm[15] : 1'h0}}, imm };

    wire rsrtequ; // NOTE: from forward result
    wire jal, wreg, m2reg, wmem, aluimm, shift, sext, jr, reg_wb_rd, jump;
    wire [3:0] aluc;
    wire [1:0] fwda, fwdb;
    Control cu(
        .op(op), .rs(rs), .rt(rt), .func(func), .rsrtequ(rsrtequ),
        .jal(jal),
        .wreg(wreg),
        .branch(branch),
        .mem2reg(m2reg),
        .wmem(wmem),
        .aluc(aluc),
        .aluimm(aluimm),
        .shift(shift),
        .sext(sext),
        .jr(jr), 
        .regrt(reg_wb_rd),
        .fwdb(fwda),
        .fwda(fwdb),
        .stall(stall),
        .jump(jump),
        .remain_pc(remain_pc)
    );

    wire reg_we, reg_w, reg_w_data; // NOTE: from later stages
    wire [31:0] reg_a_data, reg_b_data;
    RegFile regs(
        .clk(clk), .rst(rst),
        .we(reg_we), .w(reg_w), .w_data(reg_w_data), 
        .a(rs), .b(rt), .a_data(reg_a_data), .b_data(reg_b_data)
    );

    wire [31:0] fwd_ex_alu_res, fwd_mem_alu_res, fwd_mem_data; // NOTE: from later stages
    wire [31:0] a_fwd_data, b_fwd_data;
    MUX4T1_32 a_fwd_mux(.s(fwda), .I0(reg_a_data), .I1(fwd_ex_alu_res), .I2(fwd_mem_alu_res), .I3(fwd_mem_data), .o(a_fwd_data));
    MUX4T1_32 b_fwd_mux(.s(fwdb), .I0(reg_b_data), .I1(fwd_ex_alu_res), .I2(fwd_mem_alu_res), .I3(fwd_mem_data), .o(b_fwd_data));
    assign rsrtequ = a_fwd_data == b_fwd_data;

    wire [31:0] j_addr = { ifid_pc[31:28], ifid_ir[25:0], 2'h0 };
    wire [31:0] br_addr = ifid_pc + {imm, 2'h0};
    wire [31:0] jr_addr = a_fwd_data;
    assign branch_target = jr ? jr_addr : (jump ? j_addr : br_addr);

    wire [31:0] a_final = jal ? ifid_pc : a_fwd_data;
    wire [31:0] b_final = jal ? 0 : b_fwd_data;
    wire [4:0] wb_reg_final = jal ? 5'b11111 : (reg_wb_rd ? rd : rt);


    // ID/EX pipeline register
    reg [31:0] idex_ir;
    reg [3:0] idex_aluc;
    reg idex_wreg, idex_m2reg, idex_wmem, idex_aluimm, idex_shift;
    reg [31:0] idex_a_data, idex_b_data;
    reg [31:0] idex_imm_ext;
    reg [4:0] idex_wb_reg;
    always @(posedge clk or posedge rst) begin
        idex_ir <= rst ? 0 : ifid_ir;
        idex_aluc <= rst ? 0 : aluc;
        idex_wreg <= rst ? 0 : wreg;
        idex_m2reg <= rst ? 0 : m2reg;
        idex_wmem <= rst ? 0 : wmem;
        idex_aluimm <= rst ? 0 : aluimm;
        idex_shift <= rst ? 0 : shift;
        idex_a_data <= rst ? 0 : a_final;
        idex_b_data <= rst ? 0 : b_final;
        idex_imm_ext <= rst ? 0 : imm_ext;
        idex_wb_reg <= rst ? 0 : wb_reg_final;
    end


    // EX wires
    wire [4:0] shamt = idex_imm_ext[10:6];
    wire [31:0] alu_a = idex_shift ? shamt : idex_a_data;
    wire [31:0] alu_b = idex_aluimm ? idex_imm_ext : idex_b_data;
    wire [31:0] ex_alu_result; // TODO: ALU here
    assign fwd_ex_alu_res = ex_alu_result;


    // EX/MEM pipeline register
    reg [31:0] exmem_ir;
    reg exmem_wreg, exmem_m2reg, exmem_wmem;
    reg [31:0] exmem_alu_result, exmem_b_data;
    reg [4:0] exmem_wb_reg;
    always @(posedge clk or posedge rst) begin
        exmem_ir <= rst ? 0 : idex_ir;
        exmem_wreg <= rst ? 0 : idex_wreg;
        exmem_m2reg <= rst ? 0 : idex_m2reg;
        exmem_wmem <= rst ? 0 : idex_wmem;
        exmem_alu_result <= rst ? 0 : ex_alu_result; 
        exmem_b_data <= rst ? 0 : idex_b_data; 
        exmem_wb_reg <= rst ? 0 : idex_wb_reg; 
    end
    

    // MEM wires
    wire [31:0] mem_alu_result;
    wire [31:0] mem_data;


    // MEM/WB pipeline register
    reg [31:0] memwb_ir;
    reg memwb_wreg, memwb_m2reg;
    reg [31:0] memwb_data, memwb_alu_result;
    reg [4:0] memwb_wb_reg;


    // WB wires
    wire [31:0] wb_data;

endmodule