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
    # create float 4.0 from gamma
    la t3, gamma
    flw ft10, 0(t3)
    fadd.s ft10, ft10, ft10
    fadd.s ft10, ft10, ft10

    # mean - unrolled by 2
    la t0, v
    li t1, 2
    la t3, beta
    flw ft2, 0(t3)
    flw ft3, 0(t3)

mean_loop:
    beqz t1, mean_done
    flw ft0, 0(t0)
    flw ft1, 4(t0)

    fadd.s ft2, ft2, ft0
    fadd.s ft3, ft3, ft1

    addi t0, t0, 8
    addi t1, t1, -1
    j mean_loop

mean_done:
    fadd.s ft2, ft2, ft3
    fdiv.s ft2, ft2, ft10

    # variance - unrolled by 2
    la t0, v
    li t1, 2
    la t3, beta
    flw ft4, 0(t3)
    flw ft5, 0(t3)

variance_loop:
    beqz t1, variance_done
    flw ft0, 0(t0)
    flw ft1, 4(t0)

    fsub.s ft6, ft0, ft2
    fsub.s ft9, ft1, ft2
    fmul.s ft6, ft6, ft6
    fmul.s ft9, ft9, ft9
    fadd.s ft4, ft4, ft6
    fadd.s ft5, ft5, ft9

    addi t0, t0, 8
    addi t1, t1, -1
    j variance_loop

variance_done:
    fadd.s ft4, ft4, ft5
    fdiv.s ft5, ft4, ft10

    # result = sqrt(variance + eps)
    la t3, eps
    flw ft6, 0(t3)
    fadd.s ft6, ft5, ft6
    fsqrt.s ft6, ft6

    la t2, result
    fsw ft6, 0(t2)

    # normalization - unrolled by 2
    la t0, v
    la t2, bn
    li t1, 2

    la t3, gamma
    flw ft7, 0(t3)

    la t3, beta
    flw ft8, 0(t3)

normalization_loop:
    beqz t1, End

    flw ft0, 0(t0)
    flw ft1, 4(t0)

    fsub.s ft9, ft0, ft2
    fsub.s ft11, ft1, ft2

    fdiv.s ft9, ft9, ft6
    fdiv.s ft11, ft11, ft6

    fmul.s ft9, ft9, ft7
    fmul.s ft11, ft11, ft7

    fadd.s ft9, ft9, ft8
    fadd.s ft11, ft11, ft8

    fsw ft9, 0(t2)
    fsw ft11, 4(t2)

    addi t0, t0, 8
    addi t2, t2, 8
    addi t1, t1, -1
    j normalization_loop

End:
    li a0, 0
    li a7, 93
    ecall
