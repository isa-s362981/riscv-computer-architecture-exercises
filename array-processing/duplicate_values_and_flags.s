.data

v1: .byte 2, 6, -3, 11, 9, 18, -13, 16, 5, 1
v2: .byte 4, 2, -13, 3, 9, 9, 7, 16, 4, 7
v3: .space 10

flag1: .byte 0
flag2: .byte 0
flag3: .byte 0

.section .text
.globl _start

_start:
    la t0, v1
    la t1, v2
    la t2, v3

    li t3, 10
    li a0, 0

outer_loop:
    beqz t3, finished_v3

    lb t5, 0(t0)

    la t1, v2
    li t4, 10

inner_loop:
    beqz t4, next_v1

    lb t6, 0(t1)
    beq t5, t6, found

    addi t1, t1, 1
    addi t4, t4, -1
    j inner_loop

found:
    sb t5, 0(t2)
    addi t2, t2, 1
    addi a0, a0, 1

next_v1:
    addi t0, t0, 1
    addi t3, t3, -1
    j outer_loop

finished_v3:
    # flag1 = 1 only if v3 is empty
    beqz a0, set_flag1

    # flag2 checks if v3 is strictly increasing
    la t0, v3
    li t1, 1
    li t3, 1
    beq a0, t1, flag2_done

    lb t5, 0(t0)
    addi t0, t0, 1
    addi t4, a0, -1

flag2_loop:
    beqz t4, flag2_done
    lb t6, 0(t0)
    bge t5, t6, flag2_false

    mv t5, t6
    addi t0, t0, 1
    addi t4, t4, -1
    j flag2_loop

flag2_false:
    li t3, 0

flag2_done:
    la t0, flag2
    sb t3, 0(t0)

    # flag3 checks if all values are odd
    la t0, v3
    mv t4, a0
    li t3, 1

flag3_loop:
    beqz t4, flag3_done

    lb t5, 0(t0)
    andi t6, t5, 1
    beqz t6, flag3_false

    addi t0, t0, 1
    addi t4, t4, -1
    j flag3_loop

flag3_false:
    li t3, 0

flag3_done:
    la t0, flag3
    sb t3, 0(t0)
    j End

set_flag1:
    li t3, 1
    la t0, flag1
    sb t3, 0(t0)

End:
    li a0, 0
    li a7, 93
    ecall
