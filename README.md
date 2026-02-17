Designed a fully pipelined 4×4 matrix multiplication accelerator on Artix-7 FPGA using parallel MAC architecture with balanced adder trees and DSP-optimized multipliers achieving 3-cycle compute latency at 75 MHz.

About mac4_element.v
  Fully synchronous reset (FPGA safe)
  Explicit signed arithmetic
  Correct bit growth handling
  Clean 3-stage pipeline
  Valid signal aligned with data
  DSP inference preserved
  No latches
  No combinational feedback

Bit width Verification (Worst-case)
  127 × 127 = 16129  (14 bits)
  4 × 16129 = 64516  (17 bits needed)
