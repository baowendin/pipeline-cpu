`timescale 1ns / 1ps
module PCPU(
    input wire clk,
    input wire rst,
    output wire [31:0] inst_addr,
    input wire [31:0] inst_mem,
    output wire [31:0] data_addr,
    input wire [31:0] data_mem,
    output wire data_we,
    output wire [31:0] data_write
);
    `include "Parameters.v"

    // PC
    wire stall, cancel_next; // NOTE: from later stages
    wire [31:0] pc_new; // NOTE: from later stages
    reg [31:0] pc = 0;
    assign inst_addr = pc;
    always @(posedge clk or posedge rst) begin
        pc <= rst ? 0 : (stall ? pc : pc_new);
    end


    // IF stage
    wire branch;
    wire [31:0] branch_target;
    assign pc_new = branch ? branch_target : pc + 4'h4;


    // IF/ID pipeline register
    reg [31:0] ifid_ir = 0, ifid_pc = 0;
    always @(posedge clk or posedge rst) begin
        ifid_pc <= rst ? 0 : pc + 4'h4;
        if (rst) begin
            ifid_ir <= 0;
        end
        else if (stall) begin
            ifid_ir <= ifid_ir; 
        end
        else if (cancel_next) begin
            ifid_ir <= 0;
        end
        else begin
            ifid_ir <= inst_mem;
        end
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
    wire [4:0] exe_regw_addr, mem_regw_addr;
    wire exe_wreg, exe_mem2reg, mem_wreg, mem_mem2reg;

    Control cu(
        .op(op), .rs(rs), .rt(rt), .func(func), .rsrtequ(rsrtequ),
        .exe_regw_addr(exe_regw_addr),
        .mem_regw_addr(mem_regw_addr),
        .exe_wreg(exe_wreg),
        .exe_mem2reg(exe_mem2reg),
        .mem_wreg(mem_wreg),
        .mem_mem2reg(mem_mem2reg),

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
        .fwdb(fwdb),
        .fwda(fwda),
        .stall(stall),
        .jump(jump),
        .cancel_next(cancel_next)
    );

    wire reg_we;
	 wire [4:0] reg_w; // NOTE: from later stages
    wire [31:0] reg_w_data; // NOTE: from later stages
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

    // if JAL, write PC into $ra
    wire [31:0] a_final = jal ? ifid_pc : a_fwd_data;
    wire [31:0] b_final = jal ? 0 : b_fwd_data;
    wire [4:0] wreg_dst_final = jal ? 5'h1F : (reg_wb_rd ? rd : rt);


    // ID/EX pipeline register
    reg [31:0] idex_ir;
    reg [3:0] idex_aluc;
    reg idex_wreg, idex_m2reg, idex_wmem, idex_aluimm, idex_shift;
    reg [31:0] idex_a_data, idex_b_data;
    reg [31:0] idex_imm_ext;
    reg [4:0] idex_wreg_dst;
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
        idex_wreg_dst <= rst ? 0 : wreg_dst_final;
    end


    // EX wires
    wire [4:0] shamt = idex_imm_ext[10:6];
    wire [31:0] alu_a = idex_shift ? shamt : idex_a_data;
    wire [31:0] alu_b = idex_aluimm ? idex_imm_ext : idex_b_data;
    wire [31:0] ex_alu_result;
    ALU alu(
        .A(alu_a),
        .B(alu_b),
        .ALU_operation(idex_aluc),
        .res(ex_alu_result)
    );
    assign fwd_ex_alu_res = ex_alu_result;
    assign exe_mem2reg = idex_m2reg;
    assign exe_wreg = idex_wreg;
    assign exe_regw_addr = idex_wreg_dst;

    // EX/MEM pipeline register
    reg [31:0] exmem_ir;
    reg exmem_wreg, exmem_m2reg, exmem_wmem;
    reg [31:0] exmem_alu_result, exmem_b_data;
    reg [4:0] exmem_wreg_dst;
    always @(posedge clk or posedge rst) begin
        exmem_ir <= rst ? 0 : idex_ir;
        exmem_wreg <= rst ? 0 : idex_wreg;
        exmem_m2reg <= rst ? 0 : idex_m2reg;
        exmem_wmem <= rst ? 0 : idex_wmem;
        exmem_alu_result <= rst ? 0 : ex_alu_result; 
        exmem_b_data <= rst ? 0 : idex_b_data; 
        exmem_wreg_dst <= rst ? 0 : idex_wreg_dst; 
    end
    

    // MEM wires
    assign data_we = exmem_wmem;
    assign data_addr = exmem_alu_result;
    assign data_write = exmem_b_data;
    assign fwd_mem_alu_res = exmem_alu_result;
    assign fwd_mem_data = data_mem;
    assign mem_wreg = exmem_wreg;
    assign mem_mem2reg = exmem_m2reg;
    assign mem_regw_addr = exmem_wreg_dst;

    // MEM/WB pipeline register
    reg [31:0] memwb_ir;
    reg memwb_wreg, memwb_m2reg;
    reg [31:0] memwb_data, memwb_alu_result;
    reg [4:0] memwb_wreg_dst;
    always @(posedge clk or posedge rst) begin
        memwb_ir <= rst ? 0 : exmem_ir;
        memwb_wreg <= rst ? 0 : exmem_wreg;
        memwb_m2reg <= rst ? 0 : exmem_m2reg;
        memwb_data <= rst ? 0 : data_mem;
        memwb_alu_result <= rst ? 0 : exmem_alu_result;
        memwb_wreg_dst <= rst ? 0 : exmem_wreg_dst;
    end


    // WB wires
    assign reg_we = memwb_wreg;
    assign reg_w = memwb_wreg_dst;
    assign reg_w_data = memwb_m2reg ? memwb_data : memwb_alu_result;

endmodule