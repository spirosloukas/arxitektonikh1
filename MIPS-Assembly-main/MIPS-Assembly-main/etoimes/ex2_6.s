.text
.globl main

# Program to find the sum of two 64-bit integers. Since the 32-bit MIPS
# version is used, we can neither store the sum nor the two integers in
# a register. So, we will break them apart and store each 32-bit part in
# a different register. Then, we will sum the first halves, produce the
# carry-out (according to execise 2.5), sum the second halves and then add
# to the second summation the carry-out.

# Note: from exercise 2.5 we have:
#
#     C_out(i) = sum(i)' * num1(i) + sum(i)' * num2(i) + num1(i) * num2(i),
#
# where sum(i), num1(i) and num2(i) are the corresponding i-th bits of sum,
# num1 and num2.

main:   lw $s0, num1_first
        lw $s1, num2_first

        addu $s3, $s1, $s0  # Stores the first sum in $s3

        srl $s0, $s0, 31    # MSB of num1_first in $s0
        srl $s1, $s1, 31    # MSB of num2_first in $s1
        srl $s2, $s3, 31    # MSB of sum1 in $s2

        xori $s2, $s2, 1    # Stores the inverse of the MSB in $s2

        and $t0, $s2, $s1   # $t0 stores sum1(i)' * num1(i) (i == MSB)
        and $t1, $s2, $s0   # $t1 stores sum1(i)' * num2(i) (i == MSB)
        and $t2, $s1, $s0   # $t2 stores num1(i) * num2(i) (i == MSB)

        or $t3, $t0, $t1    # $t3 stores sum1(i)' * num1_first(i) + sum1(i)' * num2_first(i)
        or $s2, $t3, $t2    # $s2 now stores the result -- the summation's carry-out bit

        lw $s0, num1_second
        lw $s1, num2_second

        add $s4, $s1, $s0  # Stores the second sum in $s4
        add $s4, $s4, $s2  # .. also, ads the carry-out bit of the first-halve summation

        la $a0, num2_second
        sb $s3, 4($a0)
        sb $s4, 8($a0)

exit:   li $v0, 10      # Loads the "exit" instruction into $v0
        syscall         # System call to terminate the program

.data

num1_first:  .word 0xffffffff
num1_second: .word 0x00000000

num2_first:  .word 0x00000000
num2_second: .word 0xffffffff