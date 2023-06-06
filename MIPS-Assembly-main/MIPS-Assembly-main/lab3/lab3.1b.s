.text
       	.globl __start
__start:			# execution starts here
    # REGISTER MAP
    # t0 = number entered from console
    # s2 = 2 (constant)
    # s3 = 3 (constant)
    # s5 = 5 (constant)
    # t7 = flag
    # s0 = address of END

    li $t7, 0               # This is the flag, initialized to 0

    la $s0, END

    # ---print string----
    li $v0, 4
    la $a0, type
    syscall

    # ---read integer---- do not forget to save the value of $v0
    li $v0, 5
    syscall

    move $t0, $v0           # save the typed integer into s0

    # ---print integer----  $a0 has the integer value to be printed
    move $a0, $t0
    li $v0, 1
    syscall

    # ---change line----
    li $v0, 4
    la $a0, endl
    syscall

DIV2:
    li $s2, 2
    div $t0, $s2            # t0/2

    #mflo $t1               # t1 = quotient
    mfhi $t2                # t2 = remainder

    bne $t2, $zero, DIV3    # If remainder != 0, the number CANNOT be divided by 2, go to DIV3

    # Else, if the number can be divided by 2 (if remainder == 0)
    addi, $t7, $t7, 1       # Increase the flag by 1 (flag += 1)

    # ---print string----
    li $v0, 4
    la $a0, message2        # Print the message
    syscall
    jr $s0

DIV3:
    li $s3, 3
    div $t0, $s3            # t0/3

    #mflo $t1               # t1 = quotient
    mfhi $t2                # t2 = remainder

    bne $t2, $zero, DIV5    # If remainder != 0, the number CANNOT be divided by 3, go to DIV5

    # Else, if the number can be divided by 3 (if remainder == 0)
    addi, $t7, $t7, 1       # Increase the flag by 1 (flag += 1)

    # ---print string----
    li $v0, 4
    la $a0, message3        # Print the message
    syscall
    jr $s0

DIV5:
    li $s5, 5
    div $t0, $s5            # t0/5

    #mflo $t1               # t1 = quotient
    mfhi $t2                # t2 = remainder

    bne $t2, $zero, DIVALL  # If remainder != 0, the number CANNOT be divided by 5, go to DIVALL

    # Else, if the number can be divided by 5 (if remainder == 0)
    addi, $t7, $t7, 1       # Increase the flag by 1 (flag += 1)

    # ---print string----
    li $v0, 4
    la $a0, message5        # Print the message
    syscall
    jr $s0

DIVALL:
    bne $t7, $zero, END     # If flag != 0, the number is divided by 2 or 3 or 5, go to END

    # Else, the number cannot be defided with the above (if flag == 0)

    # ---print string----
    li $v0, 4
    la $a0, messagex
    syscall

END:
    li $v0, 0xa   # 10
    syscall 		# au revoir...

.data
message2: .asciiz "The number can be divided perfectly by 2\n"
message3: .asciiz "The number can be divided perfectly by 3\n"
message5: .asciiz "The number can be divided perfectly by 5\n"
messagex: .asciiz "The number cannot be divided by 2, 3 or 5\n"

type:   .asciiz "Type a number: "
endl:   .asciiz "\n"

# ---read string----
# li $v0, 8
# la $a0, label
# li $a1, n+1 # n = number of chars
# syscall

# ---print string----
# li $v0, 4
# la $a0, label
# syscall

# ---change line----
# li $v0, 4
# la $a0, endl
# syscall

# ---read integer---- do not forget to save the value of $v0
# li $v0, 5
# syscall

# ---print integer----  $a0 has the integer value to be printed
# li $v0, 1
# syscall
