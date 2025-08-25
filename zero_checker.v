`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 15:59:10
// Design Name: 
// Module Name: zero_checker
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


module zero_checker(
    input wire [15:0] data_in,
    output reg Zy
    );
    always @(*) begin
        if (data_in == 0) Zy <= 1;
        else Zy <= 0;
    end
endmodule
