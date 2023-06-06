#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"

word1: .word 0x12345678
word2: .word 0x87654321

bytes1: .byte 0x01, 0x02, 0x03, 0x04
bytes2: .byte 0x81, 0x82, 0x83, 0x84

testbyte: .space 1	# Space for just 1 byte
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start
__start:

# PLAN 1:
# t0 = bytes
# t1 = half words
# t2 = words

signed_bytes:

	# FIRST WAY
	lb $t0, bytes1 				# Load 0x01 into the LSB
	lb $t0, bytes1 + 1		# load 0x02 into the LSB
	lb $t0, bytes1 + 2		# load 0x03 into the LSB
	lb $t0, bytes1 + 3		# load 0x04 into the LSB

	# SECOND WAY
	la $s0, bytes1	# Save bytes1's address into $s0
	lb $t0, 0($s0) 	# Offset = 0, load 0x01
	lb $t0, 1($s0) 	# Offset = 1, load 0x02
	lb $t0, 2($s0) 	# Offset = 2, load 0x03
	lb $t0, 3($s0) 	# Offset = 3, load 0x04

	# LOAD ALL THE FOUR BYTES INTO THE REGISTER (since 4 bytes = 1 word)
	#lw $t0, bytes1	# Load 0x04030201 (the first 0 is skipped)

signed_half_words:
	# IMPORTANT NOTE: 1 half word = 2 bytes, (to load the second parts, we use 2 as the offset)

	# FIRST WAY
	lh $t1, bytes1			# load 0x0201 into $t1, (the first 0 is skipped)
	lh $t1, bytes1 + 2	# load 0x0403 into $t1, (the first 0 is skipped)

	# SECOND WAY
	la $s1, bytes1	# Save byte1's address into $s1
	lh $t1, 0($s1)	# Offset = 0, load 0201
	lh $t1, 2($s1)	# Offset = 2, load 0403

signed_words:
	# NOTE: 1 word = 4 bytes (the maximum capacity of a 32-bit register)

	# FIRST WAY
	lw $t2, word1		# Load 0x12345678 into $t2

	# SECOND WAY
	la $s2, word1		# Save word1's address into $s2
	lw $t2, 0($s2)	# Load 0x12345678 into $t2

# PLAN 2:
# t3 = bytes (unsigned)
# t4 = half words (unsigned)
# t5 = words (unsigned)

unsigned_bytes:

	# FIRST WAY
	lbu $t3, bytes2 			# Load 0x81 into the LSB
	lbu $t3, bytes2 + 1		# load 0x82 into the LSB
	lbu $t3, bytes2 + 2		# load 0x83 into the LSB
	lbu $t3, bytes2 + 3		# load 0x84 into the LSB

	# SECOND WAY
	la $s3, bytes2		# Save bytes2's address into $s3
	lbu $t3, 0($s3) 	# Offset = 0, load 0x81
	lbu $t3, 1($s3) 	# Offset = 1, load 0x82
	lbu $t3, 2($s3) 	# Offset = 2, load 0x83
	lbu $t3, 3($s3) 	# Offset = 3, load 0x84

	# LOAD ALL THE FOUR BYTES INTO THE REGISTER (since 4 bytes = 1 word)
	#lw $t3, bytes2	# Load 0x84838281

unsigned_half_words:
	# IMPORTANT NOTE: 1 half word = 2 bytes, (to load the second parts, we use 2 as the offset)

	# FIRST WAY
	lhu $t4, bytes2			# load 0x8281 into $t4
	lhu $t4, bytes2 + 2	# load 0x8483 into $t4

	# ANOTHER NOTE: If these loads were SIGNED, a SIGN EXTENSION would occur.
	# Here's an example:
	lh $t4, bytes2			# load 0x8281 into $t4, (sign extended)
	lh $t4, bytes2 + 2	# load 0x8483 into $t4, (sign extended)

	# SECOND WAY
	la $s4, bytes2	# Save byte2's address into $s4
	lhu $t4, 0($s4)	# Offset = 0, load 8281
	lhu $t4, 2($s4)	# Offset = 2, load 8483

unsigned_words:
	# NOTE: 1 word = 4 bytes (the maximum capacity of a 32-bit register)

	# FIRST WAY
	lw $t5, word2		# Load 0x87654321 into $t5

	# SECOND WAY
	la $s5, word2		# Save word2's address into $s5
	lw $t5, 0($s5)	# Load 0x87654321 into $t5

load_store:
	lbu $t6, bytes2 	# Load 0x81 into $t6
	sb $t6, testbyte	# Store the byte saved in $t6 into the memory address of 'testbyte'

Exit:				li 		$v0, 10
					syscall				#au revoir...


#################################################
#			 									#
#     	 	Useful code						#
#												#
#################################################

#print_endl:		la		$a0,endl 			# system call to print
#					li		$v0, 4 				# out a newline
#					syscall
#					jr $ra

#read_str:			li $v0, 8					# code to read a string
#					la $a0, ???					# ??? --> label with string
#					li $a1, ?n?					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
#					syscall
#					jr $ra

#print_str:			li $v0, 4
#					la $a0, ???					# ??? --> label with string
#					syscall
#					jr $ra

#read_int:			li		$v0, 5				# $v0 <--- integer
#					syscall
#					jr $ra

#print_int_from_reg:	move	$a0, ???			# ???  --> register with integer
#					li $v0, 1
#					syscall
#					jr $ra

#print_immidiate:	li $v0, 1
#					li $a0, ???					# ???  --> immediate
#					syscall
#					jr $ra

#read_float:		li		$v0, 6				# $f0 <--- float
#					syscall
#					jr $ra

#print_float_from_reg:	mov.s	$f12, ???			# ???  --> FP register with float
#					li $v0, 2
#					syscall
#					jr $ra

#print_float_immidiate:	li $v0, 2
#					li.s $f12, ???					# ???  --> immediate, e.g -1.2345678
#					syscall
#					jr $ra

#read_double:		li		$v0, 7				# $f0 <--- double
#					syscall
#					jr $ra

#print_double_from_reg:	mov.d	$f12, ???			# ???  --> FP register with float
#					li $v0, 3
#					syscall
#					jr $ra

#print_double_immidiate:	li $v0, 3
#					li.d $f12, ???					# ???  --> immediate, e.g -1.2345678
#					syscall
#					jr $ra

#leaf_proc_not_using_stack: ...........
#							...........
#							jr $ra

leaf_proc_using_stack:  #.....              // NOT $ra
			     		#addi $sp, $sp, -16 # 4 words or 4 registers (xx, xy, yy & yz) --> 4*n=4*4=16
						#...........
						#sw $xx, 0 ($sp)
						#...........
						#sw $xy, 4 ($sp)
						#...........
						#sw $yy, 8 ($sp)
						#...........
						#sw $yz, 12 ($sp)

						#...........
						#...........

						#lw $xx, 0 ($sp)
						#...........
						#lw $xy, 4 ($sp)
						#...........
						#lw $yy, 8 ($sp)
						#...........
						#lw $yz, 12 ($sp)
						#...........
						addi $sp, $sp, 16
						#...........
						jr $ra

node_proc_using_stack:  #...........
			     		#addi $sp, $sp, -16 # 3 words or 3 registers (xx, xy, zz & ra) --> 4*n=4*4=16
						#...........
						#sw $ra, 12 ($sp)
						#...........
						#sw $xx, 8 ($sp)
						#...........
						#sw $yy, 4 ($sp)
						#...........
						#sw $zz, 0 ($sp)

						#...........
						#...........

						#jal any_procedure # leaf_proc_non_using_stack or leaf_proc_using_stack or node_proc_using_stack

						#...........
						#...........

						#lw $zz, 0 ($sp)
						#...........
						#lw $yy, 4 ($sp)
						#...........
						#lw $xx, 8 ($sp)
						#...........
						#lw $ra, 12 ($sp)
						#...........
						#addi $sp, $sp, 16
						#...........
						#jr $ra

switch_case_no_break:   #...........
						#move $XY, $zero     	# initialize flag register $XY
		case01:			#bXX $YY,$ZZ, case02 	# this condition/case is not valid, check next case
		if_case01:		#...........
						#addi $XY, $XY, 1

		case02:			#bXX $YY,$ZZ, case?? 	# this condition/case is not valid, check next case
		if_case02:		#...........
						#addi $XY, $XY, 1

						#...........

		case0n:			#bXX $YY,$ZZ, case03 	# this condition/case is not valid, check next case
		if_case0n:		#...........
						#addi $XY, $XY, 1

		else_case:		#bne $XY,$zero, Exit	# non of previous conditions/cases exit, exit
		if_non_case:	#...........

switch_case_with_break: #...........
		case001:		#bXX $YY,$ZZ, case02 	# this condition/case is not valid, check next case
		if_case001:		#...........
						#j Exit_switch_case

		case002:		#bXX $YY,$ZZ, case?? 	# this condition/case is not valid, check next case
		if_case002:		#...........
						#j Exit_switch_case

						#...........

		case00n:		#bXX $YY,$ZZ, else_case 	# this condition/case is not valid, check next case
		if_case00n:		#...........
						#j Exit_switch_case

		else_case_:		#...........	 		# non of previous conditions/cases exit
		if_non_case_:	#...........

while_do_1_condition:   #...........
						#bXX $YY,$ZZ, exit_while

						#...........
						#addi #counter, #counter, 1  #possible approach

						j while_do_1_condition

while_do_a_AND_b:   	#...........				# when !a OR !b, exit while
						#bXX $RR,$ZZ, exit_while    # if a is not valid exit while
						#bYY $WW,$TT, exit_while    # if b is not valid exit while

						#...........
						#addi #counter, #counter, 1  #possible approach

						j while_do_a_AND_b

while_do_a_OR_b_1:   	#...........				# when !a AND !b, exit while
						#bXX $RR,$ZZ, exit_while    # if !a is not valid exit while
						#bYY $WW,$TT, exit_while    # if !b is not valid exit while

						#...........
						#addi #counter, #counter, 1  #possible approach

						j while_do_a_AND_b

while_do_a_OR_b_2:   	#...........				# when !a AND !b exit wile
			check_a:	#bXX $RR,$ZZ, check_b    	# if a is not valid check b

			do:			#...........
						#addi #counter, #counter, 1  #possible approach
						#j while_do_a_OR_b_2

			check_b:	#bYY $WW,$TT, exit_while    # if b is not valid exit while

						j do
