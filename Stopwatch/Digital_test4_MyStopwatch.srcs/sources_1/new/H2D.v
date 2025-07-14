`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/20 17:45:35
// Design Name: 
// Module Name: H2D
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

module H2D(
    input [5:0] min_cnt,
    input [5:0] sec_cnt,
    input [6:0] Usec_cnt,
    output reg [3:0] Usec_h,
    output reg [3:0] Usec_l,
    output reg [2:0] sec_h,
    output reg [3:0] sec_l,
    output reg [2:0] min_h,
    output reg [3:0] min_l
    );

always @(*) begin
    if(Usec_cnt < 10)   begin
        Usec_h = 4'd0;
    end else if(Usec_cnt < 20) begin
        Usec_h = 4'd1;
    end else if(Usec_cnt < 30) begin
        Usec_h = 4'd2;
    end else if(Usec_cnt < 40) begin
        Usec_h = 4'd3;
    end else if(Usec_cnt < 50) begin
        Usec_h = 4'd4;
    end else if(Usec_cnt < 60) begin
        Usec_h = 4'd5;
    end else if(Usec_cnt < 70) begin
        Usec_h = 4'd6;
    end else if(Usec_cnt < 80) begin
        Usec_h = 4'd7;
    end else if(Usec_cnt < 90) begin
        Usec_h = 4'd8;
    end else begin
        Usec_h = 4'd9;
    end
    
    Usec_l = Usec_cnt - ((Usec_h << 3) + (Usec_h << 1));   // Usec_cnt - Usec_h*10
end

always @(*) begin
    if(sec_cnt < 10)   begin
        sec_h = 4'd0;
    end else if(sec_cnt < 20) begin
        sec_h = 4'd1;
    end else if(sec_cnt < 30) begin
        sec_h = 4'd2;
    end else if(sec_cnt < 40) begin
        sec_h = 4'd3;
    end else if(sec_cnt < 50) begin
        sec_h = 4'd4;
    end else begin
        sec_h = 4'd5;
    end
    
    sec_l = sec_cnt - ((sec_h << 3) + (sec_h << 1));   // sec_cnt - sec_h*10
end

always @(*) begin
    if(min_cnt < 10)   begin
        min_h = 4'd0;
    end else if(min_cnt < 20) begin
        min_h = 4'd1;
    end else if(min_cnt < 30) begin
        min_h = 4'd2;
    end else if(min_cnt < 40) begin
        min_h = 4'd3;
    end else if(min_cnt < 50) begin
        min_h = 4'd4;
    end else if(min_cnt < 60) begin
        min_h = 4'd5;
    end else begin
        min_h = 4'd6;
    end
    
    min_l = min_cnt - ((min_h << 3) + (min_h << 1));   // min_cnt - min_h*10
end

endmodule