.text
.globl main

main:

initial_sp: li $v0, 4
            la $a0, starting_sp_value
            syscall

            li $v0, 1
            move $a0, $sp
            syscall                # Print the initial value of $sp

            jal print_endl         # Print a newline

prompt_usr: li $v0, 4
            la $a0, prompt
            syscall                # Print a message that prompts the user to enter an integer

read_int:   li $v0, 5
            syscall                # Read an integer

            move $a0, $v0          # Integer is saved in $a0

print_int:  li $v0, 1
            syscall                # Print the integer

            jal print_endl         # Print a newline

            move $v1, $sp          # Save the starting value of $sp in $v1
            jal foo                # Call foo()
            jal print_endl         # Print a newline

final_sp:   li $v0, 4
            la $a0, final_sp_value
            syscall                # Print the final value of $sp

            li $v0, 1
            move $a0, $v1
            syscall                # Print the smallest value that $sp has received "inside" foo()

            jal print_endl         # Print a newline

exit:       li $v0, 10
            syscall

# Recursive function that receives a positive integer argument
# (in $a0) and prints all integers from that integer down to 0.
# Additionally, it returns (through $v1) the smallest value that's
# assigned to the register $sp, throughout the recursion and calls
# to other procedures used in foo().

foo:        li $v0, 1
            syscall                # Print the current integer's value

            addi $sp, $sp, -4
            sw   $ra, 0($sp)       # Push $ra onto the stack

            jal print_spc          # Print a space as well

            slt $t0, $v1, $sp      # $t0 = ($v1 < $sp)
            bnez $t0, v1_smaller   # if ($v1 < $sp), goto v1_smaller
            move $v1, $sp          # else, update $v1 to the current value of $sp

v1_smaller: slt $t0, $zero, $a0    # t0 = (0 < current_integer_value)
            beqz $t0, exit_foo     # if (current_integer_value <= 0), then exit foo
            addi $a0, $a0, -1      # else, decrement the current integer's value
            jal foo                # ... and call foo recursively

exit_foo:   lw $ra, 0($sp)         # Pop $ra from the stack
            addi $sp, $sp 4
            jr $ra                 # .. and jump to caller-function

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

            # This part is added for the purposes of the exercise,
            # so that the minimum $sp value can be found, after the
            # call too foo()

            slt $t0, $v1, $sp      # $t0 = ($v1 < $sp)
            bnez $t0, do_nothing   # if ($v1 < $sp), goto do_nothing
            move $v1, $sp          # else, update $v1 to the current value of $sp

do_nothing: lw   $a0, 0($sp)
            addi $sp, $sp, 4
            jr $ra

.data

starting_sp_value: .asciiz "Initial value of $sp: "
final_sp_value:    .asciiz "Final value of $sp: "
prompt:            .asciiz "Enter an integer: "
endl:              .asciiz "\n"
spc:               .asciiz " "
