.text
.globl main

main:   la $s0, first_val

        lw $t0, ($s0) # Load the first value in $t0
        move $t1, $t0 # Load the same value in $t1

        # Print the first sum (signed)
        add $a0, $t0, $t1 # $a0 = $t0 + $t1
        li $v0, 1
        syscall

        la $a0, newline
        li $v0, 4
        syscall

        # Print the first sum (unsigned)
        addu $a0, $t0, $t1 # $a0 = $t0 + $t1
        li $v0, 1
        syscall

        la $a0, newline
        li $v0, 4
        syscall

        lw $t0,  4($s0) # Load int_max in $t0
        lw $t1, 16($s0) # Load the value 1 in $t1

        # Print the second sum (signed)
        add $a0, $t0, $t1 # $a0 = $t0 + $t1
        li $v0, 1
        syscall

        la $a0, newline
        li $v0, 4
        syscall

        # Print the second sum (unsigned)
        addu $a0, $t0, $t1 # $a0 = $t0 + $t1
        li $v0, 1
        syscall

        la $a0, newline
        li $v0, 4
        syscall

        lw $t0,  8($s0) # Load int_min in $t0
        lw $t1, 12($s0) # Load the value -1 in $t1

        # Print the third sum (signed)
        add $a0, $t0, $t1 # $a0 = $t0 + $t1
        li $v0, 1
        syscall

        la $a0, newline
        li $v0, 4
        syscall

        # Print the third sum (unsigned)
        addu $a0, $t0, $t1 # $a0 = $t0 + $t1
        li $v0, 1
        syscall

        la $a0, newline
        li $v0, 4
        syscall

        lw $t0, 12($s0) # Load the value -1 in $t0
        move $t1, $t0   # Load the same value in $t1

        # Print the fourth sum (signed)
        add $a0, $t0, $t1 # $a0 = $t0 + $t1
        li $v0, 1
        syscall

        la $a0, newline
        li $v0, 4
        syscall

        # Print the fourth sum (unsigned)
        addu $a0, $t0, $t1 # $a0 = $t0 + $t1
        li $v0, 1
        syscall

        la $a0, newline
        li $v0, 4
        syscall

exit:   li $v0, 10      # Loads the "exit" instruction into $v0
        syscall         # System call to terminate the program

.data

first_val: .word 0x3fffffff
int_max:   .word 0x7fffffff
int_min:   .word 0x80000000
neg_one:   .word 0xffffffff
one:       .word 0x00000001

newline:   .asciiz "\n"
