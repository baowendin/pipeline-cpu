`timescale 1ns / 1ps
module ALU(
	unsigned input [31:0] A,
	unsigned input [31:0] B,
	input [3:0] ALU_operation,
	output reg [31:0] res,
	output zero
);
	`include "Parameters.v"

	signed wire [31:0] A_signed = A;
	signed wire [31:0] B_signed = B;

	always @*
		case (ALU_operation)
			ALUC_AND: res = A & B;
			ALUC_OR: res = A | B;
			ALUC_ADD: res = A + B;
			ALUC_XOR: res = A ^ B;
			ALUC_NOR: res = ~(A | B);
			
			ALUC_SUB: res = A - B;
			ALUC_SLT: res = A_signed < B_signed;
			ALUC_SLTU: res = A < B;

			ALUC_SRL: res = B >> A[4:0];
			ALUC_SLL: res = B << A[4:0];
			ALUC_SRA: res = B >>> A[4:0];

			ALUC_SRLV: res = B >> A;
			ALUC_SLLV: res = B << A;
			ALUC_SRAV: res = B >>> A;

			ALUC_LUI: res = { B[15:0], 16'h0 };
			
			default: res = 32'h0;
		endcase

	assign zero = res == 0;
endmodule