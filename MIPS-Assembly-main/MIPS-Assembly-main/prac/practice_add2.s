.text
.globl __start

__start:
	# SUM = -2
	#lw $t0, fullword	# t0 = -1
	#lb $t1, minusone	# t1 = -1
	#add $s0, $t0, $t1	# s0 = t0 + t1

	# SUM = 254
	#lw $t0, fullword	# t0 = -1
	#lbu $t1, minusone	# t1 = 255
	#addu $s1, $t0, $t1	# s1 = t0 + t1

	li $t0, 0x3fffffff
    li $t1, 0x3fffffff

    addu $t3, $t0, $t1  # Add unsigned -> carry bit
    add $t4, $t0, $t1   # Add signed

    li $t0, 0x7fffffff
    li $t1, 0x7fffffff

    addu $t3, $t0, $t1  # Add unsigned -> carry bit
    #add $t4, $t0, $t1   # Add signed , EXCEPTION FOUND - ARITHMETIC OVERFLOW

    li $t0, 0xffffffff
    li $t1, 0x1

    addu $t3, $t0, $t1  # Add unsigned -> carry bit - OVERFLOW
    add $t4, $t0, $t1   # Add signed

	li $v0,10
	syscall

.data
fullword: 	.word 0xFFFFFFFF
minusone:	.byte -1
