# Batch normalization

Three versions of the same floating-point batch-normalization computation:

- `batch_normalization_baseline.s`
- `batch_normalization_rescheduled.s`
- `batch_normalization_unrolled_x2.s`

The optimized versions were used to study RAW hazards, stalls, instruction rescheduling and loop unrolling in ASE Studio.
