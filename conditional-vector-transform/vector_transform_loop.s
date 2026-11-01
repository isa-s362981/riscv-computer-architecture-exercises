# Register setup is described in the README.

loop:
    beq t1, t0, End

    flw ft0, 0(t2)
    flw ft1, 0(t3)
    flw ft2, 0(t4)

    fdiv.s ft3, ft0, ft1    # holds the division
    fadd.s ft5, ft3, ft2    # creates v4
    fsw ft5, 0(t6)
    addi t6, t6, 4          # for array v4

    div s2, t1, s0          # result of i/3

    addi t1, t1, 1          # i increment
    addi t2, t2, 4
    addi t3, t3, 4
    addi t4, t4, 4

    beq s2, zero, label_0
    beq s2, s1, label_1
    j label_2

label_0:
    fmul.s ft6, ft5, ft2
    fsw ft6, 0(t5)
    addi t5, t5, 4
    j loop

label_1:
    fdiv.s ft6, ft5, ft2
    fsw ft6, 0(t5)
    addi t5, t5, 4
    j loop

label_2:
    fadd.s ft6, ft5, ft2
    fsw ft6, 0(t5)
    addi t5, t5, 4
    j loop
