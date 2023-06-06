.text
       	.globl __start
__start:			# execution starts here
	li $a0, 0x12345678

    li $t0, 0xff0000
    and $s1, $a0, $t0
    sll $s1, $s1, 8

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
