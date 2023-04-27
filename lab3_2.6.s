###################################################
###################################################
# #
# text segment #
# #
###################################################

## 2.6 exercise
.text
.globl main
main:


    la $t0, number1
    la $t1, number2

    lw $s0, 4($t0)                  # A
    lw $s1, 4($t1)                  # B


    addu $s5, $s1, $s0              # S
    not $s2, $s5                    # S'          
    and $t6, $s2, $s0               # S' * A
    and $t2, $s2, $s1               # S' * B
    and $t3, $s0, $s1               # A * B
    or $t4, $t6, $t2                # S'A + S'B
    or $t5, $t4, $t3                # S'A + S'B + AB
    srl $s3, $t5, 31                # C_32
    
    lw $s0, 0($t0)
    lw $s1, 0($t1)

    addu $s1, $s1, $s3              #add the carry into one of the numbers(high)
    addu $s5, $s1, $s0              #S(high)
    not $s2, $s5                    # S'          
    and $t6, $s2, $s0               # S' * A
    and $t2, $s2, $s1               # S' * B
    and $t3, $s0, $s1               # A * B
    or $t4, $t6, $t2                # S'A + S'B
    or $t5, $t4, $t3                # S'A + S'B + AB
    srl $s3, $t5, 31                # C_32



li $v0,10
syscall # au revoir...
#################################################
# #
# data segment #
# #
#################################################
.data
endl: .asciiz "\n"
number1:    .word 0x80000000, 0x80000000
number2:    .word 0x80000000, 0x80000000

#################################################
# #
# End of File #
# #
#################################################