`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:24:15 03/05/2019 
// Design Name: 
// Module Name:    GPIO 
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
module GPIO(
	input wire clk,
	input wire rst,
	input wire Start,
	input wire EN,
	input wire [31:0] P_Data,
	output reg [1:0] counter_set,
	output wire [15:0] LED,
	output wire LEDCLK,
	output wire LEDOUT,
	output wire LEDEN,
	output wire LEDCLR,
	output reg [13:0] GPIO
    );
	
	reg [15:0] tmp_led;
	assign LED = tmp_led;
	always @ (negedge clk or posedge rst) begin
		if (rst) begin
			tmp_led <= 8'h2A;
			counter_set <= 2'b00;
		end
		else if (EN) begin
			{GPIO[13:0], tmp_led, counter_set} <= P_Data;
		end
		else begin
			tmp_led <= tmp_led;
			counter_set <= counter_set;
		end
	end
	
	LEDP2S # (.DATA_BITS(16), .DATA_COUNT_BITS(4), .DIR(0))
		P2LED (.clk(clk),
				.rst(rst),
				.Start(Start),
				.PData(~tmp_led),
				.sclk(LEDCLK),
				.sclrn(LEDCLR),
				.sout(LEDOUT),
				.EN(LEDEN));
	
endmodule
