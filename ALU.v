`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 10:38:36
// Design Name: 
// Module Name: ALU
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


module ALU(input wire [15:0] x,y,
           input wire [5:0] signal,
           output [15:0] out, 
           output cout
           );
    reg [16:0] sum;
    reg carry;
    reg [15:0] anded;
    reg [15:0] temp_x;
    reg [15:0] temp_y;
    reg [15:0] ans;
    initial begin
        anded = 0; ans = 0; sum = 0;carry = 0;
    end
    always @(*) begin
        temp_x = x;
        temp_y = y;    
        if (signal[5] == 1)
            temp_x = 0;
        if (signal[4] == 1)
            temp_x = ~temp_x;
        if (signal[3] == 1)
            temp_y = 0;
        if (signal[2] == 1)
            temp_y =~temp_y;
        if (signal[1] == 1)
            begin
            sum = temp_x + temp_y;
            ans = sum[15:0];
            carry = sum[16];
            end
        if (signal[1] == 0)
            begin
            anded = temp_x & temp_y;
            ans = anded;
            end
        if (signal[0] == 1)    
            ans = ~ans;          
    end
    assign out = ans;
    assign cout = carry;
endmodule
