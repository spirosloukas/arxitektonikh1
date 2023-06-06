.text
       	.globl __start
__start:			# execution starts here
	lb $t0, byte1

  # LOGICAL SHIFTS
  sll $t1, $t0, 1   # <--
  srl $t2, $t0, 1   # -->

  # ARITHMETIC SHIFT(S)
  sra $t3, $t0, 1   # identical to srl

	li $v0, 0xa   # 10
	syscall 		# au revoir...

.data
byte1: .byte 0x25

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
