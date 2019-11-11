`timescale 1ns / 1ps
module ALU(
	input [31:0] A,
	input [31:0] B,
	input [2:0] ALU_operation,
	input [4:0] shamt,
	output [31:0] res,
	output zero, overflow
    );
	
	parameter one = 32'h00000001, zero_0 = 32'h00000000;
	wire [31:0] res_and, res_or, res_sub, res_xor, res_nor, res_srl, res_slt;
	wire [32:0] res_add;
	reg [31:0] reg_res;
	
	assign res = reg_res;
	
	assign res_and = A & B;
	assign res_or = A | B;
	assign res_add = A + B;
	assign overflow = res_add[32];
	assign res_sub = A - B;
	assign res_xor = A ^ B;
	assign res_srl = B >> shamt;
	assign res_slt = (A < B) ? one : zero_0;
	
	always @*
		case (ALU_operation)
			3'b000: reg_res = res_and;
			3'b001: reg_res = res_or;
			3'b010: reg_res = res_add[31:0];
			3'b011: reg_res = res_xor;
			3'b100: reg_res = ~res_or;
			3'b101:	reg_res = res_srl;
			3'b110: reg_res = res_sub;
			3'b111: reg_res = res_slt;
			default: reg_res = 32'hx;
		endcase
	assign zero = (reg_res == 0) ? 1 : 0;
endmodule
