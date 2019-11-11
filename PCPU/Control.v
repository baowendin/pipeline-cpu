`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:34:33 11/11/2019 
// Design Name: 
// Module Name:    control 
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
module Control(input wire [5:0]op,
					input wire [4:0]rs,
					input wire [4:0]rt,
					input wire [5:0]func,
					output wire jal,
					output wire wreg,
					output wire mem2reg,
					output wire wmem,
					output wire alu[3:0],
					output wire aluimm,
					output wire shift,
					output wire rsrtequ,
					output wire sext,
					output wire regrt,
					output wire [1:0]fwdb,
					output wire [1:0]fwda,
					output wire stall,
					output wire flush
					
    );
	 parameter INS_R = 6'b000000, RFUNC_SLL = 6'b000000, RFUNC_SRL = 6'b000010, RFUNC_JR = 6'b001000, RFUNC_ADD = 6'b100000, RFUNC_SUB = 6'b100010, RFUNC_AND = 6'b100100,
	 		   RFUNC_OR = 6'b100101, RFUNC_XOR = 6'b100110, RFUNC_NOR = 6'b100111, RFUNC_SLT = 6'b101010;
	 always@(*)
	 begin
	 jal = 0;
	 wreg = 0;
	 mem2reg = 0;
	 wmem = 0;
	 aluimm = 0;
	 shift = 0;
	 rsrtequ = 0;
	 sext = 0;
	 regrt = 0;
	 fwdb = 2'b00;
	 fwda = 2'b00;
		case(op)
			INS_R:
			begin
				case(func)
					RFUNC_SLL:
					begin
						shift = 1;
					end
				endcase	
			end
		endcase
			
			
	 
	 
	 end


endmodule
