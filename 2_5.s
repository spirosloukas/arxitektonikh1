#Author: George-Marios Fragkoulis	    
    .text
        .globl __start
__start:
    la $t0, numbers
    lw $s0, 0($t0)                  # A
    lw $s1, 4($t0)                  # B
    addu $s2, $s1, $s0              # S
    not $t0, $s2                    # S'          
    and $t1, $t0, $s0               # S'A
    and $t2, $t0, $s1               # S'B
    and $t3, $s1, $s0               # AB
    or $t4, $t1, $t2                # S'A + S'B
    or $t5, $t4, $t3                # S'A + S'B + AB
    srl $s3, $t5, 31                # C_32
    li $v0, 10
    syscall




    .data
numbers:    .word 0x80000000, -1
#numbers:    .word 1073741823, 1073741823      