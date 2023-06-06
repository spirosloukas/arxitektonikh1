#################################################
#
#
# lab4_3a.s
#
# stack exercise 2
#
#   PLAN:
#   $s0 = the first value of $sp, before any function call
#   $s1 = the lowest value of the stack's pointer at the last fuction call. Will be updated in every call.
#   $s2 = the total memory used by PROC
#
#################################################
.text
.globl __start
__start:                # start of main program

        la $a0,prompt
        li $v0,4
        syscall         # display "Enter integer number: "

        li $v0,5
        syscall         # read integer

        # ---print integer----  $a0 has the integer value to be printed
        move $a0, $v0
        li $v0, 1
        syscall

        move $s0, $sp   # save $sp's value into $s0, before the first call

        jal PROC        # Call the function for the first time (will call themselves recursively)

        jal print_endl
        jal print_message1
        sub $s2, $s0, $s1   # s2 = s0 (starting, highest sp) - s1 (final, lower sp)
        jal print_int_from_reg

        move $t0,$v0

        la $a0,endl
        li $v0,4
        syscall         # display end of line

        move $a0,$t0
        li $v0,10
        syscall         # exit

# end of main program


# start of procedure
PROC:
    addi $sp, $sp, -12  # Allocate space in the stack for 3 integers ($ra, $s0, $s1)

    move $s1, $sp       # save the current value of $ra into $s1

    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    move $t0, $a0      # Back-up $a0 into $t0, so $a0 can be used for syscalls

    la $a0,endl
    li $v0,4
    syscall             # display end of line

    move $a0, $t0       # Restore $a0

    # ---print integer----  $a0 has the integer value to be printed -- NO NEED TO DO ANYTHING!
    li $v0, 1
    syscall

    beqz $a0, RETURN    # If $a0 == 0, go to RETURN

                        # Else,
    sub $a0, $a0, 1     # subtract -1 from $a0
    jal PROC            # Recursively call PROC again

RETURN:
    lw $s1, 8($sp)
    lw $s0, 4($sp)
    lw $ra, 0($sp)

    addi $sp, $sp, 12  # Dislocate space in the stack for 3 integers

    jr $ra
# end of procedure

print_endl:		la		$a0,endl 			# system call to print
				li		$v0, 4 				# out a newline
				syscall
                jr $ra

print_message1:		li $v0, 4
					la $a0, message1			# message1 --> label with string
					syscall
					jr $ra

print_int_from_reg:	move	$a0, $s2			# s2  --> register with integer
					li $v0, 1
					syscall
					jr $ra

.data
prompt:     .asciiz "Enter integer number: "
endl:       .asciiz "\n"
message1:   .asciiz "Memory used (in bytes): "
#################################################
#
#
# End of program
#
#
#
#################################################
