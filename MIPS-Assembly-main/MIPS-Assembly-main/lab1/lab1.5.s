.text
       	.globl __start
__start:			# execution starts here

    li $v0, 5       # syscall to read integer
    syscall

    move $t0, $v0   # copy the typed integer to a usable register, in this case, $t0
    move $a0, $t0   # copy the int to $a0, so it can be printed (system always prints the integer stored in $a0)

    li $v0, 1       # syscall to print integer
    syscall

	li $v0, 0xa   # 10
	syscall 		# au revoir...

.data
