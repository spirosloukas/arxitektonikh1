.text
       	.globl __start
__start:			# execution starts here

    lw $t0, word1
    andi $t1, $t0, 0xFF00   # MASK byte 0
    andi $t2, $t0, 0x00FF   # MASK byte 1

    lw $t0, word2
    andi $s3, $t0, 0xFF00   # MASK byte 2
    andi $t4, $t0, 0x00FF   # MASK byte 3

    or $s1, $t1, $t2
    or $s2, $t3, $t4
    or $s3, $s2, $s1

	li $v0, 0xa   # 10
	syscall 		# au revoir...

.data
word1: .word 0xAABB
word2: .word 0xCCDD
