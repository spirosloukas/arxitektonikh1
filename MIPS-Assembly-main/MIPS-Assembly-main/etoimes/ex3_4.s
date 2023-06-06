.text
.globl main

main:

read_string:  li $v0, 8             # Code to read a string (8)
              li $a1, 21            # Max size = 20 bytes
              la $a0, string        # $a0 points to the string
              syscall               # Read a string

              li $t0, 0             # Character counter in $t0

while:        lbu  $t1, string($t0) # Load the current character in $t1
              beq  $t1, $zero, end  # If '\0' is found, then exit the loop

is_lower:     slti $t3, $t1, 122    # else, check whether the current character is lowercase
              li   $t2, 96
              slt  $t4, $t2,  $t1
              and  $t3, $t3, $t4
              bnez $t3, make_upper  # If the character is lowercase, convert it to uppercase
              addi $t0, $t0, 1      # Else, continue with the loop
              j while

make_upper:   addi $t1, $t1, -32    # To convert a character to uppercase, subtract 32 from it,
              sb   $t1, string($t0) # store the result in the string and continue with the loop
              addi $t0, $t0, 1
              j while

end:          li $v0, 4
              syscall               # Print the converted string ($a0 already points to it)
              li $v0, 4
              la $a0, endl          # $a0 now points to endl
              syscall               # Print a newline ('\n') character

exit:         li $v0, 10            # Loads the "exit" instruction into $v0
              syscall               # System call to terminate the program

.data

string: .space 21                   # String input buffer: at most 20 characters can be read, so
endl:   .asciiz "\n"                # the string will occupy 21 bytes (to terminate it with '\0')