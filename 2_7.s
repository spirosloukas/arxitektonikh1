    .text
        .globl __start
__start:
    la $t0, num
    lw $t1, 0($t0)
    lw $t2, 4($t0)
    mult $t1, $t2
    mflo $s1
    mfhi $s2

    .data
num:   .word  0xffffffff, 0x0f0f0f0f