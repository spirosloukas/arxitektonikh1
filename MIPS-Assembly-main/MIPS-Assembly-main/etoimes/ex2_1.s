.text
.globl main

# Encodes a 32-bit number using grey encoding, under the
# assumption that the number is stored in the register $s0
# manually, from the window of QtSpim. The result will be
# stored in the register $s1.

main:   srl $t0, $s0, 1     # The number is initially shifted right by 1
        xor $s1, $t0, $s0   # The shifted number is then xor'ed with the initial
                            # number, thus producing the grey-encoded number

exit:   li $v0, 10          # Loads the "exit" instruction into $v0
        syscall             # System call to terminate the program

.data
