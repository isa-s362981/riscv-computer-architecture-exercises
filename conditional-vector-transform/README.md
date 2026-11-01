# Conditional vector transform

This program computes:

`v4[i] = v1[i] / v2[i] + v3[i]`

Then it selects the operation for `v5[i]` using the integer result of `i / 3`:

- result 0: multiply
- result 1: divide
- otherwise: add

The source keeps the same pointer/register logic used while working through the exercise.
