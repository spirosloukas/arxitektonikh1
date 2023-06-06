.text
	lw $t0, num1
	lw $t1, num2
	
	mult $t0, $t1
	multu $t0, $t1
	
	mflo $s0
	move $a0, $s0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall

.data

num1: .word 0x7
num2: .word 0x8