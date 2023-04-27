    .text

.globl   __start

__start:

    la $t0, numberA
    lw $s0, 0($t0)                  # A
    lw $s1, 8($t0)                  # B
    addu $s2, $s1, $s0              # S
    not $t0, $s2                    # S'          
    and $t1, $t0, $s0               # S'A
    and $t2, $t0, $s1               # S'B
    and $t3, $s1, $s0               # AB
    or $t4, $t1, $t2                # S'A + S'B
    or $t5, $t4, $t3                # S'A + S'B + AB
    srl $s3, $t5, 31                # C_32
    sw $t5, 20($t0)                 # store the low part in sum 
    li $v0, 10
    syscall
    


    .data
numberA:        .word 0x12345678, 0x10111213        # 0x12345678 is the numberA low
                                                    # 0x10111213 is the numberA high
numberB:        .word 0x87654321, 0x11223344        # 0x87654321 is the numberB low
                                                    # 0x11223344 is the numberB high
Sum:            .word 0x00000001, 0x00000001