.text		
       	.globl __start 
__start:			# execution starts here
	li $t0, 0x12345678
	srl $t1, $t0, 24
	sll $t2, $t0, 24
	srl $t3, $t0, 8
	andi $t3, $t3, 0xff00
	andi $t4, $t0, 0xff00
	sll $t4, $t4, 8
	or $t5, $t1, $t2
	or $t6, $t3, $t4
	or $t7, $t5, $t6
	li $v0, 0xa   # 10
	syscall 		# au revoir...
	
.data