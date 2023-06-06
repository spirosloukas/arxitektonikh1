# 2nd method: Use floating point commands, but keep the condition (branch on less or equal)  the same as before

.text
    la $a0, n
    lw $t0, 0($a0) # $t0 = n

    li $t2, 1      # $t2 index i = 1..n

    li $t1, 1
    mtc1 $t1, $f0
    cvt.s.w $f0, $f0 # $f0 contains the result

Loop:   move $a0, $t2

        mtc1 $t2, $f1
        cvt.s.w $f1, $f1
        mul.s $f0, $f0, $f1

        li $v0, 1
        syscall # display i

        la $a0, msg1
        li $v0, 4
        syscall # display "! is : "

        mov.s $f12, $f0
        li $v0, 2
        syscall

        la $a0, endl
        li $v0, 4
        syscall         # print newline

        addi $t2, $t2, 1
        ble $t2, $t0, Loop

    li $v0, 10
    syscall

.data
    n: .word 25
    msg1: .asciiz "! is : "
    endl: .asciiz "\n"
