.text
.globl main

# Implementation of a switch-case statement that checks whether a given
# integer is divisible by 2, 3 or 5 (no breaks are included in each case)

main:       

prompt_usr: la $a0, prompt         # $a0 points to prompt
            li $v0, 4              # Loads the string printing code instruction code (4) into $v0
            syscall                # Print out a message asking the user to enter an integer

read_int:   li $v0, 5              # Loads the integer reading instruction code (5) into $v0
            syscall                # Reads an integer

            move $s0, $v0          # The integer (we'll call it num from now on) is stored in $s0

print_endl: li $v0, 4              # Loads the string printing instruction code (4) in $v0
            la $a0, endl           # $a0 points to endl
            syscall                # Print a newline ('\n') character

# Case: num is divisible by 2
div_by_2:   li $t0, 2              # $t0 = 2
            div $s0, $t0           # Divide num by 2 to produce quotient and remainder
            mfhi $t0               # $t0 = num % 2
            bnez $t0, div_by_3     # If num % 2 != 0, goto div_by_3

            li $v0, 1              # else, print out a message saying that num is divisible by 2
            move $a0, $s0
            syscall
            li $v0, 4
            la $a0, divisible_by_2
            syscall

# Case: num is divisible by 3
div_by_3:   li $t1, 3              # $t1 = 3
            div $s0, $t1           # Divide num by 3 to produce quotient and remainder
            mfhi $t1               # $t1 = num % 3
            bnez $t1, div_by_5     # If num % 3 != 0, goto div_by_5

            li $v0, 1              # else, print out a message saying that num is divisible by 3
            move $a0, $s0
            syscall
            li $v0, 4
            la $a0, divisible_by_3
            syscall

# Case: num is divisible by 5
div_by_5:   li $t2, 5              # $t2 = 5
            div $s0, $t2           # Divide num by 5 to produce quotient and remainder
            mfhi $t2               # $t2 = num % 5
            bnez $t2, default      # If num % 5 != 0, default

            li $v0, 1              # else, print out a message saying that num is divisible by 5
            move $a0, $s0
            syscall
            li $v0, 4
            la $a0, divisible_by_5
            syscall
            j exit                 # Bypass the default case

# Default case: num is not divisible by 2, 3 or 5
default:    li $v0, 1
            move $a0, $s0
            syscall
            li $v0, 4
            la $a0, default_case
            syscall

exit:       li $v0, 10             # Loads the "exit" instruction code (10) into $v0
            syscall                # System call to terminate the program

.data

divisible_by_2: .asciiz " is divisible by 2\n"
divisible_by_3: .asciiz " is divisible by 3\n"
divisible_by_5: .asciiz " is divisible by 5\n"
default_case:   .asciiz " is not divisible by 2, 3, or 5\n"

prompt: .asciiz "Enter a number: "
endl:   .asciiz "\n"
