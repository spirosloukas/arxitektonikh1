#################################################
#
#
# lab5_3b.s
#
# Floating-point factorial
#
#
##################################################
.text
.globl __start
__start:
				la $a0,n
				lw $t0,0($a0) 		# $t0 = n
				mtc1 $t0, $f0		# CAREFUL! f2 = t0
				cvt.s.w $f0, $f0	# convert int to float (single)

				li $t2,1			# $t2 index i=1..n
				mtc1 $t2, $f2		# CAREFUL! f2 = t2
				cvt.s.w $f2, $f2	# convert int to float (single)

				li $t1,1			# $t1 contains i!
				mtc1 $t1, $f1		# CAREFUL! f1 = t1
				cvt.s.w $f1, $f1	# convert int to float (single)

loop: 			mul.s $f1,$f1,$f2	# f1 = f1 * f2

				#move $a0,$t2
				#li $v0,1
				mov.s	$f12, $f2	# f2  --> FP register with float
				li $v0, 2
				syscall				# display i

				la $a0,msg1
				li $v0,4
				syscall				# display "! is :"

				#move $a0,$t1
				#li $v0,1
				mov.s	$f12, $f1	# f1  --> FP register with float
				li $v0, 2
				syscall				# display i!

				la $a0,endl
				li $v0,4
				syscall				# print end of line

				li.s $f31, 1.0		# f31 = 1
				add.s $f2,$f2,$f31	# i=i+1

				# repeat if i<=n
				c.le.s $f2, $f0				# Compare less than equal single
				bc1t loop 					# if comparison == 1, go to loop

				li $v0,10			# exit
				syscall
.data
n:		.word 25
msg1:	.asciiz "! is :"
endl:	.asciiz "\n"
#################################################
#
#
# End of program
#
#
#
#################################################
