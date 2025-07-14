`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/21 14:36:35
// Design Name: 
// Module Name: STOPWATCH
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module STOPWATCH(
    input CLK,
    input BTN0,
    input BTN1,
    output LED0_R,
    output LED0_G,
    output LED1_R,
    output LED1_G,
    output [6:0] DIGIT1,
    output CA1,
    output [6:0] DIGIT2,
    output CA2
    );

wire MODE;
wire [1:0] FSM_State;
wire [3:0] Usec_H, Usec_L, sec_L, min_L;
wire [2:0] sec_H, min_H;
wire CA_W;

assign CA1 = CA_W;
assign CA2 = CA_W;

assign LED0_G = (!MODE && (FSM_State == 2'b01)) ? 1 : 0;
assign LED0_R = (!MODE && (FSM_State == 2'b10)) ? 1 : 0;
assign LED1_G = (MODE && (FSM_State == 2'b01)) ? 1 : 0;
assign LED1_R = (MODE && (FSM_State == 2'b10)) ? 1 : 0;

// 1kHz Pulse
wire PLS_1k;
PLS_1k uut3(
    .CLK(CLK),
    .PLS_1k(PLS_1k)
    );

Stopwatch_Control main1(
    .CLK(CLK),
    .PLS_1k(PLS_1k),
    .BTN0(BTN0),
    .BTN1(BTN1),
    .FSM_State(FSM_State),
    .MODE(MODE)
    );
    
Stopwatch_counter main2(
    .CLK(CLK),
    .PLS_1k(PLS_1k),
    .FSM_State(FSM_State),     // 00 : IDLE, 01 : Start, 10 : Pause
    .Usec_H(Usec_H),
    .Usec_L(Usec_L),
    .sec_H(sec_H),
    .min_H(min_H),
    .sec_L(sec_L),
    .min_L (min_L)
    );
    
Stopwatch_Display main3(
    .CLK(CLK),
    .PLS_1k(PLS_1k),
    .Usec_h(Usec_H),
    .Usec_l(Usec_L),
    .sec_h(sec_H),
    .sec_l(sec_L),
    .min_h(min_H),
    .min_l(min_L),
   .MODE(MODE),
    .DIGIT1(DIGIT1),    // Min or Sec
    .DIGIT2(DIGIT2),    // Sec or Usec
    .CA(CA_W)
    );
    
endmodule