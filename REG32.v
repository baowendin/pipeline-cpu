`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:43:59 03/25/2019 
// Design Name: 
// Module Name:    REG32 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module REG32(
	input wire clk,
	input wire rst,
	input wire CE,
	input wire [31:0] D,
	output wire [31:0] Q
    );

	reg[31:0] data;
	assign Q = data;

	always @ (posedge clk or posedge rst)
	begin
		if (rst == 1) data <= 32'b0;
		else if (clk == 1 && CE == 1) data <= D;
	end

endmodule
