.text
.globl main

# Program to multiply two 32-bit integers. Since the multiplication can
# yield a result which is bigger than 32-bits, the result of the mult
# instruction is broken into two pieces, of which the first is stored
# in the system register mflo, and the second is stored in the system
# register mfhi

main:   lw $s0, num1
        lw $s1, num2

        mult $s0, $s1   # Multiply the two numbers (32 LSB in mflo, 32 MSB in mfhi)

        mflo $s2        # Move the 32 least significant bits of the multiplication to $s2
        mfhi $s3        # Move the 32 most significant bits of the multiplication to $s3

exit:   li $v0, 10      # Loads the "exit" instruction into $v0
        syscall         # System call to terminate the program

.data

num1: .word 0x0000000a
num2: .word 0x00000008