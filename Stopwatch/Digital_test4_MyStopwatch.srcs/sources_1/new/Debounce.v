`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/21 10:54:38
// Design Name: 
// Module Name: Debounce
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

module Debounce(
    input CLK,
    input BTN,
    input PLS_1k,     // 1kHz
    output BTN_R,
    output BTN_F
    );

reg BTN_ff1 = 0;
reg [4:0] check_cnt = 0;    // until 20
reg [1:0] btn_state = 0;    // 00 : standby, 01 : start, 10 : Rising pulse, 11 : Falling Pulse
reg rising_trig = 0;
reg falling_trig = 0;
assign BTN_R = (rising_trig) ? 1 : 0;
assign BTN_F = (falling_trig) ? 1 : 0;

always @(posedge CLK) begin
    case(btn_state)
        2'b00 : begin
            if(BTN) btn_state <= 2'b01;
            else begin
                btn_state <= 2'b00;
                rising_trig <= 0;
                falling_trig <= 0;
                check_cnt <= 0;
            end
        end
        2'b01 : begin   // start
            if(PLS_1k) begin
                check_cnt <= check_cnt + 1;
                if(BTN_ff1 && BTN)  btn_state <= 2'b01;
                else                btn_state <= 2'b00;
            end else begin
                BTN_ff1 <= BTN;
                if(check_cnt > 19) begin
                    rising_trig <= 1'b1;
                    btn_state <= 2'b10;
                end else begin
                    rising_trig <= 1'b0;
                    btn_state <= 2'b01;
                end
            end
        end
        2'b10 : begin   // rising edge pulse 1clk
            rising_trig <= 1'b0;
            btn_state <= 2'b11;
        end
        2'b11 : begin   // falling edge pulse 1clk
            if(!BTN) begin
                falling_trig <= 1'b1;
                btn_state <= 2'b00;
            end else begin
                falling_trig <= 1'b0;
                btn_state <= 2'b11;
            end
        end
    endcase
end

endmodule
