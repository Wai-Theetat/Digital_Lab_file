# Digital Lab – VHDL

VHDL code from my Digital Systems lab at KMITL, synthesized onto a Xilinx FPGA board.

## Lab 09: 8-bit ALU on FPGA
An 8-bit ALU whose result is shown on a 4-digit seven-segment display.

| Module | Description |
|---|---|
| `ALU8.vhd` | 8-bit ALU: ADD, SUB (two's complement), XOR, shift-left |
| `ModeSelector.vhd` | Push button cycles through the 4 ALU modes |
| `ModN.vhd` | Generic mod-N counter (used as a clock divider) |
| `sevenSegmentCtl.vhd` | Multiplexed seven-segment display driver |
| `Top_Level.vhd` | Connects everything (structural design) |
| `Top_Level.ucf` | Pin constraints for the board |

**Inputs:** two 8-bit switch banks (A, B), a mode button, system clock
**Outputs:** seven-segment display, 2 status LEDs showing the current mode

## Tools
Xilinx ISE (VHDL, `.ucf` constraints)
