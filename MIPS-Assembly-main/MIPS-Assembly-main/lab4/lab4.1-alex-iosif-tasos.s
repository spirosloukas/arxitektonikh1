.text

    li $a0, -10
    li $a1, -30
    li $a2, 120
    li $a3, 200

    jal MinMax
    move $s0, $v0
    move $s1, $v1

    la $a0, min
    li $v0, 4
    syscall

    move $a0, $s0
    li $v0, 1
    syscall

    la $a0, max
    li $v0, 4
    syscall

    move $a0, $s1
    li $v0, 1
    syscall

    li $v0, 10
    syscall

MinMax: # Calculating the minimum...
            move $v0, $a0
            bgt $a1, $v0, MIN1
            move $v0, $a1
    MIN1:   bgt $a2, $v0, MIN2
            move $v0, $a2
    MIN2:   bgt $a3, $v0, MAX
            move $v0, $a3
    # Calculating the maximum...

    MAX:    move $v1, $a0
            blt $a1, $v1, MAX1
            move $v1, $a1
    MAX1:   blt $a2, $v1, MAX2
            move $v1, $a2
    MAX2:   blt $a3, $v1, END
            move $v1, $a3

    END:    jr $ra


.data
    max: .asciiz "\nMax is: "
    min: .asciiz "Min is: "