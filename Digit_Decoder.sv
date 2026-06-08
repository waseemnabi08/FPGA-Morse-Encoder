module Digit_Decoder(
    input  logic [3:0] digit,
    output logic [4:0] morse
);
    always_comb begin
        case(digit)
            // MSB is transmitted first. 
            // e.g., for 1: .---- (0, 1, 1, 1, 1) -> 5'b01111
            4'b0000: morse = 5'b11111; // -----
            4'b0001: morse = 5'b01111; // .----
            4'b0010: morse = 5'b00111; // ..---
            4'b0011: morse = 5'b00011; // ...--
            4'b0100: morse = 5'b00001; // ....-
            4'b0101: morse = 5'b00000; // .....
            4'b0110: morse = 5'b10000; // -....
            4'b0111: morse = 5'b11000; // --...
            4'b1000: morse = 5'b11100; // ---..
            4'b1001: morse = 5'b11110; // ----.
            default: morse = 5'b11111; // Default to 0
        endcase 
    end
endmodule