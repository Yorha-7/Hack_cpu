`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2025 19:36:53
// Design Name: 
// Module Name: display
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


module display(
    input [15:0] data_in,
    output [6:0]seg_out
    );
    reg [6:0]data_out;
    always @(*) begin
        case(data_in)
            16'h0000: data_out = 7'b0000001;
            16'h0001: data_out = 7'b1001111;
            16'h0002: data_out = 7'b0010010;
            16'h0003: data_out = 7'b0000110;
            16'h0004: data_out = 7'b1001100;
            16'h0005: data_out = 7'b0100100;
            16'h0006: data_out = 7'b0100000;
            16'h0007: data_out = 7'b0001111;
            16'h0008: data_out = 7'b0000000;
            16'h0009: data_out = 7'b0000100;
            16'h000a: data_out = 7'b0001000;
            16'h000b: data_out = 7'b1100000;
            16'h000c: data_out = 7'b0110001;
            16'h000d: data_out = 7'b1000010;
            16'h000e: data_out = 7'b0010000;
            16'h000f: data_out = 7'b0111000;
            default: data_out = 7'b0000000;
        endcase
    end
    assign seg_out = data_out;
endmodule
