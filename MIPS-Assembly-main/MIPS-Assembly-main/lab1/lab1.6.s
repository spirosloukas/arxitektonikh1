.text
       	.globl __start
__start:			# execution starts here

    # Read int
    li $v0, 5
    syscall
    move $t0, $v0

    # Print int
    li $v0, 1
    move $a0, $t0
    syscall

    # New Line
    la $a0, nl
    li $v0, 4
    syscall

    # Read int
    li $v0, 5
    syscall
    move $t1, $v0

    # Print int
    li $v0, 1
    move $a0, $t1
    syscall

    # New Line
    la $a0, nl
    li $v0, 4
    syscall

    # Sum of the 2 ints
    add $s0, $t0, $t1

    # Print sum
    li $v0, 1
    move $a0, $s0
    syscall

    # New Line
    la $a0, nl
    li $v0, 4
    syscall

    # Diff of the 2 ints
    sub $s1, $t0, $t1

    # Print diff
    li $v0, 1
    move $a0, $s1
    syscall

    # Exit
	li $v0, 0xa   # 10
	syscall 		# au revoir...

.data
nl: .asciiz "\n"
