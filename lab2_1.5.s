###################################################
###################################################
# #
# text segment #
# #
###################################################

## 1.5 exercise
.text
.globl main
main:

li $v0,5
syscall

move $a0, $v0


li $v0,1

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

#################################################
# #
# End of File #
# #
#################################################