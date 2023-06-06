#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
leafmessage:	.asciiz "This is a leaf using the stack. Doin' some calculations and returnin'!\n"
leafmessage2:	.asciiz "This is a leaf. Just returnin'!\n"
nodemessage:	.asciiz "This is a node.\n"
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start
__start:

		li $s0, 1
		li $s1, 2
		li $s2, 3

		jal node_proc_using_stack




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

print_str:			li $v0, 4
#					la $a0, ???					# ??? --> label with string
					syscall
					jr $ra

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

leaf_proc_not_using_stack:
						la $a0, leafmessage2
						jal print_str
						jr $ra

leaf_proc_using_stack:  #.....              // NOT $ra
			     		addi $sp, $sp, -16 # 4 words or 4 registers (xx, xy, yy & yz) --> 4*n=4*4=16

						sw $s0, 0 ($sp)
						sw $s1, 4 ($sp)
						sw $s2, 8 ($sp)
						sw $s3, 12 ($sp)

						la $a0, leafmessage
						#jal print_str 		# DON'T USE FUNCTIONS IN A STACKED LEAF, $ra GETS F'ED UP
						li $v0, 4
						syscall

						jal leaf_proc_not_using_stack

						li $t0, 0xAABBCCDD
						li $t1, 0xDDCCBBAA
						add $s0, $t0, $t1
						addi $s1, $s0, 0x03

						move $v0, $s1

						lw $s0, 0 ($sp)
						lw $s1, 4 ($sp)
						lw $s2, 8 ($sp)
						lw $s3, 12 ($sp)

						addi $sp, $sp, 16
						jr $ra

node_proc_using_stack:  #...........
			     		addi $sp, $sp, -16 # 3 words or 3 registers (xx, xy, zz & ra) --> 4*n=4*4=16

						sw $ra, 12 ($sp)
						sw $s0, 8 ($sp)
						sw $s1, 4 ($sp)
						sw $s2, 0 ($sp)

						li $s0, 7
						li $s1, 8
						li $s2, 9

						la $a0, nodemessage
						jal print_str

						jal leaf_proc_using_stack # leaf_proc_non_using_stack or leaf_proc_using_stack or node_proc_using_stack

						lw $s0, 0 ($sp)
						lw $s1, 4 ($sp)
						lw $s2, 8 ($sp)
						lw $ra, 12 ($sp)

						addi $sp, $sp, 16
						jr $ra

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
