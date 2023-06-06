.text
       	.globl __start
__start:			# execution starts here

    li $s0, 0x80000000      # $s0 = A
    li $s1, 0x00000001      # $s1 = B

    addu $s2, $s0, $s1      # $s2 = A+B

    not $s2, $s2            # $s2 = not A+B

    and $t0, $s2, $s0       # $t0 = S' and A
    and $t1, $s2, $s1       # $t1 = S' and B
    and $t2, $s0, $s1       # $t2 = A and B

    or $t3, $t0, $t1        # $t3 = (S' and A) or (S' and B)
    or $t4, $t2, $t3        # $t4 = (S' and A) or (S' and B) or (A and B)

    srl $a0, $t4, 31        # isolation of the carry bit (C32)

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
