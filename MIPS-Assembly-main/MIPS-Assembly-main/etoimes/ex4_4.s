.text
.globl main

main:

prompt_usr:   li $v0, 4
              la $a0, prompt
              syscall

read_int:     li $v0, 5
              syscall

              move $a0, $v0            # Integer is saved in $a0

print_int:    li $v0, 1
              syscall                  # Print the integer

              jal print_endl           # Print a newline
              jal fib                  # Calculate Fibonacci(n), where n = $a0 (result in $v1)

              li $v0, 4
              la $a0, fib_n
              syscall                  # Print "Fibonacci term corresponding to that integer: "

              li $v0, 1
              move $a0, $v1
              syscall                  # Print Fibonacci(n)

              jal print_endl           # Print a newline

exit:         li $v0, 10
              syscall

# Recursive function that calculates the n-th fibonacci term,
# where n is saved is passed through the register $a0 (result in $v1)

fib:          addi $sp, $sp, -16
              sw   $ra, 0($sp)         # Push $ra onto the stack
              sw   $a0, 4($sp)         # Push $a0 onto the stack
              sw   $s0, 8($sp)         # Push $s0 onto the stack
              sw   $s1, 12($sp)        # Push $s0 onto the stack

              # Base cases: $a0 == 0 or $a0 == 1
              beqz $a0, case_0         # if ($a == 0), goto case_0
              li   $t0, 1              # $t0 = 1
              seq  $t1, $t0, $a0       # $t1 = (1 == $a0)
              bnez $t1, case_1         # if (1 == $a0) goto case_1

              # Default case: $a0 > 1
              addi $a0, $a0, -1        # $a0 -= 1
              jal fib                  # Call fib recursively for the new $a0 value
              move $s0, $v1

              jal fib_aux              # Same for the fib auxiliary function
              move $s1, $v0

              add $v1, $s0, $s1        # $v1 = foo(n-1) + fib_aux(n-1)
              j exit_fib

case_0:       li $v1, 0                # $v1 = 0
              j exit_fib

case_1:       li $v1, 1                # $v1 = 1
              j exit_fib

exit_fib:     lw $s1, 12($sp)          # Pop $s1 from the stack
              lw $s0, 8($sp)           # Pop $s0 from the stack
              lw $a0, 4($sp)           # Pop $a0 from the stack
              lw $ra, 0($sp)           # Pop $ra from the stack
              addi $sp, $sp 16
              jr $ra                   # .. and jump to caller-function

# Auxiliary function used to make fib linearly recursive

fib_aux:      addi $sp, $sp, -8
              sw   $ra, 0($sp)         # Push $ra onto the stack
              sw   $a0, 4($sp)         # Push $a0 onto the stack

              # Base cases: $a0 == 0 or $a0 == 1
              li   $t0, 1              # $t0 = 1
              slt  $t1, $t0, $a0       # $t1 = (1 < $a0)
              beqz $t1, case_0_or_1    # if ($a0 <= 1), goto case_0_or_1

              # Default case: $a0 > 1
              addi $a0, $a0, -1
              jal fib                  # Call fib recursively for the new $a0 value

              move $v0, $v1            # $v0 = fib(n-1)
              j exit_aux

case_0_or_1:  li $v0, 1                # $v0 = 1
              j exit_aux

exit_aux:     lw $a0, 4($sp)           # Pop $a0 from the stack
              lw $ra, 0($sp)           # Pop $ra from the stack
              addi $sp, $sp 8
              jr $ra                   # .. and jump to caller-function

# Procedure that prints a newline
print_endl:   addi $sp, $sp, -4
              sw   $a0, 0($sp)
              li   $v0, 4
              la   $a0, endl
              syscall

              lw   $a0, 0($sp)
              addi $sp, $sp, 4
              jr $ra

# Procedure that prints a space character
print_spc:    addi $sp, $sp, -4
              sw   $a0, 0($sp)
              li   $v0, 4
              la   $a0, spc
              syscall

              lw   $a0, 0($sp)
              addi $sp, $sp, 4
              jr $ra

.data

prompt: .asciiz "Enter an integer: "
fib_n:  .asciiz "Fibonacci term corresponding to that integer: "
endl:   .asciiz "\n"
spc:    .asciiz " "
