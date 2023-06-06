.text

	li $v0, 5
	syscall
	move $t0, $v0

	li $v0, 5
	syscall
	move $t1, $v0

	div $t0, $t1

	mfhi $s0
	mflo $s1

	move $a0, $s0 # ypoloipo
	li $v0, 1
	syscall

	move $a0, $s1 # piliko
	li $v0, 1
	syscall

	li $v0, 10
	syscall

.data

newline: .asciiz "\n"
