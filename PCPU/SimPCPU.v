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

	reg [31:0] INST_ROM [0:31];
	reg [31:0] DATA_RAM [0:511];
	
	initial begin
		$readmemh("PCPU/SimInstROM.txt", INST_ROM);
	end

	// Inputs
	reg clk;
	reg rst;
	
	// Outputs
	wire [31:0] inst_addr;
	wire [31:0] inst_mem = INST_ROM[inst_addr[31:2]];
	
	wire [31:0] data_addr;
	wire [31:0] data_mem = DATA_RAM[data_addr[31:2]];
	wire data_we;
	wire [31:0] data_write;
	
	always @(posedge clk) begin
		if (data_we)
			DATA_RAM[data_addr[31:2]] <= data_write;
	end

	// Instantiate the Unit Under Test (UUT)
	PCPU uut (
		.clk(clk), 
		.rst(rst), 
		.inst_addr(inst_addr), 
		.inst_mem(inst_mem), 
		.data_addr(data_addr), 
		.data_mem(data_mem), 
		.data_we(data_we), 
		.data_write(data_write)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		#100;
		rst = 1;
		#20;
		rst = 0;
		#100;
	end
	
	always begin
		#10;
		clk = 1;
		#10;
		clk = 0;
	end
      
endmodule

