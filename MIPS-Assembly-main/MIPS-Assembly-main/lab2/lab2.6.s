.text
       	.globl __start
__start:			# execution starts here

  # $s0 = A low
  # $s1 = A high
  # $s2 = B low
  # $s3 = B high
  # $s4 = Result low
  # $s5 = Result high

  li $s0, 0xffffffff    # s0 = A low
  li $s1, 0x00000000    # s1 = A high

  addu $t0, $s0, $s2    # sum of the first (lowest) parts of A and B

  not $t0, $t0          # t0 = not lowA + lowB = S'

  and $t1, $t0, $s0     # t1 = S' and A low
  and $t2, $t0, $s2     # t2 = S' and B low
  and $t3, $t0, $s2     # t3 = A low and B low

  or $t4, $t1, $t2      # t4 = (S' and A low) or (S' and B low)
  or $t5, $t4, $t3      # t5 = (S' and A low) or (S' and B low) or (A low and B low)

  srl $a0, $t5, 31      # isolation of the low carry bit (C32)

  li $s2, 0x00000000    # s2 = A high
  li $s3, 0xffffffff    # s3 = B high

  addu $t0, $s0, $s2    # sum of the second (highest) parts of A and B

  not $t0, $t0          # t0 = not high A + high B = S'

  and $t1, $t0, $s0     # t1 = S' and A highhigh
  and $t2, $t0, $s2     # t2 = S' and B high
  and $t3, $t0, $s2     # t3 = A high and B high

  or $t4, $t1, $t2      # t4 = (S' and A high) or (S' and B high)
  or $t5, $t4, $t3      # t5 = (S' and A high) or (S' and B high) or (A high and B high)

  srl $a1, $t5, 31      # isolation of the high carry bit (C32)


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
