.text
.globl main

main:

prompt_usr: li $v0, 4
            la $a0, prompt
            syscall

read_int:   li $v0, 5
            syscall
            move $a0, $v0       # Integer is saved in $a0

            jal print_endl      # Print a newline
            jal foo             # Print the recursive function

exit:       li $v0, 10
            syscall

# Recursive function that receives a positive integer argument 
# (in $a0) and prints all integers from that integer down to 0

foo:        li $v0, 1
            syscall             # Print the current integer's value
            jal print_spc       # Print a space as well

            addi $sp, $sp, -4
            sw   $ra, 0($sp)    # Push $ra onto the stack

            slt $t0, $zero, $a0 # t0 = (0 < current_integer_value)
            beqz $t0, exit_foo  # if (current_integer_value <= 0), then exit foo
            addi $a0, $a0, -1   # else, decrement the current integer's value
            jal foo             # ... and call foo recursively

exit_foo:   lw $ra, 0($sp)      # Pop $ra from the stack
            addi $sp, $sp 4
            jr $ra              # .. and jump to caller-function

# Procedure that prints a newline
print_endl: addi $sp, $sp, -4
            sw   $a0, 0($sp)
            li   $v0, 4
            la   $a0, endl
            syscall

            lw   $a0, 0($sp)
            addi $sp, $sp, 4
            jr $ra

# Procedure that prints a space character
print_spc:  addi $sp, $sp, -4
            sw   $a0, 0($sp)
            li   $v0, 4
            la   $a0, spc
            syscall

            lw   $a0, 0($sp)
            addi $sp, $sp, 4
            jr $ra

.data

prompt: .asciiz "Enter an integer: "
endl:   .asciiz "\n"
spc:    .asciiz " "
