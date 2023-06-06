.text
.globl main

### THIS IS PROBABLY NOT CORRECT, SEE THE BOOK EXAMPLE TO BE SURE

# By sketching out the Karnaugh Map for the binary function that
# produces the carry-out bit, we find that the i-th carry-out bit can
# be found as follows:
#
#     C_out(i) = sum(i)' * num1(i) + sum(i)' * num2(i) + num1(i) * num2(i),
#
# where sum(i), num1(i) and num2(i) are the corresponding i-th bits of sum,
# num1 and num2.

main:   lw $s0, num1       # $s0 = num1
        lw $s1, num2       # $s1 = num2

        add $s2, $s0, $s1  # $s2 = num1 + num2

        # Calculating the carry-out at position 32
        srl $t0, $s0, 31    # MSB of num1 in $t0
        srl $t1, $s1, 31    # MSB of num2 in $t1
        srl $t2, $s2, 31    # MSB of sum  in $t2

        xori $t2, $t2, 1    # Inverse of sum's MSB in $t2

        and $t3, $t2, $t1   # $t3 stores sum(i)' * num1(i) (i == MSB)
        and $t4, $t2, $t0   # $t4 stores sum(i)' * num2(i) (i == MSB)
        and $t5, $t1, $t0   # $t5 stores num1(i) * num2(i) (i == MSB)

        or $s3, $t0, $t1    # $s3 stores sum(i)' * num1(i) + sum(i)' * num2(i)
        or $s3, $s3, $t5    # $s3 now stores the carry-out at position 32

        # Calculating the carry-in at position 32 (same as carry-out at position 31)
        srl $t0, $s0, 30    # 31st bit of num1 in $t0
        srl $t1, $s1, 30    # 31st bit of num2 in $t1
        srl $t2, $s2, 30    # 31st bit of sum  in $t2

        xori $t2, $t2, 1    # Inverse of sum's MSB in $t2

        and $t3, $t2, $t1   # $t3 stores sum(i)' * num1(i) (i == MSB)
        and $t4, $t2, $t0   # $t4 stores sum(i)' * num2(i) (i == MSB)
        and $t5, $t1, $t0   # $t5 stores num1(i) * num2(i) (i == MSB)

        or $s4, $t0, $t1    # $s4 stores sum(i)' * num1(i) + sum(i)' * num2(i)
        or $s4, $s4, $t5    # $s4 now stores the carry-in at position 32

        xor $s5, $s3, $s4

exit:   li $v0, 10         # Loads the "exit" instruction into $v0
        syscall            # System call to terminate the program

.data

num1: .word 0x7fffffff
num2: .word 0x00000001