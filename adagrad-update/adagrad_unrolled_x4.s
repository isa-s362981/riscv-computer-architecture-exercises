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
    flw   f1,  0(t0)
    flw   f5,  4(t0)
    flw   f9,  8(t0)
    flw   f13, 12(t0)

    flw   f2,  0(t1)
    flw   f6,  4(t1)
    flw   f10, 8(t1)
    flw   f14, 12(t1)

    flw   f4,  0(t2)
    flw   f8,  4(t2)
    flw   f12, 8(t2)
    flw   f16, 12(t2)

    fmul.s f3,  f1,  f1
    fmul.s f7,  f5,  f5
    fmul.s f11, f9,  f9
    fmul.s f15, f13, f13

    fmul.s f17, f0, f1
    fmul.s f18, f0, f5
    fmul.s f19, f0, f9
    fmul.s f20, f0, f13

    fadd.s f2,  f2,  f3
    fadd.s f6,  f6,  f7
    fadd.s f10, f10, f11
    fadd.s f14, f14, f15

    fsw   f2,  0(t1)
    fsw   f6,  4(t1)
    fsw   f10, 8(t1)
    fsw   f14, 12(t1)

    fdiv.s f17, f17, f2
    fdiv.s f18, f18, f6
    fdiv.s f19, f19, f10
    fdiv.s f20, f20, f14

    fsub.s f4,  f4,  f17
    fsub.s f8,  f8,  f18
    fsub.s f12, f12, f19
    fsub.s f16, f16, f20

    fsw   f4,  0(t2)
    fsw   f8,  4(t2)
    fsw   f12, 8(t2)
    fsw   f16, 12(t2)

    addi  t0, t0, 16
    addi  t1, t1, 16
    addi  t2, t2, 16
    addi  t5, t5, -4

    bne   t5, zero, loop

End:
    li    a0, 0
    li    a7, 93
    ecall
