###################################################
###################################################
# #
# text segment #
# #
###################################################

## 4.1 exercise
.text
.globl main
main:

# start of main program
 li $a0,-10 # Initialize variables
 li $a1,-30 #
 li $a2,120 #
 li $a3,200 #

jal MinMax

 move $t0,$v0
 move $t1,$v1
 la $a0,max
 li $v0,4
 syscall # display "Max is :"
 move $a0,$t0
 li $v0,1
 syscall # display max
 la $a0,endl
 li $v0,4
 syscall # display end of line
 la $a0,min
 li $v0,4
 syscall # display "Min is :"
 move $a0,$t1
 li $v0,1
 syscall # display min
 la $a0,endl
 li $v0,4
 syscall # display end of line
 li $v0,10
 syscall # exit

# end of main program


# start of procedure



#
# end of procedure

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