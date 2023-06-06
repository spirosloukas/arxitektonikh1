#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
aword:	.word 0xAABBCCDD

#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start
__start:
	# I have the word called "aword" and want to extract its 4 different bytes, using a mask

	# First off, im gonna load the word into register $a0, as is, without any modifications

	# NOTE 1 : Bytes inside a word are read from RIGHT to LEFT (<==)

	# NOTE 2 : For the mask, we use a specific word with FF's, depending of what byte we want to extract

	# NOTE 3 : To exctract the byte itself, we use a logical AND istruction

	# PLAN
	# a0 = the original word
	# t0 = MASK
	# s0 = byte0
	# s1 = byte1
	# s2 = byte2
	# s3 = byte3s

	lw $a0, aword 	# $s0 = AABBCCDD

	# Extracting byte 0 (dd)
	li $t0, 0xff
	and $s0, $a0, $t0

	# Extracting byte 1 (cc)
	li $t0, 0xff00
	and $s1, $a0, $t0

	# Extracting byte 2 (bb)
	li $t0, 0xff0000
	and $s2, $a0, $t0

	# Extracting byte 3 (aa)
	li $t0, 0xff000000
	and $s3, $a0, $t0


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
