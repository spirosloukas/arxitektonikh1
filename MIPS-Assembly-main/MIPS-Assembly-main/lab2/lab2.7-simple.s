.text
       	.globl __start
__start:			# execution starts here

  lw $s0, word1
  lw $s1, word2

  mult $s0, $s1

  mflo $s2
  mfhi $s3



	li $v0, 0xa   # 10
	syscall 		# au revoir...

.data
word1: .word 0x0000000A
word2: .word 0x00000008

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
