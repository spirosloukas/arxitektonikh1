##################################################
# lab3_3.s	#
##################################################
.text
.globl __start

__start:
	li $t1, 0		# counter for string
	li $s0, 't'		# character to end copy

while:
	lbu $t0, string($t1)	# load a character

	beq $t0,$s0, end		# if the "character to end" is found, copy and then exit loop

	sb $t0, copy($t1)		# copy character

	addi $t1,$t1,1			# increment counter (i++)

	j while					# repeat while loop

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
