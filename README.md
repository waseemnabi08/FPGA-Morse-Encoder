# FPGA Morse Code Encoder

A hardware-level Morse Code encoder implemented on the **Xilinx Nexys A7-100T FPGA** using SystemVerilog with precision FSM timing control.

## 🎯 Overview

This project demonstrates a complete digital design implementation of a Morse Code encoder on an FPGA. It takes a 4-bit binary digit (0-15) as input via switches and outputs the corresponding Morse code pattern on an LED, with timing controlled by a finite state machine (FSM). The system also displays the digit on a 7-segment display.

**Key Features:**
- Hardware-based Morse code generation using FSM
- 4-bit digit input (0-15) via on-board switches
- Real-time Morse code visualization on LED
- 7-segment display output
- Precise timing control with 100 MHz clock
- Reset functionality via CPU reset button
- Start trigger via center button

## 🎬 Video Demonstration

Watch the Morse Code Encoder in action:

[![FPGA Morse Code Encoder Demo](https://img.youtube.com/vi/xyz/maxresdefault.jpg)](https://youtube.com/xyz)

*[Click the image above or this link to watch the demonstration](https://youtube.com/xyz)*

## 🔧 Hardware Setup

### Target Platform
- **FPGA Board:** Xilinx Nexys A7-100T
- **Clock Frequency:** 100 MHz
- **I/O Standard:** LVCMOS33

### Pin Configuration

#### Inputs
| Signal | Pin | Type | Purpose |
|--------|-----|------|---------|
| `clk` | E3 | Clock | 100 MHz system clock |
| `digit[0:3]` | J15, L16, M13, R15 | Switches | 4-bit digit input (0-15) |
| `reset_n` | C12 | Button | Active-low reset (CPU reset button) |
| `start` | N17 | Button | Start encoding trigger (center button) |

#### Outputs
| Signal | Pins | Type | Purpose |
|--------|------|------|---------|
| `led` | H17 | LED | Morse code output (dot/dash visualization) |
| `seg[6:0]` | T10, R10, K16, K13, P15, T11, L18 | 7-Segment Cathodes | Display segments (CA-CG) |
| `an[7:0]` | J17, J18, T9, J14, P14, T14, K2, U13 | 7-Segment Anodes | Display digit selection |

## 📋 Morse Code Reference

Morse code consists of:
- **DOT (.):** Short pulse
- **DASH (-):** Long pulse (3× dot duration)
- **Element Space:** Gap between dots/dashes within a letter
- **Character Space:** Gap between letters
- **Word Space:** Gap between words

### Digit Mappings (0-15)
```
0 = -----    (5 dashes)
1 = .----    (1 dot, 4 dashes)
2 = ..---    (2 dots, 3 dashes)
3 = ...--    (3 dots, 2 dashes)
4 = ....-    (4 dots, 1 dash)
5 = .....    (5 dots)
6 = -....    (1 dash, 4 dots)
7 = --...    (2 dashes, 3 dots)
8 = ---..    (3 dashes, 2 dots)
9 = ----.    (4 dashes, 1 dot)
A = .-       (dot dash)
B = -...     (dash dot dot dot)
C = -.-.     (dash dot dash dot)
D = -..      (dash dot dot)
E = .        (dot)
F = ..-.     (dot dot dash dot)
```

## 🚀 Getting Started

### Prerequisites
- Xilinx Vivado Design Suite (2021.1 or later)
- SystemVerilog HDL knowledge
- Nexys A7-100T FPGA board
- USB cable for board programming

### Building the Project

1. **Create a new RTL project** in Vivado targeting the Nexys A7-100T
2. **Add design files:**
   - Add all `.sv` (SystemVerilog) files from the project
3. **Add constraints:**
   - Add `const.xdc` to the project
4. **Run synthesis and implementation**
5. **Generate bitstream**
6. **Program the FPGA:**
   - Connect the board via USB
   - Open Hardware Manager in Vivado
   - Program the device with the generated bitstream

### Using the Encoder

1. **Select a digit** (0-15) using the 4 switches on the board
2. **Press the center button** (`start`) to begin encoding
3. **Observe the LED** flashing the Morse code pattern
4. **View the digit** on the 7-segment display
5. **Press CPU Reset** (`reset_n`) to reset the system

## 📁 Project Structure

```
FPGA-Morse-Encoder/
├── README.md              # This file
├── const.xdc              # Pin configuration and constraints
├── *.sv                   # SystemVerilog design files
└── [doc/]                 # Optional documentation
```

## 🏗️ Architecture

### Main Components

**FSM (Finite State Machine):**
- Manages state transitions for Morse code generation
- Controls timing between dots, dashes, and spaces
- Synchronizes with 100 MHz clock

**Digit-to-Morse Encoder:**
- Converts 4-bit input to Morse sequence
- Outputs dot/dash patterns

**LED Driver:**
- Displays Morse code in real-time
- LED on = dot/dash, LED off = space

**7-Segment Display Driver:**
- Shows the input digit (0-F)
- Enables visual confirmation of selection

## 📊 Timing Specifications

Based on standard Morse code timing:
- **DOT duration:** ~1 time unit
- **DASH duration:** ~3 time units
- **Space between elements:** ~1 time unit
- **Space between characters:** ~3 time units
- **Space between words:** ~7 time units

*Adjust timing constants in the design as needed for your application.*

## 🔌 I/O Usage Summary

- **Inputs:** 8 total (1 clock, 4 switches, 2 buttons, 1 reset)
- **Outputs:** 15 total (1 LED, 7 segments, 8 anodes)
- **Total I/O:** 23 pins

## 🐛 Debugging Tips

1. **Use ILAs (Integrated Logic Analyzer)** to observe FSM states and timing
2. **Check LED behavior** - should blink in Morse pattern
3. **Verify 7-segment display** shows correct digit
4. **Monitor clock frequency** - should be exactly 100 MHz
5. **Test with simple inputs** (0, 5, 15) before complex patterns

## 📚 References

- [Xilinx Nexys A7 Reference Manual](https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual)
- [International Morse Code Standards](https://en.wikipedia.org/wiki/Morse_code)
- [LVCMOS I/O Standard Documentation](https://www.xilinx.com/support)

## 📝 License

This project is open source. Feel free to use, modify, and distribute as needed.

## 👤 Author

**Waseem Nabi**

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report issues
- Suggest improvements
- Submit pull requests with enhancements

---

**Last Updated:** June 2026
