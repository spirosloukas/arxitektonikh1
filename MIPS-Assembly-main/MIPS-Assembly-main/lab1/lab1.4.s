.text
       	.globl __start
__start:			# execution starts here

    # Read String
	li $v0, 8
    la $a0, string: # $a0 points to string
    li $a1, 20      # $a1 stores the length of the string
    syscall

    # Print String
    li $v0, 4
    syscall

    sb $zero, string + 5 # Replace 6th char with \0

    # Print String ($v0 still holds the value 4 from previous instruction)
    syscall

    # Exit
	li $v0, 0xa   # 10
	syscall 		# au revoir...

.data
string: .asciiz "01234567890123456789"
