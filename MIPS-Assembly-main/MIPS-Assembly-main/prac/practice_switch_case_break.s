#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
message:	.asciiz "Type a number: "
mess1:	.asciiz "The number you typed is one\n"
mess2:	.asciiz "The number you typed is two\n"
mess3:	.asciiz "The number you typed is three\n"
mess4:	.asciiz "The number you typed is four\n"
#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start
__start:
	# This program finds if a number typed in the console is equal to 1,2,3 or 4 (SWITCH CASE WITH BREAK)

	# NOTE: The differemce is that we save the address of Exit in a register.
	# After a check fails, we go straight to the Exit, without continuing with other checks.

	la $s0, Exit 	# $s0 now points to the Exit
	li $s1, 0		# Flag/Counter || 0 = it is NOT 1,2,3 or 4 || 1 = it is 1,2,3 or 4

	la $a0, message
	jal print_str

	jal read_int
	jal print_int_from_reg

	move $t0, $a0 	# move the integer to $t0

	jal print_endl

switch_case_with_break:

	is1:	li $t1, 1
			bne $t0, $t1, is2 	# if $t0 != $t1, go to is2
			la $a0, mess1		# Else, print that the number is indeed 1
			jal print_str
			jal print_endl
			jr $s0

	is2:	li $t2, 2
			bne $t0, $t2, is3 	# if $t0 != $t1, go to is3
			la $a0, mess2		# Else, print that the number is indeed 2
			jal print_str
			jal print_endl
			jr $s0

	is3:	li $t3, 3
			bne $t0, $t3, is4 	# if $t0 != $t1, go to is4
			la $a0, mess3		# Else, print that the number is indeed 3
			jal print_str
			jal print_endl
			jr $s0

	is4:	li $t4, 4
			bne $t0, $t4, Exit 	# if $t0 != $t1, go to Exit
			la $a0, mess4		# Else, print that the number is indeed 4
			jal print_str
			jal print_endl
			jr $s0

Exit:				li 		$v0, 10
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

#read_str:			li $v0, 8					# code to read a string
#					la $a0, ???					# ??? --> label with string
#					li $a1, ?n?					# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
#					syscall
#					jr $ra

print_str:			li $v0, 4
#					la $a0, ???					# ??? --> label with string
					syscall
					jr $ra

read_int:			li		$v0, 5				# $v0 <--- integer
					syscall
					jr $ra

print_int_from_reg:	move	$a0, $v0			# ???  --> register with integer
					li $v0, 1
					syscall
					jr $ra

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
