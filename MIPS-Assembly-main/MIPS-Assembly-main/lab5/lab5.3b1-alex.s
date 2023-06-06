# 1os tropos: metafrash entolwn akeraiwn se entoles pragmatikwn

.text
    lwc1 $f0, n # $f0 = n
    lwc1 $f20, inc

    li $t2, 1
    mtc1 $t2, $f1 
    cvt.s.w $f1, $f1 # $f1 index i = 1..n

    li $t1, 1
    mtc1 $t1, $f2
    cvt.s.w $f2, $f2 # $f2 contains i!

Loop:
        mul.s $f2, $f1, $f2

        mov.s $f12, $f1
        li $v0, 2
        syscall # display i

        la $a0, msg1
        li $v0, 4
        syscall # display "! is : "

        mov.s $f12, $f2
        li $v0, 2
        syscall

        la $a0, endl
        li $v0, 4
        syscall # print end of line

        add.s $f1, $f1, $f20
        c.lt.s $f1, $f0 # is $f1 < $f0 ?
        bc1t Loop

    li $v0, 10
    syscall

.data
    n:    .float 25.0
    inc:  .float 1.0
    msg1: .asciiz "! is : "
    endl: .asciiz "\n"