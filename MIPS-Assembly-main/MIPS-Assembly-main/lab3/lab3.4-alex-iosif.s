.text

	li $v0, 8
	la $a0, buf
	li $a1, 21
	syscall
	move $s0, $a0
	
		li $t0, 97
		li $t1, 122
		addi $s0, $s0, -1
Loop: 
		addi $s0, $s0, 1
		beq $s0, $zero, Exit
		blt $s0, $t0, Loop
		bgt $s0, $t1, Loop
		addi $s0, $s0, -32
		jr Loop	 

Exit:   
		move $s0, $a0
		li $v0, 4
		syscall
		
		li $v0, 10 
		syscall

.data
	buf: .space 21