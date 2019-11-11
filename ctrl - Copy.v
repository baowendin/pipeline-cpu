`timescale 1ns / 1ps
module ctrl(
	input  clk,
	input  reset,
	input  [31:0] Inst_in,
	input  zero,
	input  overflow,
	input  MIO_ready,
	output reg MemRead,
	output reg MemWrite,
	output reg[2:0]ALU_operation,
	output [4:0]state_out,

	output reg CPU_MIO,
	output reg IorD,
	output reg IRWrite,
	output reg [1:0]RegDst,
	output reg RegWrite,
	output reg [1:0]MemtoReg,
	output reg ALUSrcA,
	output reg [1:0]ALUSrcB,
	output reg [1:0]PCSource,
	output reg PCWrite,
	output reg PCWriteCond,
	output reg Branch,
	output reg ImmSignExt
);
	reg [3:0] state;
	reg [1:0] ALUop;
	assign state_out = state;
	
	parameter 	IF=5'b00000,		ID=5'b00001,		EX_R=5'b00010,		EX_MEM=5'b00011,	EX_I=5'b00100,
				WB_LUI=5'b00101,  	EX_BEQ=5'b00110, 	EX_BNE=5'b00111, 	EX_JR=5'b01000,		EX_JAL=5'b01001, 
				EX_J=5'b01010,		MEM_RD=5'b01011,	MEM_WD=5'b01100, 	WB_R= 5'b01101,		WB_I=5'b01110,     
				WB_LW=5'b01111,  	ERR=5'b11111;	

	`define Datapath_signals  {PCWrite, PCWriteCond,IorD, MemRead, MemWrite,IRWrite,MemtoReg, PCSource, ALUSrcA, ALUSrcB, RegWrite, RegDst, Branch, ALUop, CPU_MIO}
			 
	parameter AND=3'b000, OR=3'b001, ADD=3'b010, SUB=3'b110, NOR=3'b100, SLT=3'b111, XOR=3'b011, SRL=3'b101;

   always @ (posedge clk or posedge reset) begin
		if (reset==1) 
			state <= IF; 
		else
			case (state)
				IF: 
					if(MIO_ready) state <= ID; 
					else state <= IF;
				ID: 
					case (Inst_in[31:26])
						6'b00: begin
							case (Inst_in[5:0])
								6'h08: 	state <= EX_JR;
								default:	state <= EX_R;
							endcase
						end
						6'h08: state <= EX_I; // addi
						6'h0c: state <= EX_I; // andi
						6'h0d: state <= EX_I; // ori
						6'h0e: state <= EX_I; // xori
						6'h0a: state <= EX_I; // slti
						6'h0f: state <= WB_LUI; // lui
						6'h23: state <= EX_MEM; // lw
						6'h2b: state <= EX_MEM; // sw
						6'h04: state <= EX_BEQ; // beq
						6'h05: state <= EX_BNE; // bne
						6'h02: state <= EX_J; // j
						6'h03: state <= EX_JAL; // jal
						default: state <= ERR;	
					endcase
				EX_R:
					state <= WB_R;
				EX_MEM:
					case (Inst_in[31:26])
						6'b100011: state <= MEM_RD; 	//Lw
						6'b101011: state <= MEM_WD; 	//Sw
					endcase
				EX_I:
					state <= WB_I;
				EX_BEQ:
					state <= IF;
				EX_BNE:
					state <= IF;
				EX_JR:
					state <= IF;
				EX_JAL:
					state <= IF;
				EX_J:
					state <= IF;
				EX_JR:
					state <= IF;
				MEM_RD:
					state <= WB_LW;
				MEM_WD:
					state <= IF;
				WB_R:
					state <= IF;
				WB_I:
					state <= IF;
				WB_LW:
					state <= IF;
				WB_LUI:
					state <= IF;
				ERR:
					state <= ERR;
				default: 
					state <= ERR; 
			endcase 			
	end



	always @ * begin
		case (state)
			IF: 		`Datapath_signals = 20'b10010100000010000000;
			ID: 		`Datapath_signals = 20'b00000000000110000000;
			EX_R:		`Datapath_signals = 20'b00000000001000000100;
			EX_MEM:	`Datapath_signals = 20'b00000000001100000000;
			EX_I:		`Datapath_signals = 20'b00000000001100000100;
			EX_BEQ:	`Datapath_signals = 20'b01000000011000001010;
			EX_BNE:	`Datapath_signals = 20'b01000000011000000010;
			EX_JR:	`Datapath_signals = 20'b10000000111000000000;
			EX_JAL:	`Datapath_signals = 20'b10000011100001100000;
			EX_J:		`Datapath_signals = 20'b10000000100000000000;
			MEM_RD:	`Datapath_signals = 20'b00110000000000000001;
			MEM_WD:	`Datapath_signals = 20'b00101000000000000001;
			WB_R:		`Datapath_signals = 20'b00000000000001010000;
			WB_I:		`Datapath_signals = 20'b00000010000001000000;
			WB_LW:	`Datapath_signals = 20'b00000001000001000000;
			WB_LUI:	`Datapath_signals = 20'b00000000000001000000;
			default: `Datapath_signals = 20'b10010100000010000000;
		endcase 			
	end

	always @ * begin
		case(ALUop)
		2'b00: ALU_operation = 3'b010;	//add计算地址
		2'b01: ALU_operation = 3'b110;	//sub比较条件
		2'b10: 
		        case (Inst_in[5:0])
		          6'b100000: ALU_operation = ADD;
		          6'b100010: ALU_operation = SUB;
		          6'b100100: ALU_operation = AND;
		          6'b100101: ALU_operation = OR;
		          6'b100111: ALU_operation = NOR;
		          6'b101010: ALU_operation = SLT;
		         6'b000010: ALU_operation = SRL;       //shfit 1bit right
		         6'b000000: ALU_operation = XOR;	
		         default:   ALU_operation = ADD;
		         endcase
		2'b11: ALU_operation = 3'b111;	        //slti
		endcase		
	end
	
		always @ * begin
			case (Inst_in[31:26])
				6'h08: 		ImmSignExt <= 1'b1; // addi
				6'h0a: 		ImmSignExt <= 1'b1; // slti
				6'h23: 		ImmSignExt <= 1'b1; // lw
				6'h2b: 		ImmSignExt <= 1'b1; // sw
				6'h04: 		ImmSignExt <= 1'b1; // beq
				6'h05: 		ImmSignExt <= 1'b1; // bne
				default: 	ImmSignExt <= 1'b0;
			endcase
		end
	
endmodule
