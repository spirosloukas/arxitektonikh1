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

add $t0,$v0,$0

li $v0,5
syscall

add $t1,$v0,$0

add $a0,$t0,$t1

li $v0,1
syscall

sub $a0,$t0,$t1

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