###################################################
###################################################
# #
# text segment #
# #
###################################################

## old exam exercise
.text
.globl main
main:

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
str0: .asciiz " \n"
str1: .asciiz "  \n"
str2: .asciiz "   \n"
str3: .asciiz "    \n"
str4: .asciiz "     \n"
str5: .asciiz "      \n"
str: .space 21
#################################################
# #
# End of File #
# #
#################################################
