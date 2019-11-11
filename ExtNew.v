`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:17 05/28/2019 
// Design Name: 
// Module Name:    ExtNew 
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
module ExtNew(
	input [15:0] i,
	input sign,
	output [31:0] o
    );
	assign o = { {16{sign ? i[15] : 1'b0}}, i};

endmodule
