`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:29:22 03/26/2019 
// Design Name: 
// Module Name:    Ext_32 
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
module Ext_32(
	input wire [15:0] imme_16,
	output wire [31:0] imme_32
    );
	
	assign imme_32 = {imme_16[15],imme_16[15],imme_16[15],imme_16[15]
		,imme_16[15],imme_16[15],imme_16[15],imme_16[15],imme_16[15]
		,imme_16[15],imme_16[15],imme_16[15],imme_16[15],imme_16[15]
		,imme_16[15],imme_16[15],imme_16[15:0]};


endmodule
