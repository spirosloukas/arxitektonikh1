.text
       	.globl __start
__start:			# execution starts here
    # PLAN
    # s0 ==> byte0,
    # s1 ==> byte1,
    # s2 ==> byte2,
    # s3 ==> byte3,
    # s4 ==> result

	li $a0, 0x12345678

    srl $s0, $a0, 24
    sll $s3, $a0, 24

    #1st case ==> shift
    srl $s2, $a0, 8
    sll $s2, $s2, 24
    srl $s2, $s2, 8

    #2nd case ==> shift (alternative)
    srl $s2, $a0, 16
    sll $s2, $s2, 24
    srl $s2, $s2, 16

    #3rd case ==> mask
    andi $s2, $a0, 0xFF00
    sll $s2, $s2, 8

    ########################

    #1st case ==> shift
    srl $s2, $a0, 8 
    sll $s2, $s2, 24
    srl $s2, $s2, 8

    #2nd case ==> shift (alternative)
    srl $s1, $a0, 16
    sll $s1, $s1, 24
    srl $s1, $s1, 16

    #3rd case ==> mask
    li $t0, 0xFF00
    and $s1, $a0, $t0
    srl $s1, $s1, 8

    # MERGE
    or $t0, $s1, $s2
    or $t1, $s2, $s3
    or $s4, $t0, $t1

    # MERGE Alternative
    or $s4, $s0, $s1
    or $s4, $s4, $s2
    or $s4, $s4, $s3

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
