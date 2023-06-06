.text
.globl main

# Program to divide two 32-bit integers. Since the division produces
# a quotient and a remainder, its result is split and saved at the
# registers mflo and mfhi, accordingly

# The program flow here is really simple:
# 1. Read the divident and divisor from the console
# 2. Print the quotient and the remainder of their division

main:   la $a0, divident
        li $v0, 4
        syscall

        li $v0, 5
        syscall

        move $t0, $v0

        la $a0, endl
        li $v0, 4
        syscall

        la $a0, divisor
        li $v0, 4
        syscall

        li $v0, 5
        syscall

        move $t1, $v0

        la $a0, endl
        li $v0, 4
        syscall

        la $a0, quotient
        li $v0, 4
        syscall

        div $t0, $t1

        mflo $a0
        li $v0, 1
        syscall

        la $a0, endl
        li $v0, 4
        syscall

        la $a0, remainder
        li $v0, 4
        syscall

        mfhi $a0
        li $v0, 1
        syscall

        la $a0, endl
        li $v0, 4
        syscall

exit:   li $v0, 10      # Loads the "exit" instruction into $v0
        syscall         # System call to terminate the program

.data

divident:  .asciiz "Enter dividend: "
divisor:   .asciiz "Enter divisor: "
quotient:  .asciiz "Quotient is: "
remainder: .asciiz "Remainder is: "
endl:      .asciiz "\n"
