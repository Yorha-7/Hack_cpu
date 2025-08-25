`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 13:04:34
// Design Name: 
// Module Name: RAM
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

module RAM(
    input wire [15:0] data_in,
    input wire clk,
    input wire we_M,
    input wire reset,
    output reg [15:0] data_out,
    input [15:0] addr
);
    reg [15:0] RAM [0:255];
    integer i;
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i<256; i = i+1) begin
            RAM[i] = 16'h0000;
            end
        end
        if (we_M)
            RAM[addr] <= data_in;
        data_out <= RAM[addr];
    end
endmodule
