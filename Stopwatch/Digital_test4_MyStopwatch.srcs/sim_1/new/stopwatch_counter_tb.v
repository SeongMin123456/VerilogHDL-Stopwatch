`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/20 16:36:47
// Design Name: 
// Module Name: stopwatch_counter_tb
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


module stopwatch_counter_tb();

reg CLK;
//reg [5:0] min_cnt, sec_cnt;
//reg [6:0] Usec_cnt;
//wire [3:0] Usec_h, Usec_l, sec_l, min_l;
//wire [2:0] sec_h, min_h;

//H2D uut2(
//    .min_cnt(min_cnt),
//    .sec_cnt(sec_cnt),
//    .Usec_cnt(Usec_cnt),
//    .Usec_h(Usec_h),
//    .Usec_l(Usec_l),
//    .sec_h(sec_h),
//    .sec_l(sec_l),
//    .min_h(min_h),
//    .min_l(min_l)
//    );

//always #5 CLK = ~CLK;

//always @(posedge CLK) begin
//if(Usec_cnt < 99) begin
//    Usec_cnt <= Usec_cnt + 1;
//    end else begin                  // Usec_cnt = 100
//    Usec_cnt <= 0;
//        if(sec_cnt <59) begin
//            sec_cnt <= sec_cnt + 1;
//        end else begin              // sec_cnt = 60
//            sec_cnt <= 0;
//            min_cnt <= min_cnt + 1;
//        end
//    end
//end

//initial begin
//    CLK <= 0;
//    min_cnt <= 0;
//    sec_cnt <= 0;
//    Usec_cnt <= 0;
//end

wire pls;
reg [1:0] FSM;

wire [3:0] Usec_H, Usec_L, sec_L, min_L;
wire [2:0] sec_H, min_H;

Stopwatch_counter uut1(
    .CLK(CLK),
    .FSM_State(FSM),          // 00 : IDLE, 01 : Start, 10 : Pause
    .pls_100(pls),
    .Usec_H(Usec_H),
    .Usec_L(Usec_L),
    .sec_H(sec_H),
    .min_H(min_H),
    .sec_L(sec_L),
    .min_L(min_L)
    );

PLS_100Hz #(.CLK_FREQ(2000)) uut2(
    .CLK(CLK),
    .PLS_100(pls)
    );

always #2 CLK = ~CLK;

initial begin
    CLK <= 1'b0;
    FSM <= 2'b00;
    #10;
    FSM <= 2'b01;
end

endmodule
