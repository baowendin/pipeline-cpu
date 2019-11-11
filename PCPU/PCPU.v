`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:27:20 11/11/2019 
// Design Name: 
// Module Name:    PCPU 
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
module PCPU(
	input wire INT,
	input wire clk,
	input wire reset,
	input wire MIO_ready,
	input wire [31:0] Data_in,
	output wire mem_w,
	output wire [31:0] PC_out,
	output wire [31:0] inst_out,
	output wire [31:0] Data_out,
	output wire [31:0] Addr_out,
	output wire CPU_MIO,
	output wire [4:0] state
    );
// TODO

endmodule
