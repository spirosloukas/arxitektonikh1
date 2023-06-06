#################################################
# #
# lab2_8a.s #
# 32 / 32 bit division #
# #
#################################################

#################################################
# #
# text segment #
# #
#################################################
.text
.globl __start
__start:
    # Input
    la $a0,dividend

    li $v0,4
    syscall # prompt for

    li $v0,5
    syscall # read dividend

    move $t0,$v0 # dividend in $t0

    # ---print integer----  $a0 has the integer value to be printed
    move $a0, $t0
    li $v0, 1
    syscall
    # ---change line----
    li $v0, 4
    la $a0, endl
    syscall

    la $a0,divisor

    li $v0,4
    syscall # prompt for divisor

    li $v0,5
    syscall # read divisor

    move $t1,$v0 # divisor in $t1

    # ---print integer----  $a0 has the integer value to be printed
    move $a0, $t1
    li $v0, 1
    syscall
    # ---change line----
    li $v0, 4
    la $a0, endl
    syscall

    ######## Calculations
    div $t0, $t1

    mflo $t4  # t4 = quitient
    mfhi $t5  # t5 = remainder
    ########

    #Output
    la $a0,quotient
    li $v0,4
    syscall # display "quotient is :"

    move $a0,$t4
    li $v0,1
    syscall # display quotient

    la $a0,endl
    li $v0,4
    syscall # newline

    la $a0,remainder
    li $v0,4
    syscall # display "remainder is :"

    move $a0,$t5
    li $v0,1
    syscall # display remainder

    la $a0,endl
    li $v0,4
    syscall # newline

    li $v0,10
    syscall # exit
#################################################
# #
# data segment #
# #
#################################################
.data
dividend: .asciiz "Enter dividend:"
divisor: .asciiz "Enter divisor:"
endl: .asciiz "\n"
quotient: .asciiz "quotient is :"
remainder: .asciiz "remainder is :"
#################################################
# #
# End of File #
# #
#################################################
# ---read string----
# li $v0, 8
# la $a0, label
# li $a1, n+1 # n = number of chars
# syscall

# ---print string----
# li $v0, 4
# la $a0, label
# syscall

# ---change line----
# li $v0, 4
# la $a0, endl
# syscall

# ---read integer---- do not forget to save the value of $v0
# li $v0, 5
# syscall

# ---print integer----  $a0 has the integer value to be printed
# li $v0, 1
# syscall
