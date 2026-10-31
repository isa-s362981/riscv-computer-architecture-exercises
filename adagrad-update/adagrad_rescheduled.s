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
    flw   f2, 0(t1)
    flw   f4, 0(t2)

    fmul.s f3, f1, f1
    fmul.s f5, f0, f1

    addi  t0, t0, 4

    fadd.s f2, f2, f3

    addi  t1, t1, 4

    fsw   f2, -4(t1)

    fdiv.s f5, f5, f2

    addi  t2, t2, 4
    addi  t5, t5, -1

    fsub.s f4, f4, f5
    fsw   f4, -4(t2)

    bne   t5, zero, loop

End:
    li    a0, 0
    li    a7, 93
    ecall
