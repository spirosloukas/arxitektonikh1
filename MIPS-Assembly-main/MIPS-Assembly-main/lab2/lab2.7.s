.text
       	.globl __start
__start:			# execution starts here

    lw $s0, wordA1   # load the 1st word into s0
    lw $s1, wordA2   # load the 2nd word into s1

    # SIGNED multiplication
    mult $s0, $s1   # s0 * s1
    mflo $s2        # s2 = low 32 bits of mult result
    mfhi $s3        # s3 = high 32 bits of mult result

    # UNSIGNED multiplication
    multu $s0, $s1  # s0 * s1
    mflo $s2        # s2 = low 32 bits of multu result
    mfhi $s3        # s3 = high 32 bits of multu result

#########################################################
    lw $s0, wordB1   # load the 1st word into s0
    lw $s1, wordB2   # load the 2nd word into s1

    # SIGNED multiplication
    mult $s0, $s1   # s0 * s1
    mflo $s2        # s2 = low 32 bits of mult result
    mfhi $s3        # s3 = high 32 bits of mult result

    # UNSIGNED multiplication
    multu $s0, $s1  # s0 * s1
    mflo $s2        # s2 = low 32 bits of multu result
    mfhi $s3        # s3 = high 32 bits of multu result

#########################################################
    lw $s0, wordC1   # load the 1st word into s0
    lw $s1, wordC2   # load the 2nd word into s1

    # SIGNED multiplication
    mult $s0, $s1   # s0 * s1
    mflo $s2        # s2 = low 32 bits of mult result
    mfhi $s3        # s3 = high 32 bits of mult result

    # UNSIGNED multiplication
    multu $s0, $s1  # s0 * s1
    mflo $s2        # s2 = low 32 bits of multu result
    mfhi $s3        # s3 = high 32 bits of multu result

	li $v0, 0xa   # 10
	syscall 		# au revoir...

.data
wordA1: .word 0x0000000A
wordA2: .word 0x00000008

wordB1: .word 0x00000002
wordB2: .word 0xFFFFFFFF

wordC1: .word 0x80000000
wordC2: .word 0x80000000

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
