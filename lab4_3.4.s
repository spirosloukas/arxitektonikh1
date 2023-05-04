###################################################
###################################################
# #
# text segment #
# #
###################################################

## 3.4 exercise
.text
.globl main
main:
li $t7,0

la $a0,str
la $a1,31

li $v0, 8
syscall

li $v0,4
syscall

loop:
    lb $t0,0($a0)
    beq $t0, $zero, end
    blt $t0, 97,nchar
    bgt $t0, 122,nchar
    addi $t0, $t0,-32
    sb $t0, 0($a0)
    nchar:
    addi $a0,$a0,1
    j loop
end:

    la $a0,str
    li $v0,4
    syscall

    li $v0,10
    syscall # au revoir...
#################################################
# #
# data segment #
# #
#################################################
.data
endl: .asciiz "\n"
str: .space 30
#################################################
# #
# End of File #
# #
#################################################