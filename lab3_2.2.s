###################################################
###################################################
# #
# text segment #
# #
###################################################

## 2.2 exercise
.text
.globl main
main:

lw $a0,num

srl $t0, $a0 ,24        # byte : 12

sll $t1, $a0 ,8         #byte : 34
srl $t1, $t1 ,24
sll $t1, $t1 ,8

sll $t2, $a0,16         #byte : 56
srl $t2, $t2,24
sll $t2, $t2,16

sll $t3, $a0,24         #byte :78

or $t5, $t0, $t1
or $t6, $t2, $t3
or $a0, $t5, $t6



li $v0,10
syscall # au revoir...
#################################################
# #
# data segment #
# #
#################################################
.data
endl: .asciiz "\n"
num: .word 0x12345678
#################################################
# #
# End of File #
# #
#################################################


#la	$t1, num
#lb 0($t2),num + 3
#lb 1($t2),num + 2
#lb 2($t2),num + 1
#lb 3($t2),num