##################################################
# lab3_3.s	#
##################################################
.text
.globl __start

# επανάληψη όσο ο τρέχων χαρακτήρας που διαβάζεται δεν είναι ο 't' Ή δεν έχουν
# διαβαστεί πάνω από 10 χαρακτήρες. Το ν είναι πάλι µία σταθερά που θα αποθηκεύεται σε έναν καταχωρητή.

__start:
	li $t1, 0		# counter for string
	li $s0, 't'		# character to end copy
	li $s1, 14		# character limit (once reached, end copy)

	li $s2, 0		# flag for the end char. 0 = not found, 1 = found
	li $s3, 0		# flag for the limit reach. 0 = not reached, 1 = reached
	li $s7, 0		# flag for the OR result. 0 = do not exit, 1 = exit
	li $s6, 1		# Reference for the OR instruction. Always set to 1.

while:
	# CHECK EVALUATION
	or $s7, $s2, $s3		# s7 = ender_found OR limit_reached
	beq $s7, $s6, end		# if s7 == 1 (stored in $s6), terminate

	lbu $t0, string($t1)	# load a character

	# CHECKS
	beq $t0,$s0, ender_found		# if the "character to end" is found, copy and then exit loop
	ble	$s1, $t1, limit_reached		# if $s1 <= $t1 (if the limit that's in $s1 is reached), then exit loop

	# COPY
	sb $t0, copy($t1)		# copy character

	addi $t1,$t1,1			# increment counter (i++)

	j while					# repeat while loop

ender_found:
	li $s2, 1	# end charachter found
	j while

limit_reached:
	li $s3, 1	# limit is reached
	j while

end:
	li $t2,0
	sb $t2,copy($t1)		# append end character to copied string

	la $a0, copy			# display copy
	li $v0,4
	syscall

	li $v0,10				# exit
	syscall

.data
string:	.asciiz "Mary had a little lamb"
copy:	.space 80
#################################################
#end of program
#################################################
