#################################################
#
#
# lab4_1a.s
#
# stack exercise 1
(to be completed) #
#
#
#################################################
.text
.globl __start
__start:
    # start of main program
    
    la $a0,prompt
    li $v0,4
    syscall       # display "Enter integer number :"

    li $v0,5
    syscall       # read integer

    move $t0,$v0

    la $a0,endl
    li $v0,4
    syscall       # display end of line

    li $v0,10
    syscall       # exit

    # end of main program

# start of procedure
#
# end of procedure

.data
max:  .asciiz "Max is : "
min:  .asciiz "Min is : "
endl: .asciiz "\n"
