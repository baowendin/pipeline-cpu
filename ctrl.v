`timescale 1ns / 1ps
module 	ctrl(
	input  clk,
	input  reset,
	input  [31:0] Inst_in,
	input  zero,
	input  overflow,
	input  MIO_ready,		//外部输入=1
	output reg [2:0]ALU_operation,	 //ALU_Control
	output reg [4:0]state,

	output reg mem_w,
	output reg CPU_MIO,
	output reg IorD,
	output reg IRWrite,
	output reg [1:0]RegDst,		 //预留到2位
	output reg RegWrite,
	output reg [1:0]MemtoReg,		 //预留到2位
	output reg ALUSrcA,
	output reg [1:0]ALUSrcB,
	output reg [1:0]PCSource,
	output reg PCWrite,
	output reg PCWriteCond,
	output reg Branch,
	output reg ImmSignExt
);

	wire [5:0] Fun;
	wire [5:0] OPcode;
	assign Fun = Inst_in[5:0];
	assign OPcode = Inst_in[31:26];

	
	reg [4:0] D;
	parameter IF = 5'b00000, ID = 5'b00001, Ex_R = 5'b00010, Ex_Mem =5'b00011, Ex_I = 5'b00100,
	 Lui_WB=5'b00101, Ex_beq = 5'b00110, Ex_bne = 5'b00111, Ex_Jr = 5'b01000, Ex_Jal=5'b01001, 
	 Ex_J = 5'b01010, MEM_RD=5'b01011, MEM_WD= 5'b01100, WB_R = 5'b01101, WB_I=5'b01110, WB_LW=5'b01111, Error=5'b11111;			
	parameter AND=3'b000, OR=3'b001, ADD=3'b010, SUB=3'b110, NOR=3'b100, SLT=3'b111, XOR=3'b011, SRL=3'b101;
	`define Datapath_signals  {PCWrite, PCWriteCond,IorD, mem_w,IRWrite, MemtoReg,\
		PCSource, ALUSrcA, ALUSrcB, RegWrite, RegDst, Branch, CPU_MIO}
	   
	assign Rtype  =  ~|OPcode; 						//if OP=000000 then Rtype = 1
	assign ALUI = (OPcode == 6'h8 || OPcode == 6'hC || OPcode == 6'hD ||
		OPcode == 6'hE || OPcode == 6'hA) ? 1 : 0;
	assign LS = (OPcode == 6'b100011 || OPcode == 6'b101011) ? 1 : 0;		//if OP=10x011 then LS = 1
	assign IBeq = (OPcode == 6'b000100) ? 1 : 0;	//if OP=000100 then Ibeq = 1
	assign IBne = (OPcode == 6'b000101) ? 1: 0;
	assign Jump = (OPcode == 6'b000010) ? 1 : 0;	//if OP=000010 then Exe_Jump = 1
	assign Jr = (Rtype && Fun == 6'h8) ? 1 : 0;
	assign Jal = (OPcode == 6'h3) ? 1 : 0;
	assign Lui = (OPcode == 6'hf) ? 1 : 0;
	assign Load = (OPcode == 6'b100011) ? 1 : 0;	//if OP=100011 then Load = 1
	assign Store = (OPcode == 6'b101011) ? 1 : 0;	//if OP=101011 then Store = 1
	
	always @* begin
		case (state)
			IF: 
				D = ID;
			ID:
				if (LS) begin
					D = Ex_Mem;
				end
				else if (Lui) begin
					D = Lui_WB;
				end
				else if (IBeq) begin
					D = Ex_beq;
				end
				else if (IBne) begin
					D = Ex_bne;
				end
				else if (Jump) begin
					D = Ex_J;
				end
				else if (Jr) begin
					D = Ex_Jr;
				end
				else if (Jal) begin
					D = Ex_Jal;
				end
				else if (ALUI) begin
					D = Ex_I;
				end
				else if (Rtype) begin
					D = Ex_R;
				end
				else begin
					D = Error;
				end
			Ex_Mem:
				if (Load) begin
					D = MEM_RD;
				end
				else if (Store) begin
					D = MEM_WD;
				end
			MEM_RD:
				D = WB_LW;
			WB_LW:
				D = IF;
			MEM_WD:
				if (MIO_ready) begin
					D = IF;
				end
				else begin
					D = MEM_WD;
				end
			Lui_WB:
				D = IF;
			Ex_beq:
				D = IF;
			Ex_bne:
				D = IF;
			Ex_J:
				D = IF;
			Ex_Jr:
				D = IF;
			Ex_Jal:
				D = IF;
			Ex_R:
				D = WB_R;
			WB_R:
				D = IF;
			Ex_I:
				D = WB_I;
			WB_I:
				D = IF;
		default: D = Error;
		endcase
	end

	always @ * begin
	    case (state)				//state
			IF:
				`Datapath_signals = 17'b10001000000100001;
			ID:
				`Datapath_signals = 17'b00000000001100000;
			Ex_R:
				`Datapath_signals = 17'b00000000010000000;
			Ex_Mem:
				`Datapath_signals = 17'b00000000011000000;
			Ex_I:
				`Datapath_signals = 17'b00000000011000000;
			Lui_WB:
				`Datapath_signals = 17'b00000100010010000;
			Ex_beq:
				`Datapath_signals = 17'b01000000110000010;
			Ex_bne:
				`Datapath_signals = 17'b01000000110000000;
			Ex_Jr:
				`Datapath_signals = 17'b10000001110000000;
			Ex_Jal:
				`Datapath_signals = 17'b10000111001111000;
			Ex_J:
				`Datapath_signals = 17'b10000001001100000;
			MEM_RD:
				`Datapath_signals = 17'b00100000011000001;
			MEM_WD:
				`Datapath_signals = 17'b00110000011000001;
			WB_R:
				`Datapath_signals = 17'b00000000010010100;
			WB_I:
				`Datapath_signals = 17'b00000000011010000;
			WB_LW:
				`Datapath_signals = 17'b00000010000010000;
		default:
			`Datapath_signals = 17'b10001000000100001;
	    endcase
	end
	
	always @* begin
		ImmSignExt = 1'b0;
		case (state)
			Ex_R:
				case (Fun)
					6'h20: ALU_operation = ADD;
					6'h22: ALU_operation = SUB;
					6'h2A: ALU_operation = SLT;
					6'h24: ALU_operation = AND;
					6'h25: ALU_operation = OR;
					6'h26: ALU_operation = XOR;
					6'h27: ALU_operation = NOR;
					6'h2: ALU_operation = SRL;
				default:
					ALU_operation = ADD;
				endcase
			Ex_I:
				case (OPcode)
					6'h8: begin
						ALU_operation = ADD;
						ImmSignExt = 1'b1;
					end
					6'hC: ALU_operation = AND;
					6'hD: ALU_operation = OR;
					6'hE: ALU_operation = XOR;
					6'hA: begin
						ALU_operation = SLT;
						ImmSignExt = 1'b1;
					end
				default:
					ALU_operation = ADD;
				endcase
			Ex_beq:
				ALU_operation = SUB;
			Ex_bne:
				ALU_operation = SUB;
		default:
			ALU_operation = ADD;
		endcase
	end
	
	always @(posedge clk or posedge reset) begin
		if (reset == 1) begin
			state = IF;
		end
		else begin
			state = D;
		end
	end

	
endmodule
