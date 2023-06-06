.text
	li $v0, 5
	syscall
	
	move $s0, $v0 # integer to be tested
	li $s1, 0
	
div2:	li $t0, 2
		div $s0, $t0
		mfhi $t0
		bne $t0, $zero, div3
		addi $s1, $s1, 1
		
		la $a0, msg2	# print message
		li $v0, 4
		syscall

div3:	li $t0, 3
		div $s0, $t0
		mfhi $t0
		bne $t0, $zero, div5
		addi $s1, $s1, 1
		
		la $a0, msg3	# print message
		li $v0, 4
		syscall
		
div5:	li $t0, 5
		div $s0, $t0
		mfhi $t0
		bne $t0, $zero, notdiv
		addi $s1, $s1, 1
		
		la $a0, msg5	# print message
		li $v0, 4
		syscall

notdiv:	bne $s1, $zero, Exit
		la $a0, msg
		li $v0, 4
		syscall
		
Exit:	li $v0, 10
		syscall 

.data

msg2: .asciiz "The number is divded by 2\n"
msg3: .asciiz "The number is divided by 3\n"
msg5: .asciiz "The number is divided by 5\n"
msg:  .asciiz "The number is not divided by 2, 3 or 5\n"