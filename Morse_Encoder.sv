`timescale 1ns / 1ps


//--------------------------------------------------------------------------------
// Module: Morse_Encoder
// Description: Phase 1 Morse Code Controller with precision FSM timing.
//--------------------------------------------------------------------------------
module Morse_Encoder
#(
    parameter CLK_FREQ = 100_000_000 // 100 MHz for Nexys A7
)
(
    input  logic       clk,
    input  logic       reset_n,      // BTN0 (active low)
    input  logic       start,        // BTN1
    input  logic [3:0] digit,
    output logic       led,
    output logic [6:0]  seg, 
    output logic [7:0] an
);

    // Timing Constants
    localparam ONE_SEC   = CLK_FREQ;
    localparam THREE_SEC = CLK_FREQ * 3;
    localparam HALF_SEC  = CLK_FREQ / 2;

    // Internal Signals
    logic [4:0]  morse_pattern;
    logic [4:0]  shift_reg;
    logic [2:0]  bits_sent;
    logic [31:0] timer;
    logic [31:0] delay_target;
    
    assign an = 7'b1111110;
    
    

    // Start Button Edge Detector (to prevent multi-triggering if held down)
    logic start_q;
    logic start_pulse;
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) start_q <= 1'b0;
        else          start_q <= start;
    end
    assign start_pulse = start & ~start_q; // Goes high for exactly 1 clock cycle

    // Decoder Instantiation
    Digit_Decoder decoder(
        .digit(digit),
        .morse(morse_pattern)
    );
    
    //seg7dec instantiatioon
    
    seg7dec segIns(.digit(digit),
        .seg(seg));

    // FSM States
    typedef enum logic [1:0] {
        IDLE,
        EVAL_SYMBOL,
        TRANSMIT,
        GAP
    } state_t;

    state_t state;

    //--------------------------------------------------
    // FSM & Timer Logic
    //--------------------------------------------------
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state        <= IDLE;
            shift_reg    <= 0;
            bits_sent    <= 0;
            timer        <= 0;
            delay_target <= 0;
            led          <= 0;
        end else begin
            case (state)

                // Wait for the button press to load the pattern
                IDLE: begin
                    led   <= 0;
                    timer <= 0;
                    if (start_pulse) begin
                        shift_reg <= morse_pattern;
                        bits_sent <= 0;
                        state     <= EVAL_SYMBOL;
                    end
                end

                // Determine if the current MSB is a dot or a dash
                EVAL_SYMBOL: begin
                    if (bits_sent == 5) begin
                        state <= IDLE; // Sequence complete
                    end else begin
                        // Check MSB (bit 4). 0 = Dot, 1 = Dash.
                        if (shift_reg[4] == 1'b0) 
                            delay_target <= ONE_SEC;
                        else                      
                            delay_target <= THREE_SEC;
                        
                        timer <= 0;
                        state <= TRANSMIT;
                    end
                end

                // Keep the LED ON for the targeted duration
                TRANSMIT: begin
                    led <= 1;
                    if (timer == delay_target - 1) begin
                        timer <= 0;
                        state <= GAP;
                    end else begin
                        timer <= timer + 1;
                    end
                end

                // Keep the LED OFF for 0.5 seconds, then shift to the next bit
                GAP: begin
                    led <= 0;
                    if (timer == HALF_SEC - 1) begin
                        shift_reg <= shift_reg << 1; // Shift left by 1 to bring next bit to MSB
                        bits_sent <= bits_sent + 1;
                        state     <= EVAL_SYMBOL;
                    end else begin
                        timer <= timer + 1;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule