#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"

buffer: .space 10
str1: 	.asciiz "Enter number (max 4 octal digits): "
str2: 	.asciiz "You wrote:\n"

one: 	.asciiz "001"
two: 	.asciiz "010"
three: 	.asciiz "011"
four: 	.asciiz "100"
five: 	.asciiz "101"
six: 	.asciiz "110"
seven:	.asciiz "111"

wrong: 		.asciiz "wrong WRONG_INPUT"
converted:	.asciiz "Converted:\n"
bye:		.asciiz "bye"

number:		.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 0
number1:	.word 2
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start
__start:
	li $t1, 7 	# This is the "i", as in a FOR function in C

LOOP:
	la $a0, endl
	jal print_str

	la $a0, str1
	jal print_str

	la $a0, endl
	jal print_str

	la $a0, buffer
	li $a1, 5			# read 4 charachters, +1 for \0
	jal read_str

	move $t0, $a0

	la $a0, str2
	jal print_str

	la $a0, buffer
	move $a0, $t0
	jal print_str
	la $a0, endl
	jal print_str

	la $a0, converted
	jal print_str

	la $a0, endl
	jal print_str

CHECKTYPE:
	lb $t2, 0($t0)
	beqz $t2, LOOP
	beq $t2, '1', PRINT_1
	beq $t2, '2', PRINT_2
	beq $t2, '3', PRINT_3
	beq $t2, '4', PRINT_4
	beq $t2, '5', PRINT_5
	beq $t2, '6', PRINT_6
	beq $t2, '7', PRINT_7

	j WRONG_INPUT

CONT:
	add $t0, 1
	j CHECKTYPE

PRINT_1:
	la $a0, one
	jal print_str
	j CONT

PRINT_2:
	la $a0, two
	jal print_str
	j CONT

PRINT_3:
	la $a0, three
	jal print_str
	j CONT

PRINT_4:
	la $a0, four
	jal print_str
	j CONT

PRINT_5:
	la $a0, five
	jal print_str
	j CONT

PRINT_6:
	la $a0, six
	jal print_str
	j CONT

PRINT_7:
	la $a0, seven
	jal print_str
	j CONT

WRONG_INPUT:
	la $a0, endl
	jal print_str
	la $a0, wrong
	jal print_str
	la $a0, endl
	jal print_str

Exit:
					la $a0, endl
					jal print_str
					la $a0, bye
					jal print_str
					la $a0, endl
					jal print_str
					li 		$v0, 10
					syscall				#au revoir...


#################################################
#			 									#
#     	 	Useful code						#
#												#
#################################################

print_endl:		la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
					jr $ra

read_str:			li $v0, 8					# code to read a string
#					la $a0, ???					# ??? --> label with string
#					li $a1, ?n?					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
					syscall
					jr $ra

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
