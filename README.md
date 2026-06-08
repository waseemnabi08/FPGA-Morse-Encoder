# FPGA Morse Code Encoder

A hardware-level Morse Code encoder on the **Xilinx Nexys A7-100T FPGA** using SystemVerilog with FSM timing control.

## 🎯 Overview

This project implements a Morse Code encoder that takes a 4-bit input (0-15) from switches and outputs the corresponding Morse code pattern on an LED in real-time.

**Key Features:**
- Hardware-based Morse code generation using FSM
- 4-bit digit input (0-15) via switches
- Real-time LED visualization (dot/dash flashing)
- 7-segment display output
- 100 MHz system clock
- Reset and start buttons

## 🔧 Hardware Setup

**Target Platform:**
- FPGA: Xilinx Nexys A7-100T (xc7a100tcsg324-1)
- Clock: 100 MHz
- I/O Standard: LVCMOS33

**Pin Configuration:**

| Signal | Pin | Purpose |
|--------|-----|---------|
| `clk` | E3 | 100 MHz system clock |
| `digit[3:0]` | J15, L16, M13, R15 | 4-bit digit input (switches) |
| `reset_n` | C12 | Active-low reset (CPU button) |
| `start` | N17 | Start trigger (center button) |
| `led` | H17 | Morse output LED |
| `seg[6:0]` | T10, R10, K16, K13, P15, T11, L18 | 7-segment display |
| `an[7:0]` | J17, J18, T9, J14, P14, T14, K2, U13 | Display anodes |

## 📋 Morse Code Reference

| Digit | Pattern | | Digit | Pattern |
|-------|---------|---|-------|---------|
| 0 | ----- | | 8 | ---.. |
| 1 | .---- | | 9 | ----. |
| 2 | ..--- | | 
| 3 | ...-- | |
| 4 | ....- | | 
| 5 | ..... | | 
| 6 | -.... | |
| 7 | --... | |



## 🚀 Quick Start

### Prerequisites
- Xilinx Vivado 2021.1 or later
- Nexys A7-100T FPGA board
- USB cable

### Build Steps

1. Create new RTL project in Vivado targeting `xc7a100tcsg324-1`
2. Add all `.sv` files to design sources
3. Add `const.xdc` to constraints
4. Run: Synthesis → Implementation → Generate Bitstream
5. Program FPGA via Hardware Manager

### Usage

1. Select digit (0-15) using 4 switches
2. Press center button (`start`) to begin encoding
3. Watch LED flash the Morse pattern
4. View digit on 7-segment display
5. Press CPU Reset to stop

## 📁 Project Structure

```
FPGA-Morse-Encoder/
├── README.md              # Documentation
├── const.xdc              # Pin constraints
├── *.sv                   # SystemVerilog design files
└── doc/                   # Optional documentation
```

## 🏗️ Architecture

**Main Components:**
- **FSM Controller:** State machine managing encoding sequence
- **Morse ROM:** Digit-to-Morse pattern mapping
- **Clock Divider:** Precise timing generation
- **LED Driver:** Output signal to LED
- **7-Seg Driver:** Display driver for digit output

## 🐛 Troubleshooting

| Issue | Solution |
|-------|----------|
| LED not blinking | Verify `reset_n` released; check pin H17 in constraints |
| 7-segment blank | Check all anode/cathode pins connected correctly |
| Wrong Morse pattern | Verify digit input matches switches; check ROM mapping |
| Timing too fast/slow | Verify 100 MHz clock at E3; check clock divider |

## 📚 References

- [Xilinx Nexys A7 Manual](https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual)
- [Morse Code Standards](https://en.wikipedia.org/wiki/Morse_code)
- [Vivado Documentation](https://www.xilinx.com/support)

## 📝 License

Open source - MIT License

## 👤 Author

**Waseem Nabi**

## 🤝 Contributing

Contributions welcome! Feel free to report issues and submit pull requests.

---

