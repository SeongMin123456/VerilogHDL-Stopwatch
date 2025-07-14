`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/21 10:46:52
// Design Name: 
// Module Name: Stopwatch_Control
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

module Stopwatch_Control(
    input CLK,
    input PLS_1k,
    input BTN0,
    input BTN1,
    output [1:0] FSM_State,
    output reg MODE
    );

// BTN0 (Start / Stop) Debouncing
wire BTN0_R, BTN0_F;
Debounce uut7(
    .CLK(CLK),
    .BTN(BTN0),
    .PLS_1k(PLS_1k),
    .BTN_R(BTN0_R),
    .BTN_F(BTN0_F)
    );

// BTN1 (Mode / Clear) Debouncing
wire BTN1_R, BTN1_F;
Debounce uut8(
    .CLK(CLK),
    .BTN(BTN1),
    .PLS_1k(PLS_1k),
    .BTN_R(BTN1_R),
    .BTN_F(BTN1_F)
    );
    
// FSM
reg [1:0] curr_state = 0, next_state = 0;
assign FSM_State = curr_state;
localparam [1:0] IDLE = 2'b00,
                 START = 2'b01,
                 PAUSE = 2'b10;

reg clear_trig = 0;
always @(posedge CLK) begin
    if(clear_trig)  curr_state <= IDLE;
    else            curr_state <= next_state;
end

always @(curr_state, next_state, BTN0_R) begin
    case(curr_state)
        IDLE : begin
            if(BTN0_R)  next_state <= START;
            else        next_state <= IDLE;
        end
        START : begin
            if(BTN0_R)  next_state <= PAUSE;
            else        next_state <= START;
        end
        PAUSE : begin
            if(BTN0_R)  next_state <= START;
            else        next_state <= PAUSE;
        end
    endcase
end

// Mode select Logic
always @(posedge CLK) begin
    if(curr_state == IDLE) begin
        MODE <= 1'b0;
    end else begin
        if(BTN1_F)  MODE <= ~MODE;
    end
end

// Clear Logic
parameter CLK_FREQ = 125_000_000;
reg [31:0] clear_cnt = 0;
reg [1:0] sec1_cnt = 0;
reg clear_state = 0;
always @(posedge CLK) begin
    if(curr_state == IDLE) begin
        clear_cnt <= 0;
        clear_state <= 0;
        sec1_cnt = 0;
        clear_trig = 0;
    end else begin
        if(BTN1_R) clear_state <= 1'b1;
        else if(BTN1_F) clear_state <= 1'b0;
        else begin
            if(clear_state) begin
                if(clear_cnt == (CLK_FREQ - 1)) begin
                    clear_cnt <= 0;
                    sec1_cnt <= sec1_cnt + 1;
                end else begin
                    clear_cnt <= clear_cnt + 1;
                    if(sec1_cnt > 1)    clear_trig <= 1'b1;
                end
            end else begin
                clear_cnt <= 0;
                sec1_cnt <= 0;
            end
        end
    end
end

endmodule