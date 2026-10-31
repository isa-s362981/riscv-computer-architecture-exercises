.data

N:      .word 8
lr:     .float 0.1

g:      .float 0.5, -1.0, 0.25, 2.0, -0.5, 1.5, -0.25, 1.0
h:      .float 1.0, 2.0, 0.5, 1.0, 4.0, 1.0, 0.25, 2.0
w:      .float 0.3, -0.7, 1.2, 0.05, -0.4, 0.9, -1.1, 0.6

.section .text
.globl _start

_start:
    la    t0, g
    la    t1, h
    la    t2, w
    la    t3, lr
    flw   f0, 0(t3)

    la    t4, N
    lw    t5, 0(t4)

loop:
    flw   f1, 0(t0)
    flw   f5, 4(t0)

    flw   f2, 0(t1)
    flw   f6, 4(t1)

    flw   f4, 0(t2)
    flw   f8, 4(t2)

    fmul.s f3, f1, f1
    fmul.s f7, f5, f5

    fmul.s f9,  f0, f1
    fmul.s f10, f0, f5

    fadd.s f2, f2, f3
    fadd.s f6, f6, f7

    fsw   f2, 0(t1)
    fsw   f6, 4(t1)

    fdiv.s f9,  f9,  f2
    fdiv.s f10, f10, f6

    fsub.s f4, f4, f9
    fsub.s f8, f8, f10

    fsw   f4, 0(t2)
    fsw   f8, 4(t2)

    addi  t0, t0, 8
    addi  t1, t1, 8
    addi  t2, t2, 8
    addi  t5, t5, -2

    bne   t5, zero, loop

End:
    li    a0, 0
    li    a7, 93
    ecall
