`timescale 1ns / 1ps
module PCPU(
    input wire INT,
    input wire clk,
    input wire reset,
    input wire MIO_ready,
    input wire [31:0] data_mem,
    input wire [31:0] inst_mem,
    output wire mem_w,
    output wire [31:0] inst_addr
    output wire [31:0] data_addr,
    output wire CPU_MIO,
);

    // control wires
    wire jal, wreg, branch, m2reg, wmem, aluimm, shift, sext, jr, reg_rt, stall, jump, remain_pc;
    wire [3:0] aluc;
    wire [1:0] fwda, fwdb;

    // PC
    reg [31:0] pc;

    // IF wires
    wire [31:0] pc_new;

    // IF/ID pipeline register
    reg [31:0] ifid_ir, ifid_pc;

    // ID wires
    wire [31:0] branch_target;

    // ID/EX pipeline register
    reg [31:0] idex_ir;
    reg [3:0] idex_aluc;
    reg idex_wreg, idex_mreg, idex_wmem, idex_aluimm, idex_shift;
    reg [31:0] idex_rs_data, idex_rt_data;
    reg [31:0] idex_imm_ext;
    reg [4:0] idex_wb_reg;

    // EX/MEM pipeline register
    reg [31:0] exmem_ir;
    reg exmem_wreg, exmem_m2reg, exmem_wmem;
    reg [31:0] exmem_alu_result, idex_rt_data;
    reg [4:0] exmem_wb_reg;

    // MEM/WB pipeline register
    reg [31:0] memwb_ir;
    reg memwb_wreg, memwb_m2reg;
    reg [31:0] memwb_data, memwb_alu_result;
    reg [4:0] memwb_wb_reg;

    // output
    assign inst_addr = pc;

    // IF wires
    assign pc_new = branch ? branch_target : pc + 4'h4;

    // ID wires
    assign branch_target = 0; // TODO
    wire [5:0] func = ifid_ir[5:0];
    wire [5:0] op = ifid_ir[31:26];
    wire [4:0] rs = ifid_ir[25:21];
    wire [4:0] rt = ifid_ir[20:16];
    wire [15:0] imm = ifid_ir[15:0];
    wire [31:0] j_addr = { ifid_pc[31:28], ifid_ir[25:0], 2'h0 };
    wire [31:0] br_addr = ifid_pc + {imm, 2'h0};
    wire [31:0] jr_addr = 0; // TODO
    
    always @(posedge clk) begin

        pc <= remain_pc ? pc : pc_new;

        // IF/ID
        ifid_ir <= stall ? 0 : inst_mem;
        ifid_pc <= pc + 4'h4;
    end


endmodule