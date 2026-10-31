# RISC-V Computer Architecture Exercises

A collection of RISC-V assembly exercises focused on floating-point computation and pipeline optimization.

## Contents

- `batch-normalization/`
  - baseline implementation
  - instruction-rescheduled version
  - loop-unrolled x2 version
- `adagrad-update/`
  - baseline implementation
  - rescheduled/register-renamed version
  - loop-unrolled x2 version
  - loop-unrolled x4 version
- `pipeline-analysis/`
  - measured instruction counts, clock cycles and CPI from ASE Studio

## Topics practiced

- RISC-V integer and floating-point instructions
- `flw` / `fsw`
- pointer-based array traversal
- branches and loops
- RAW hazards and pipeline stalls
- instruction rescheduling
- register renaming
- loop unrolling
- CPI and cycle-count analysis

Developed and tested with ASE Studio using a five-stage RISC-V pipeline simulator.
