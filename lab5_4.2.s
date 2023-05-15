###################################################
###################################################
# #
# text segment #
# #
###################################################

## 4.2 exercise
.text
.globl main
main:


# start of main program
 la $a0,prompt

 li $v0,4
 syscall # display "Enter integer number :"
 
 li $v0,5
 syscall # read integer

 move $t0,$v0
 la $a0,endl
 li $v0,4
 syscall # display end of line


 move $a0,$t0 



 li $v0,10
 syscall # exit
# end of main program


# start of procedure






# end of procedure

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