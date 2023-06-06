.text
       	.globl __start
__start:			# execution starts here

    lw $t0, aword

    srl $s0, $t0, 24    #byte 0
    sll $s0, $t1, 24    #byte 3
    sll $s0, $t2, 16    #byte 2
    srl $s0, $t3, 24
    sll $s0, $t4, 16    #byte 1

    srl $s0, $t5, 16
    sll $s0, $t6, 24
    srl $s0, $t7, 16

    or $s1, $t0, $t7
    or $s2, $t4, $t1
    or $s3, $s1, $s2

	li $v0, 0xa   # 10
	syscall 		# au revoir...

.data
aword: .word 0xAABBCCDD
