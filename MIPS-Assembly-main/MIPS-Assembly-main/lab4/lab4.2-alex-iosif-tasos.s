.text

li $v0, 5
syscall

move $a0, $v0

jal Proc

END:
	li $v0, 10
	syscall


Proc:
		beq $a0, $zero, Exit
		addi $sp, $sp, -4
		sw $a0, 0($sp)
		addi $a0, $a0, -1
		addi $t0, $t0, 1
		jal Proc
Exit:	li $v0, 1
		syscall
Loop:	lw $a0, 0($sp)
		addi $sp, $sp, 4
		li $v0, 1
		syscall
		addi $t0, $t0, -1
		bne $t0, $zero, Loop		
		j END

.data