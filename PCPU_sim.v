`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:05:43 11/17/2019
// Design Name:   PCPU
// Module Name:   C:/Users/lifelongwar/Desktop/ISE/pipeline-cpu-master/pipeline-cpu-master/PCPU_sim.v
// Project Name:  OExp09
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PCPU_sim;

	// Inputs
	reg clk;
	reg rst;
	reg [31:0] inst_mem;
	reg [31:0] data_mem;

	// Outputs
	wire [31:0] inst_addr;
	wire [31:0] data_addr;
	wire data_we;
	wire [31:0] data_write;
	wire branch;
	wire remain_pc;

	// Instantiate the Unit Under Test (UUT)
	PCPU uut (
		.clk(clk), 
		.rst(rst), 
		.inst_addr(inst_addr), 
		.inst_mem(inst_mem), 
		.data_addr(data_addr), 
		.data_mem(data_mem), 
		.data_we(data_we), 
		.data_write(data_write), 
		.branch(branch), 
		.remain_pc(remain_pc)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		inst_mem = 0;
		data_mem = 0;

		// Wait 100 ns for global reset to finish
		rst = 1;
		#20
		rst = 0;
		#100
      inst_mem = 32'b001000_00000_00100_0000_0000_0000_0011;
		clk = 1;#20;
		clk = 0;#20;
		inst_mem = 32'b001000_00000_00101_0000_0000_0000_0100;	
		clk = 1;#20;
		clk = 0;#20;
		inst_mem = 32'b000000_00100_00101_00110_00000_100000;
		clk = 1;#20;
		clk = 0;#20;
		inst_mem = 32'b001111_00000_00111_1110_0000_0000_0000;
		clk = 1;#20;
		clk = 0;#20;
		inst_mem = 32'b101011_00111_00110_0000_0000_0000_0000;
      clk = 1;#20;
		clk = 0;#20;
clk = 1;#20;
		clk = 0;#20;
clk = 1;#20;
		clk = 0;#20;
clk = 1;#20;
		clk = 0;#20;
clk = 1;#20;
		clk = 0;#20;
		
		// Add stimulus here

	end
      
endmodule

