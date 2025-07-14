`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/20 12:47:42
// Design Name: 
// Module Name: Stopwatch_counter
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

module Stopwatch_counter(
    input CLK,
    input PLS_1k,
    input [1:0] FSM_State,          // 00 : IDLE, 01 : Start, 10 : Pause
    output [3:0] Usec_H, Usec_L,    // Under sec [0~99]
    output [2:0] sec_H, min_H,     // sec [0 ~ 59]
    output [3:0] sec_L, min_L      // min [0 ~ 59]
    );

// 100Hz Pulse Clock
reg [2:0] PLS_cnt;
wire pls_100;
always @(posedge CLK) begin
    if(FSM_State == 2'b00) begin
        PLS_cnt <= 0;
    end else if(FSM_State == 2'b10) begin
        PLS_cnt <= PLS_cnt;
    end else begin
        if(pls_100) begin
            if(PLS_cnt < 5) PLS_cnt <= PLS_cnt + 1;
            else            PLS_cnt <= PLS_cnt;
        end else begin
            PLS_cnt <= 0;
        end
    end
end

// 100Hz Pulse Module Instance
PLS_100Hz uut1(
    .CLK(CLK),
    .TICK(PLS_1k),
    .PLS_100(pls_100)
    );

// Stopwatch Time Counter Logic
reg [5:0] sec_cnt, min_cnt;
reg [6:0] Usec_cnt;
wire hour_trig = (min_cnt == 60) ? 1 : 0;

wire [3:0] Usec_h, Usec_l, sec_l, min_l;
wire [2:0] sec_h, min_h;

assign Usec_H = Usec_h;
assign Usec_L = Usec_l;
assign sec_H = sec_h;
assign sec_L = sec_l;
assign min_H = min_h;
assign min_L = min_l;

H2D uut2(
    .min_cnt(min_cnt),
    .sec_cnt(sec_cnt),
    .Usec_cnt(Usec_cnt),
    .Usec_h(Usec_h),
    .Usec_l(Usec_l),
    .sec_h(sec_h),
    .sec_l(sec_l),
    .min_h(min_h),
    .min_l(min_l)
    );

always @(posedge CLK) begin
    if(FSM_State == 2'b00) begin
        min_cnt <= 0;
        sec_cnt <= 0;
        Usec_cnt <= 0;
    end else if(FSM_State == 2'b10) begin
        min_cnt <= min_cnt;
        sec_cnt <= sec_cnt;
        Usec_cnt <= Usec_cnt;
    end else begin
        if(PLS_cnt == 1) begin
            if(!hour_trig) begin
                if(Usec_cnt < 99) begin
                    Usec_cnt <= Usec_cnt + 1;
                end else begin                  // Usec_cnt = 100
                    Usec_cnt <= 0;
                    if(sec_cnt <59) begin
                        sec_cnt <= sec_cnt + 1;
                    end else begin              // sec_cnt = 60
                        sec_cnt <= 0;
                        min_cnt <= min_cnt + 1;
                    end
                end
            end else begin                      // min_cnt = 60
                min_cnt <= min_cnt;
                sec_cnt <= sec_cnt;
                Usec_cnt <= Usec_cnt;
            end
        end else begin
            min_cnt <= min_cnt;
            sec_cnt <= sec_cnt;
            Usec_cnt <= Usec_cnt;
        end
    end
end

endmodule
