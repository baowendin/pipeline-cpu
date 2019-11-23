`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:58:47 11/17/2019
// Design Name:   Control
// Module Name:   C:/Users/lifelongwar/Desktop/ISE/pipeline-cpu-master/pipeline-cpu-master/control_sim.v
// Project Name:  OExp09
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module control_sim;

	// Inputs
	reg [5:0] op;
	reg [4:0] rs;
	reg [4:0] rt;
	reg [5:0] func;
	reg rsrtequ;
	reg [4:0] exe_regw_addr;
	reg [4:0] mem_regw_addr;
	reg [4:0] wb_regw_addr;
	reg exe_mem2reg;
	reg mem_wreg;
	reg exe_wreg;
	reg wb_wreg;

	// Outputs
	wire jal;
	wire wreg;
	wire branch;
	wire mem2reg;
	wire wmem;
	wire [3:0] aluc;
	wire aluimm;
	wire shift;
	wire sext;
	wire jr;
	wire regrt;
	wire [1:0] fwdb;
	wire [1:0] fwda;
	wire stall;
	wire jump;
	wire remain_pc;

	// Instantiate the Unit Under Test (UUT)
	Control uut (
		.op(op), 
		.rs(rs), 
		.rt(rt), 
		.func(func), 
		.rsrtequ(rsrtequ), 
		.exe_regw_addr(exe_regw_addr), 
		.mem_regw_addr(mem_regw_addr), 
		.wb_regw_addr(wb_regw_addr), 
		.exe_mem2reg(exe_mem2reg), 
		.mem_wreg(mem_wreg), 
		.exe_wreg(exe_wreg), 
		.wb_wreg(wb_wreg), 
		.jal(jal), 
		.wreg(wreg), 
		.branch(branch), 
		.mem2reg(mem2reg), 
		.wmem(wmem), 
		.aluc(aluc), 
		.aluimm(aluimm), 
		.shift(shift), 
		.sext(sext), 
		.jr(jr), 
		.regrt(regrt), 
		.fwdb(fwdb), 
		.fwda(fwda), 
		.stall(stall), 
		.jump(jump), 
		.remain_pc(remain_pc)
	);

	initial begin
		// Initialize Inputs
		op = 0;
		rs = 0;
		rt = 0;
		func = 0;
		rsrtequ = 0;
		exe_regw_addr = 0;
		mem_regw_addr = 0;
		wb_regw_addr = 0;
		exe_mem2reg = 0;
		mem_wreg = 0;
		exe_wreg = 0;
		wb_wreg = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
		op = 6'b100011;
		rs = 0;
		rt = 0;
		func = 0;
		#20;
		op = 6'b101011;
		#20;
		op = 6'b000000;
		func = 6'b1000000;
        
		// Add stimulus here

	end
      
endmodule

