.text
       	.globl __start
__start:			# execution starts here

    li $t0, 0x3fffffff
    li $t1, 0x3fffffff

    addu $t3, $t0, $t1  # Add unsigned -> carry bit
    add $t4, $t0, $t1   # Add signed

    li $t0, 0x7fffffff
    li $t1, 0x7fffffff

    addu $t3, $t0, $t1  # Add unsigned -> carry bit
    add $t4, $t0, $t1   # Add signed

    li $t0, 0xffffffff
    li $t1, 0x1

    addu $t3, $t0, $t1  # Add unsigned -> carry bit - OVERFLOW
    add $t4, $t0, $t1   # Add signed

	li $v0, 0xa   # 10
	syscall 		# au revoir...

.data

# ---read string----
# li $v0, 8
# la $a0, label
# li $a1, n+1 # n = number of chars
# syscall

# ---print string----
# li $v0, 4
# la $a0, label
# syscall

# ---change line----
# li $v0, 4
# la $a0, endl
# syscall

# ---read integer---- do not forget to save the value of $v0
# li $v0, 5
# syscall

# ---print integer----  $a0 has the integer value to be printed
# li $v0, 1
# syscall
