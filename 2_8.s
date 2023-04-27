#################################################
# #
#           lab2_8a.s #
#       32 / 32 bit division #
# #
#################################################
#################################################
# #
#           text segment #
# #
#################################################
    .text
        .globl __start
__start:

# Input
        la $a0,dividend
        li $v0,4
        syscall         # prompt for dividend
        li $v0,5
        syscall         # read dividend
        move $t0,$v0    # dividend in $t0
        la $a0,divisor
        li $v0,4
        syscall         # prompt for divisor
        li $v0,5
        syscall         # read divisor
        move $t1,$v0    # divisor in $t1

########
########    Calculations
    div $t0, $t1
    mflo $t4
    mfhi $t5


########

#Output
        la $a0,quotient
        li $v0,4
        syscall         # display "quotient is :"
        move $a0,$t4
        li $v0,1
        syscall         # display quotient
        la $a0,endl
        li $v0,4
        syscall         # newline

        la $a0,remainder
        li $v0,4
        syscall         # display "remainder is :"
        move $a0,$t5
        li $v0,1
        syscall         # display remainder
        la $a0,endl
        li $v0,4
        syscall         # newline
        li $v0,10
        syscall         # exit
#################################################
# #
#           data segment #
# #
#################################################
    .data
dividend:   .asciiz "Enter dividend:"
divisor:    .asciiz "Enter divisor:"
endl:       .asciiz "\n"
quotient:   .asciiz "quotient is :"
remainder:  .asciiz "remainder is :"
#################################################
# #
#           End of File #
# #
#################################################