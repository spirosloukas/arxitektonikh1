###################################################
###################################################
# #
# text segment #
# #
###################################################

## 3.1 exercise
.text
.globl main
main:
li $s0, 2
li $s1, 5
li $s2, 10
#li $t7,0
la $t7,case4


li $v0, 5
syscall

move $t1, $v0

div $t1, $s0

mfhi $t2

bne $t2,$zero, case1

#addi $t7, $t7, 1

la $a0 ,div2

li $v0,4

syscall

jr $t7


case1:
    div $t1, $s1

    mfhi $t2

    bne $t2,$zero, case2

    #addi $t7, $t7, 1

    la $a0 ,div5

    li $v0,4
    syscall

    jr $t7

case2:
    div $t1, $s2

    mfhi $t2

    bne $t2,$zero, case3

    #addi $t7, $t7, 1

    la $a0 ,div10

    li $v0,4
    syscall

    jr $t7

case3:

    #bne $t7,$zero, case4

    la $a0 ,ndiv

    li $v0,4
    syscall

case4:

    li $v0, 10
    syscall
#################################################
# #
# data segment #
# #
#################################################
.data
div2: .asciiz "number is divided by 2 !\n"
div5: .asciiz "number is divided by 5 !\n"
div10: .asciiz "number is divided by 10 !\n"
ndiv: .asciiz "number is not divided by 2,5,10 !\n"
endl: .asciiz "\n"
#################################################
# #
# End of File #
# #
#################################################

