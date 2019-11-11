`timescale 1ns / 1ps
module ShiftLeft_2(
	input [31:0] I,
	output [31:0] O
    );
	assign O = I << 2;

endmodule
