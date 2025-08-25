`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2025 21:51:38
// Design Name: 
// Module Name: ssd
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

module ssd(
    input clk,               // Basys3 100 MHz input
    input [15:0] data_in,    // 16-bit input from RAM/CPU
    output reg [6:0] seg,    // 7-segment segments
    output reg [3:0] an      // 7-segment anodes
);
    // --- Internal BCD digits ---
    reg [3:0] thousands, hundreds, tens, ones;
    integer i;

    // --- Internal refresh counter for multiplexing ---
    reg [16:0] refresh_counter = 0; // slower than 100 MHz
    reg [1:0] sel = 0;

    // --- Double Dabble algorithm ---
    reg [27:0] shift;

    always @(*) begin
        // Initialize shift register
        shift = 28'd0;
        shift[15:0] = data_in;

        // Double Dabble: shift left 16 times
        for(i=0; i<16; i=i+1) begin
            if(shift[19:16] >= 5) shift[19:16] = shift[19:16] + 3;
            if(shift[23:20] >= 5) shift[23:20] = shift[23:20] + 3;
            if(shift[27:24] >= 5) shift[27:24] = shift[27:24] + 3;
            shift = shift << 1;
        end

        // Assign BCD digits (truncated >9999)
        ones      = shift[19:16];
        tens      = shift[23:20];
        hundreds  = shift[27:24];
        thousands = shift[27:24] >= 10 ? 4'd9 : shift[27:24]; // limit thousands to 9
    end

    // --- Refresh counter for multiplexing ---
    always @(posedge clk) refresh_counter <= refresh_counter + 1;
    always @(posedge clk) sel <= refresh_counter[16:15]; // adjust MSB for speed (~1 kHz per digit)

    // --- 7-segment decoder function ---
    function [6:0] bcd7seg;
        input [3:0] bcd;
        begin
            case(bcd)
                4'd0: bcd7seg = 7'b1000000;
                4'd1: bcd7seg = 7'b1111001;
                4'd2: bcd7seg = 7'b0100100;
                4'd3: bcd7seg = 7'b0110000;
                4'd4: bcd7seg = 7'b0011001;
                4'd5: bcd7seg = 7'b0010010;
                4'd6: bcd7seg = 7'b0000010;
                4'd7: bcd7seg = 7'b1111000;
                4'd8: bcd7seg = 7'b0000000;
                4'd9: bcd7seg = 7'b0010000;
                default: bcd7seg = 7'b1111111;
            endcase
        end
    endfunction

    // --- Multiplexing logic ---
    always @(*) begin
        case(sel)
            2'b00: begin an = 4'b1110; seg = bcd7seg(ones); end
            2'b01: begin an = 4'b1101; seg = bcd7seg(tens); end
            2'b10: begin an = 4'b1011; seg = bcd7seg(hundreds); end
            2'b11: begin an = 4'b0111; seg = bcd7seg(thousands); end
        endcase
    end
endmodule
