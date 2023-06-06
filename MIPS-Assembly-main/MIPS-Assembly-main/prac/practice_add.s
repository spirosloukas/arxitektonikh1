.text
.globl __start

__start:

	addi	$t0, $zero, 15
	addi	$t1, $zero, 5
	add		$t2, $t0, $t1

	li $v0,10
	syscall

.data
