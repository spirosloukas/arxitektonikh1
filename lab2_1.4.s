###################################################
###################################################
# #
# text segment #
# #
###################################################

## 1.4 exercise
.text
.globl main



li $v0,8
la $a0,str
syscall

li $v0,4
syscall
sb $0,5($a0)


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
str: .space 21
#################################################
# #
# End of File #
# #
#################################################
