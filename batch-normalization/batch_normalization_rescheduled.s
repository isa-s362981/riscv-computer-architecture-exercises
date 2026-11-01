.data

N:      .word 4
v:      .float 0.62, -0.35, 1.18, 0.07
gamma:  .float 1.0
beta:   .float 0.0
eps:    .float 0.001
bn:     .space 16
result: .space 4

.section .text
.globl _start

_start:
    # mean
    la t0, v
    li t1, 4
    la t3, beta
    flw ft2, 0(t3)

mean_loop:
    beqz t1, mean_done
    flw ft0, 0(t0)

    addi t0, t0, 4
    addi t1, t1, -1

    # rescheduling: put independent instructions between load and floating point op
    fadd.s ft2, ft2, ft0
    j mean_loop

mean_done:
    la t3, gamma
    flw ft1, 0(t3)
    fadd.s ft1, ft1, ft1
    fadd.s ft1, ft1, ft1
    fdiv.s ft2, ft2, ft1

    # variance
    la t0, v
    li t1, 4
    la t3, beta
    flw ft4, 0(t3)

variance_loop:
    beqz t1, variance_done
    flw ft0, 0(t0)

    addi t0, t0, 4
    addi t1, t1, -1

    fsub.s ft3, ft0, ft2
    fmul.s ft3, ft3, ft3
    fadd.s ft4, ft4, ft3
    j variance_loop

variance_done:
    fdiv.s ft5, ft4, ft1

    # result = sqrt(variance + eps)
    la t3, eps
    flw ft6, 0(t3)
    fadd.s ft6, ft5, ft6
    fsqrt.s ft6, ft6
    la t2, result
    fsw ft6, 0(t2)

    # normalization
    la t0, v
    la t2, bn
    li t1, 4
    la t3, gamma
    flw ft7, 0(t3)
    la t3, beta
    flw ft8, 0(t3)

normalization_loop:
    beqz t1, End
    flw ft0, 0(t0)

    addi t0, t0, 4
    addi t1, t1, -1

    fsub.s ft9, ft0, ft2

    addi t2, t2, 4

    fdiv.s ft9, ft9, ft6
    fmul.s ft9, ft9, ft7
    fadd.s ft9, ft9, ft8
    fsw ft9, -4(t2)

    j normalization_loop

End:
    li a0, 0
    li a7, 93
    ecall
