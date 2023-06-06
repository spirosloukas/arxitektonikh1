.text
.globl main

main:       li $s0, 0            # $s0 stores the hamming distance of num1 and num2
            li $s1, 0            # $s1 stores the loop counter

            lw $s2, num1         # $s2 stores num1
            lw $s3, num2         # $s3 stores num2

print_msg:  la $a0, Msg
            li $v0, 4
            syscall

print_num1: move $a0, $s2
            li $v0, 1
            syscall

print_and:  la $a0, And
            li $v0, 4
            syscall

print_num2: move $a0, $s3
            li $v0, 1
            syscall

print_is:   la $a0, Is
            li $v0, 4
            syscall

loop:       slti $t0, $s1, 32    # $t0 = (loop_counter < 32)
            beqz $t0, print_dist # if ($t0 == 0) <=> (loop_counter >= 32) goto print_dist

            # The loop's main idea is shown below: the hamming distance (stored in $s0)
            # will be incremented only if the LSB of num1 and num2 are different

            andi $t0, $s2, 1     # $t0 = num1 & 1
            andi $t1, $s3, 1     # $t1 = num2 & 1
            xor  $t2, $t0, $t1   # $t2 = $t0 xor $t1
            add  $s0, $s0, $t2   # $s0 += $t2

            srl  $s2, $s2, 1     # num1 >>= 1
            srl  $s3, $s3, 1     # num2 >>= 1
            addi $s1, $s1, 1     # loop_counter++

            j loop

# Print the hamming distance
print_dist: li $v0, 1
            move $a0, $s0
            syscall

print_endl: la $a0, Endl
            li $v0, 4
            syscall

exit:       li $v0, 10           # Loads the "exit" instruction into $v0
            syscall              # System call to terminate the program

.data

Msg:  .asciiz "Hamming distance between "
And:  .asciiz " and "
Is:   .asciiz " is "
Endl: .asciiz "\n"

num1: .word 0x000000ca
num2: .word 0x000000d2
