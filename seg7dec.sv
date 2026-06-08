`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ChipDv
// Engineer:  Waseem Ghulam
// 
// Create Date: 06/08/2026 11:39:22 PM
// Design Name: 
// Module Name: seg7dec
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


module seg7dec (
    input  logic [3:0] digit,
    output logic [6:0] seg
);
    always_comb begin
        case (digit)
            // complete BCD to 7-segment decoding (Active LOW)
            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;
            default: seg = 7'b1111111; // Blank for invalid BCD
        endcase
    end
endmodule