`timescale 1ns / 1ps
module RegFile(
	input clk, rst, we,
	input [4:0] a, b, w, 
	input [31:0] w_data,
	output [31:0] a_data, b_data
);
	reg [31:0] regs [1:31]; // r1 - r31
	assign a_data = a != 0 ? ((a == w && we) ? w_data : regs[a]) : 0;
	assign b_data = b != 0 ? ((b == w && we) ? w_data : regs[b]) : 0;

	integer i;
	always @(posedge clk or posedge rst) begin
		if (rst) for (i = 1; i < 32; i = i + 1) regs[i] <= 0; 
		else if (w != 0 && we) regs[w] <= w_data;
	end

endmodule

