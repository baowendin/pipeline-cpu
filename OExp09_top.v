`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:47:13 05/03/2019 
// Design Name: 
// Module Name:    OExp09_top 
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
module OExp09_top(
	input wire RSTN,
	input wire [3:0] BTN_y,
	output wire [4:0] BTN_x,
	input wire [15:0] SW,
	input wire clk200N,
	input wire clk200P,
	
	
	output wire seg_clk,
	output wire seg_sout,
	output wire SEG_PEN,
	output wire led_clk,
	output wire led_sout,
	output wire LED_PEN,
	
	output wire [7:0] SEGMENT,
	output wire [3:0] AN,
	output wire [7:0] LED,
	output wire Buzzer
    );
	wire CR;
	wire RDY;
	wire clk_200MHz;
	wire rst, Clk_CPU;
	wire [15:0] SW_OK;
	wire [3:0] BTN_OK, Pulse;
	wire [7:0] blink;
	wire [31:0] Div, Ai, Bi;
	wire [4:0] Key_out;
	wire seg_clrn;
	wire readn;
	wire led_clrn;
	wire counter0_out, counter1_out, counter3_out, counter_we;
	wire [31:0] counter_out;
	wire [1:0] counter_ch;
		
	wire GPIOF0;
	wire [15:0] LED_out;
	wire [31:0] CPU2IO;
	clk_diff  Q1(
	.clk200P(clk200P),
	.clk200N(clk200N),
	.clk200MHz(clk_200MHz)
	);

	clk_div U8 (
    .clk(clk_200MHz), 
    .rst(rst), 
    .SW2(SW_OK[2]), 
    .clkdiv(Div), 
    .Clk_CPU(Clk_CPU)
   );
	 
	 wire clk_100mhz = Div[0];
	
	SAnti_jitter U9 (
    .clk(clk_100mhz), 
    .RSTN(RSTN), 
    .readn(readn), 
    .Key_y(BTN_y), 
    .Key_x(BTN_x), 
    .SW(SW), 
    .Key_out(Key_out), 
    .Key_ready(RDY), 
    .pulse_out(Pulse), 
    .BTN_OK(BTN_OK), 
    .SW_OK(SW_OK), 
    .CR(CR), 
    .rst(rst)
    );
	
	SEnter_2_32 M4 (
    .clk(clk_100mhz), 
    .BTN(BTN_OK[2:0]), 
    .Ctrl({SW_OK[7:5], SW_OK[15], SW_OK[0]}), 
    .D_ready(RDY), 
    .Din(Key_out), 
    .readn(readn), 
    .Ai(Ai), 
    .Bi(Bi), 
    .blink(blink)
    );
	
	wire IO_clk = ~Clk_CPU;
	
	wire mem_w;
	wire [31:0] inst, PC, Addr_out, Data_in, Data_out;
	wire [4:0] State;
	
	PCPU U1 (
    .INT(counter0_out), 
    .clk(Clk_CPU), 
    .reset(rst), 
    .MIO_ready(1'b1), 
    .mem_w(mem_w), 
    .PC_out(PC), 
    .inst_out(inst), 
	 .Data_in(Data_in),
    .Data_out(Data_out), 
    .Addr_out(Addr_out), 
    .CPU_MIO(), 
    .state(State)
    );
	
	wire wea;
	wire [9:0] addra;
	wire [31:0] dina, douta;
	
	RAM_B U3 (
	  .clka(clk_100mhz), // input clka
	  .wea(wea), // input [0 : 0] wea
	  .addra(addra), // input [9 : 0] addra
	  .dina(dina), // input [31 : 0] dina
	  .douta(douta) // output [31 : 0] douta
	);

	
	Counter_x U10 (
    .clk(IO_clk), 
    .rst(rst), 
    .clk0(Div[8]), 
    .clk1(Div[9]), 
    .clk2(Div[11]), 
    .counter_we(counter_we), 
    .counter_val(CPU2IO), 
    .counter_ch(counter_ch), 
    .counter0_OUT(counter0_out), 
    .counter1_OUT(counter1_out), 
    .counter2_OUT(counter2_out), 
    .counter_out(counter_out)
    );
	

	GPIO U7 (
    .clk(IO_clk), 
    .rst(rst), 
    .Start(Div[20]), 
    .EN(GPIOF0), 
    .P_Data(CPU2IO), 
    .counter_set(counter_ch), 
    .LED(LED_out), 
    .LEDCLK(led_clk), 
    .LEDOUT(led_sout), 
    .LEDEN(LED_PEN), 
    .LEDCLR(led_clrn), 
    .GPIO()
    );
	
	wire MultiEN;
	wire [31:0] Disp_num;
	wire [7:0] point_out, LE_out;
	Multi_8CH32 U5 (
    .clk(IO_clk), 
    .rst(rst), 
    .EN(MultiEN), 
    .Test(SW_OK[7:5]), 
    .point_in({Div[31:0], Div[31:13], State[4:0], 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), 
    .blink_in(64'b0), 
    .Data0(CPU2IO), 
    .Test_data1({1'b0, 1'b0, PC[31:2]}), 
    .Test_data2(inst), 
    .Test_data3(counter_out), 
    .Test_data4(Addr_out), 
    .Test_data5(Data_out), 
    .Test_data6(Data_in), 
    .Test_data7(PC), 
    .point_out(point_out), 
    .blink_out(LE_out), 
    .Disp_num(Disp_num)
    );
	
   Display U6 (
	.flash(Div[25]), 
	.LES(LE_out), 
	.point(point_out), 
	.Hexs(Disp_num), 
	.clk(clk_100mhz), 
	.rst(rst), 
	.Start(Div[20]), 
	.Text(SW_OK[0]), 
	.SEGCLK(seg_clk), 
	.SEGOUT(seg_sout), 
	.SEGEN(SEG_PEN), 
	.SEGCLR(seg_clrn)
   );

	
	MIO_BUS U4 (
    .clk(clk_100mhz), 
    .rst(rst), 
    .BTN(BTN_OK), 
    .SW(SW_OK), 
    .mem_w(mem_w), 
    .Cpu_data2bus(Data_out), 
    .addr_bus(Addr_out), 
    .ram_data_out(douta), 
    .led_out(LED_out), 
    .counter_out(counter_out), 
    .counter0_out(counter0_out), 
    .counter1_out(counter1_out), 
    .counter2_out(counter2_out), 
    .Cpu_data4bus(Data_in), 
    .ram_data_in(dina), 
    .ram_addr(addra), 
    .data_ram_we(wea), 
    .GPIOf0000000_we(GPIOF0), 
    .GPIOe0000000_we(MultiEN), 
    .counter_we(counter_we), 
    .Peripheral_in(CPU2IO)
    );
	
   DispNum U61 (
	.AN(AN), 
	.HEXS(Disp_num), 
	.LES(LE_out), 
	.SW0(SW_OK[0]), 
	.Scan({SW_OK[1], Div[19:18]}), 
	.flash(Div[25]), 
	.SEG_OUT(SEGMENT), 
	.point(point_out)
   );
   
   PIO U71 (
    .clk(IO_clk), 
    .rst(rst), 
    .EN(GPIOF0), 
    .PData_in(CPU2IO), 
    .counter_set(), 
    .LED_out(LED), 
    .GPIOf0()
    );


	assign Buzzer = 1'b0;

endmodule
