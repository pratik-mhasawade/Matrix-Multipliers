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
# 4×4 Pipelined Matrix Multiplication Accelerator  
**Verilog RTL | Artix-7 (Basys-3) | DSP-Optimized Compute Engine**

---

## 1. Project Overview

This project implements a high-performance 4×4 matrix multiplication accelerator using a fully pipelined parallel MAC architecture in Verilog.

The design targets the **Xilinx Artix-7 XC7A35T FPGA** on the Basys-3 development board and demonstrates:

- Balanced adder-tree pipelining  
- DSP48 multiplier inference  
- Timing-aware RTL design  
- Deterministic latency and throughput  

Matrix multiplication is the fundamental compute primitive behind modern AI workloads such as CNNs and Transformers. This project focuses on datapath optimization and digital architecture depth rather than system-level integration.

---

## 2. Functional Description

The accelerator computes:

C = A × B

Where A and B are 4×4 signed matrices.

Each output element is computed as:

C[i][j] = Σ (A[i][k] × B[k][j])  for k = 0 to 3

Key features:

- 16 parallel compute elements  
- 3-stage pipelined MAC architecture  
- Signed fixed-point arithmetic  
- One output result per clock (steady state)

---

## 3. Micro-Architecture

Each MAC element consists of:

### Stage 1 – Multiplication
- 4 parallel signed multipliers  
- DSP48 inference  
- Registered outputs  

### Stage 2 – First-Level Adder Tree
- Two parallel adders  
- Balanced tree structure  
- Controlled bit growth  

### Stage 3 – Final Accumulation
- Final addition  
- Output register  
- Valid signal alignment  

### Latency & Throughput

- Pipeline Depth: 3 stages  
- Latency: 3 clock cycles  
- Throughput: 1 result per clock (after pipeline fill)

---

## 4. Design Characteristics

- Fully synchronous RTL  
- Parameterized data widths  
- Clock-enable support  
- Balanced combinational depth  
- DSP-aware implementation  
- Clean valid-signal pipelining  

This design emphasizes timing closure, resource efficiency, and scalability.

---

## 5. Target Platform

- FPGA: Xilinx Artix-7 XC7A35T  
- Board: Basys-3  
- Toolchain: Vivado  
- Language: Verilog  

---

## 6. Repository Structure

