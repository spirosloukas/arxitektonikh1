.text
.globl main

# Program to find the carry-out bit in a 32-bit integer summation
# (MIPS doesn't have an instruction for doing this)

# By sketching out the Karnaugh Map for the binary function that
# produces the carry-out bit, we find that the i-th carry-out bit can
# be found as follows:
#
#     C_out(i) = sum(i)' * num1(i) + sum(i)' * num2(i) + num1(i) * num2(i),
#
# where sum(i), num1(i) and num2(i) are the corresponding i-th bits of sum,
# num1 and num2.

main:   lw $s0, num1
        lw $s1, num2

        addu $s2, $s1, $s0  # Stores the sum in $s2

        srl $s0, $s0, 31    # MSB of num1 in $s0
        srl $s1, $s1, 31    # MSB of num2 in $s1
        srl $s2, $s2, 31    # MSB of sum in $s2

        xori $s2, $s2, 1    # Stores the inverse of the MSB in $s2

        and $t0, $s2, $s1   # $t0 stores sum(i)' * num1(i) (i == MSB)
        and $t1, $s2, $s0   # $t1 stores sum(i)' * num2(i) (i == MSB)
        and $t2, $s1, $s0   # $t2 stores num1(i) * num2(i) (i == MSB)

        or $s3, $t0, $t1    # $s3 stores sum(i)' * num1(i) + sum(i)' * num2(i)
        or $s3, $s3, $t2    # $s3 now stores the result -- the summation's carry-out bit

exit:   li $v0, 10      # Loads the "exit" instruction into $v0
        syscall         # System call to terminate the program

.data

num1:  .word 0x12345678#0x80000000
num2:  .word 0xAABBCCDD#0x00000001
