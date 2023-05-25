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
    lw $t0, 0($a0)          # $t0 = n
    li $t2, 1               # $t2 index i=1..n
    li.s $f12, 1.0          # $t1 contains i!

loop:
    mtc1 $t2, $f1
    cvt.s.w $f1, $f1
    mul.s $f12, $f12, $f1

    move $a0, $t2
    li $v0, 1
    syscall                 # display i

    la $a0, msg1
    li $v0, 4
    syscall                 # display "! is :"

    li $v0, 2
    syscall                 # display i!

    la $a0, endl
    li $v0, 4
    syscall                 # print end of line

    addi $t2, $t2, 1        # i=i+1
    ble $t2, $t0, loop      # repeat if i<=n

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
