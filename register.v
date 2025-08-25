`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 12:38:12
// Design Name: 
// Module Name: register
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


module register(
    input wire [15:0] data_in,
    input wire clk,
    input wire we_X,
    input reset,
    output [15:0] X_out 
    );
    reg [15:0] inside;
    initial inside = 0;
    always @(posedge clk) begin
        if (reset) inside <= 0;
        if (we_X) inside <= data_in;
    end
    assign X_out = inside;
endmodule
