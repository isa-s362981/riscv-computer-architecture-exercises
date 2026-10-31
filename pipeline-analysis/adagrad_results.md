# AdaGrad pipeline results

Measured in ASE Studio using the same CPU configuration:

- Integer ALU: 1 cycle
- Integer multiply: 3 cycles
- Integer divide: 8 cycles
- FP ALU: 4 cycles
- FP multiply: 6 cycles
- FP divide: 30 cycles
- Forwarding: enabled
- Out-of-order execution: enabled
- Compressed instructions: disabled

| Version | Instructions | Cycles | CPI |
|---|---:|---:|---:|
| Baseline | 132 | 479 | 3.63 |
| Rescheduled | 132 | 415 | 3.14 |
| Unrolled x2 | 112 | 379 | 3.38 |
| Unrolled x4 | 102 | 347 | 3.40 |

The optimized versions reduce total cycle count by exposing more independent work, reducing some stalls and lowering loop overhead.
