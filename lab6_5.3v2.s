###################################################
###################################################
# #
# text segment #
# #
###################################################

## 5.3 exercise

.text
.globl main
main:

    la $a0, n
    lw $t0, 0($a0)         # $t0 = n
    mtc1 $t0, $f0
    cvt.s.w $f0, $f0
    
    mov.s $f12, $f0
    li $v0, 2
    syscall
        la $a0, endl
    li $v0, 4
    syscall

    li.s $f2, 1.0           # $t2 index i=1..n
    li.s $f11, 1.0          # $f2 contains i!
    li.s $f10, 1.0

loop:

    mul.s $f11, $f11, $f2

    mov.s $f12, $f2
    li $v0, 2
    syscall                 # display i

    la $a0, msg1
    li $v0, 4
    syscall                 # display "! is :"

    mov.s $f12, $f11

    li $v0, 2
    syscall                 # display i!

    la $a0, endl
    li $v0, 4
    syscall                 # print end of line

    #addi.s $f2, $f2, 1.0        # i=i+1
    add.s $f2, $f2, $f10

    c.le.s $f2, $f0
    bc1t loop      # repeat if i<=n

    j exit

exit:
    li $v0, 10              # exit
    syscall

#################################################
# #
# data segment #
# #
#################################################
.data
n: .word 25
msg1: .asciiz "! is :"
endl: .asciiz "\n"

#################################################
# #
# End of File #
# #
#################################################
