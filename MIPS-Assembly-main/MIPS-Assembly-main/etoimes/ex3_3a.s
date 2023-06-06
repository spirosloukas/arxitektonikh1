.text
.globl main

main:       li $t1,  0            # Counter for string
            li $s0, 't'           # Character to end copy
            li $s1, 10            # Maximum number of characters to be copied

while:      lbu  $t0, string($t1) # Load a character

            beq  $t0, $s0, end    # If character to end copy then exit loop
            slt  $t2, $t1, $s1    # $t2 = (character counter < maximum number of characters)
            beqz $t2, end         # If number of characters copied has exceeded the limit,
                                  # then exit loop

            sb   $t0, copy($t1)   # Copy character
            addi $t1, $t1, 1      # Increment counter

            j while               # Repeat while loop

end:        li $t2, 0
            sb $t2, copy($t1)     # Append end character to copied string
            la $a0, copy          # Display copy
            li $v0, 4
            syscall

exit:       li $v0, 10            # Loads the "exit" instruction into $v0
            syscall               # System call to terminate the program

.data

string: .asciiz "Mary had a little lamb"
copy:   .space  80
