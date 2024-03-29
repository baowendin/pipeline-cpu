module Control(
	input wire [5:0] op,
	input wire [4:0] rs,
	input wire [4:0] rt,
	input wire [5:0] func,
	input wire rsrtequ,
	input wire [4:0] exe_regw_addr,
	input wire [4:0] mem_regw_addr,
	input wire exe_wreg,
	input wire exe_mem2reg,
	input wire mem_wreg,
	input wire mem_mem2reg,
	
	output reg jal,
	output reg wreg,
	output reg branch,
	output reg mem2reg,
	output reg wmem,
	output reg [3:0] aluc,
	output reg aluimm,
	output reg shift,
	output reg sext,
	output reg jr, 
	output reg regrt,
	output reg [1:0] fwdb,
	output reg [1:0] fwda,
	output reg stall,
	output reg jump,
	output reg cancel_next
);
	reg rs_used, rt_used;
    reg branch_t, wreg_t, wmem_t;
	parameter INS_R = 6'b000000, RFUNC_SLL = 6'b000000, RFUNC_SRL = 6'b000010, RFUNC_JR = 6'b001000, RFUNC_ADD = 6'b100000, RFUNC_SUB = 6'b100010, RFUNC_AND = 6'b100100,
			RFUNC_OR = 6'b100101, RFUNC_XOR = 6'b100110, RFUNC_NOR = 6'b100111, RFUNC_SLT = 6'b101010;
	parameter  INS_J = 6'b000010, INS_JAL = 6'b000011, INS_BEQ = 6'b000100, INS_BNE = 6'b000101, INS_LUI = 6'b001111;
	parameter INS_ADDI = 6'b001000, INS_ANDI = 6'b001100, INS_ORI = 6'b001101, INS_XORI = 6'b001110, INS_LW = 6'b100011, INS_SW = 6'b101011;
    parameter RFUNC_ADDU = 6'b100001, RFUNC_SUBU = 6'b100011, RFUNC_SLTU = 6'b101011, RFUNC_SRA = 6'b000011, RFUNC_SLLV = 6'b000100, RFUNC_SRLV = 6'b000110,RFUNC_SRAV = 6'b000111;
    parameter INS_ADDIU = 6'b001001, INS_SLTI = 6'b001011, INS_SLTIU = 6'b001011;
	`include "Parameters.v"

	always @(*) begin
		rs_used = 0;
		rt_used = 0;
		branch_t = 0;
		jr = 0;
		jump = 0;
		jal = 0;
		wreg_t = 0;
		mem2reg = 0;
		wmem_t = 0;
		aluc = 0;
		aluimm = 0;
		shift = 0;
		sext = 0;
		regrt = 0;
		case(op)
			INS_R: begin
				case(func)
					RFUNC_SRL: begin
						aluc = ALUC_SRL;
						shift = 1'b1;
						regrt = 1'b1;
						wreg_t = 1'b1;
						rt_used = 1;
					end
					RFUNC_JR: begin
						// mem2reg = 1'b1;
						rs_used = 1'b1;
						branch_t = 1'b1;
						jr = 1;
					end					
                    RFUNC_ADD: begin
						aluc = ALUC_ADD;
						regrt = 1'b1;
						wreg_t = 1'b1;
						rs_used = 1;
						rt_used = 1;
					end
					RFUNC_SUB,RFUNC_SUBU: begin
						regrt = 1'b1;
						wreg_t = 1'b1;
						aluc = ALUC_SUB;	
						rs_used = 1'b1;
						rt_used = 1'b1;					
					end
					RFUNC_AND,RFUNC_ADDU: begin
						aluc = ALUC_AND;
						wreg_t = 1'b1;
						regrt = 1'b1;
						rs_used = 1'b1;
						rt_used = 1'b1;
					end
                    RFUNC_NOR: begin
						aluc = ALUC_NOR;
						wreg_t = 1'b1;
						regrt = 1'b1;
						rs_used = 1'b1;
						rt_used = 1'b1;
					end
					RFUNC_OR: begin
						aluc = ALUC_OR;
						wreg_t = 1'b1;
						regrt = 1'b1;
						rs_used = 1'b1;
						rt_used = 1'b1;
					end
					RFUNC_XOR: begin
						aluc = ALUC_XOR;
						wreg_t = 1'b1;
						regrt = 1'b1;
						rs_used = 1'b1;
						rt_used = 1'b1;
					end
					RFUNC_SLT: begin
						aluc = ALUC_SLT;
						wreg_t = 1;
						regrt = 1'b1;
						rs_used = 1'b1;
						rt_used = 1'b1;
					end
					RFUNC_SLTU: begin
						aluc = ALUC_SLTU;
						wreg_t = 1;
						regrt = 1'b1;
						rs_used = 1'b1;
						rt_used = 1'b1;
					end
                    RFUNC_SLL: begin
                        aluc = ALUC_SLL;
                        wreg_t = 1;
                        regrt = 1;
                        rt_used = 1;
                        shift = 1;
                    end
                    RFUNC_SRL: begin
                        aluc = ALUC_SRL;
                        wreg_t = 1;
                        regrt = 1;
                        rt_used = 1;
                        shift = 1;
                    end
                    RFUNC_SRA: begin
                        aluc = ALUC_SRA;
                        wreg_t = 1;
                        regrt = 1;
                        rt_used = 1;
                        shift = 1;
                    end
                    RFUNC_SLLV: begin
                        aluc = ALUC_SLLV;
                        wreg_t = 1;
                        regrt = 1;
                        rs_used = 1;
                        rt_used = 1;
                    end
                    RFUNC_SRLV: begin
                        aluc = ALUC_SRLV;
                        wreg_t = 1;
                        regrt = 1;
                        rt_used = 1;
                        rs_used = 1;                   
                    end
                    RFUNC_SRAV: begin
                        aluc = ALUC_SRAV;
                        wreg_t = 1;
                        regrt = 1;
                        rt_used = 1;
                        rs_used = 1;
                    end                   
				endcase	
			end
			INS_J: begin
				jump = 1'b1;
				branch_t = 1'b1;
			end
			INS_JAL: begin
				jal = 1'b1;
				jump = 1;
				wreg_t = 1'b1;
				aluc = ALUC_ADD;
				branch_t = 1'b1;
			end
			INS_BEQ: begin
				aluc = ALUC_ADD;
				aluimm = 1'b1;
				if (rsrtequ == 1'b1) branch_t = 1'b1;
				sext = 1'b1;
				rs_used = 1'b1;
				rt_used = 1'b1;
			end
			INS_BNE: begin
				aluc = ALUC_ADD;
				aluimm = 1'b1;
				if (rsrtequ == 1'b0) branch_t = 1'b1;
				sext = 1'b1;
				rs_used = 1'b1;
				rt_used = 1'b1;
			end
			INS_ADDI,INS_ADDIU: begin
				aluc = ALUC_ADD;
				aluimm = 1'b1;
				sext = 1'b1;
				wreg_t = 1'b1;
				rs_used = 1'b1;				
			end
			INS_ANDI: begin
				aluc = ALUC_AND;
				aluimm = 1'b1;
				wreg_t = 1'b1;
				rs_used = 1'b1;			
			end
			INS_ORI: begin
				aluc = ALUC_OR;
				aluimm = 1'b1;
				wreg_t = 1'b1;	
				rs_used = 1'b1;			
			end
			INS_XORI: begin
				aluc = ALUC_XOR;
				aluimm = 1'b1;
				wreg_t = 1'b1;	
				rs_used = 1'b1;			
			end
			INS_LUI: begin
				aluc = ALUC_LUI;			
				aluimm = 1;	
				wreg_t = 1'b1;
			end
			INS_LW: begin
				aluc = ALUC_ADD;
				aluimm = 1'b1;
				sext = 1'b1;
				mem2reg = 1'b1;
				rs_used = 1'b1;
				wreg_t = 1'b1;
			end
			INS_SW: begin
				aluc = ALUC_ADD;
				aluimm = 1'b1;
				sext = 1'b1;
				wmem_t = 1'b1;
				rs_used = 1'b1;
				rt_used = 1'b1;
			end
            INS_SLTI,INS_SLTIU: begin
                aluc = ALUC_SLT;
				wreg_t = 1;
				rs_used = 1'b1;
                sext = 1;
                aluimm = 1;
            end
		endcase	      
	end

	// the stall situation, including two hazards
	always @(*) begin
		stall = 0;
		branch = 0;
		wreg = 0;
		wmem = 0;
		cancel_next = 0;
		if (rs_used && rs != 0) begin
			if (exe_regw_addr == rs && exe_mem2reg) begin
				stall = 1'b1;
			end
		end 
		else if (rt_used && rt != 0) begin
			if (exe_regw_addr == rt && exe_mem2reg) begin
				stall = 1'b1;
			end
		end
		branch = stall ? 0 : branch_t;
       		wreg = stall ? 0 : wreg_t;
       		wmem = stall ? 0 : wmem_t;
		if (branch) begin
			cancel_next = 1;
		end
		
	end

	// the forward situation
	always @(*) begin
		fwda = 2'b00;
		fwdb = 2'b00;
		if (rs_used && rs != 0) begin
			if (exe_regw_addr == rs && exe_wreg)
				fwda = 2'b01;
			else if (mem_regw_addr == rs && mem_wreg && !mem_mem2reg)
				fwda = 2'b10;
			else if (mem_regw_addr == rs && mem_wreg && mem_mem2reg)
				fwda = 2'b11;
		end
		if (rt_used && rt != 0) begin
			if (exe_regw_addr == rt && exe_wreg)
				fwdb = 2'b01;
			else if (mem_regw_addr == rt && mem_wreg && !mem_mem2reg)
				fwdb = 2'b10;
			else if (mem_regw_addr == rt && mem_wreg && mem_mem2reg)
				fwdb = 2'b11;
		end
	end
endmodule
