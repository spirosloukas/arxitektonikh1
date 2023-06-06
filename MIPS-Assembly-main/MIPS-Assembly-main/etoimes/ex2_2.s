.text
.globl main

# Converts a word that's stored in a register according to the
# Big Endian order to its corresponding Little Endian form, under
# the assumption that this word is stored manually in the register $s0.

main:   srl $t0, $s0, 24  # Store the LSB of the word in $t0

        sll $t1, $s0, 8   # Move the second-to-LSB of the word to the LSB position
        srl $t1, $t1, 24  # .. and store it in $t1

        # We can work using the andi operator for the last 4 bytes
        # (since andi works only for 16-bit immediate values)
        andi $t2, $s0, 0x0000ff00  # Store for second-to-MSB in $t2
        srl  $t2, $t2, 8

        andi $t3, $s0, 0x000000ff  # .. and the MSB in $t3

        # Finally, store the bytes (in Little Endian order) in $s1
        # (each byte is shifted to the left by the right amount to
        #  get to its correct position)
        ori $s1, $t0,  0

        sll $t1, $t1,  8
        or $s1, $s1, $t1

        sll $t2, $t2, 16
        or $s1, $s1, $t2

        sll $t3, $t3, 24
        or $s1, $s1, $t3

exit:   li $v0, 10        # Loads the "exit" instruction into $v0
        syscall           # System call to terminate the program

.data
