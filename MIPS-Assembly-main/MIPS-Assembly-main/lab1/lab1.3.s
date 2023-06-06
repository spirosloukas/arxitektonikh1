.text
       	.globl __start
__start:			# execution starts here

    la $s0, 0x1001000a  # Load Address
    la $s1, 0x1001000b  # Load Address
    la $s2, 0x1001000c  # Load Address

    # 1.3.a
    lbu $t0, 0($s0)     # Load 0x56 into $t0, if un-aligned
    lbu $t1, 0($s1)     # Load 0x34 into $t1, if un-aligned
    lbu $t2, 0($s2)     # Load 0x12 into $t2, if un-aligned

    # 1.3.b             # If data are un-aligned, an error occurs, since these instructions are for aligned data
    lw $t3, words       # Load 0x12345678 into $t3
    lw $t0, words       # Load 0x12345678 into $t0
    lh $t1, halfword    # Load 0x6677 into $t1

    # 1.3.c
    ulw $t0, words      # Load 0x12345678 into $t0, un-aligned
    ulh $t1, halfword   # Load 0x87654321 into $t1, un-aligned

    # Exit
	li $v0, 0xa   # 10
	syscall 	  # au revoir...

.data
.align 0    # Un-alignes data
bytes: .byte 0x01, 0x02, 0x03, 0x04, 0x05, 0x81, 0x82, 0x83, 0x84
words: .word 0x12345678, 0x87654321
halfword: .half 0x6677
