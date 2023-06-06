.text
       	.globl __start
__start:			# execution starts here
    # PLAN
    # a0 = pointer to the entered string
    # t0 = character counter
    # t1 = current character to check
    # s0 = 97 (constant)
    # s1 = 122 (constant)

    addi $t0, $zero, 0      # $t0 = 0
    li $s1, 'a'             # ASCII code of 'a'
    li $s2, 'z'             # ASCII code of 'z'

  # ---read string----
  li $v0, 8
  la $a0, string            # a0 points to the string
  li $a1, 21                # a1 = number of chars
  syscall

  # ---print string----
  li $v0, 4
  la $a0, string
  syscall

Loop:
    lbu $t1, string($t0)             # Load the current char into $t1 (t0 = counter/offset)

    # beqz $t1, Exit
    beq $t1, $zero, ChangeLine      # if char == \0, go to ChangeLine

    # Else (if char != 0),
    blt $t1, $s1, StoreChar         # if char < 97, the letter is not lower-case, go to StoreChar
    bgt $t1, $s2, StoreChar         # if char > 122, the letter is not lower-case, go to StoreChar

    # Else (if char is lower-case),
    addi $t1, $t1, -32              # convert lower-case to upper-case

StoreChar:
    sb $t1, string($t0)             # put the converted char back in its place
    addi $t0, $t0, 1                # increase the character counter by 1 (NOTE: counter is increased right before the return to Loop)
    jr Loop                         # go back to the loop

ChangeLine:
    # ---change line----
    li $v0, 4
    la $a0, endl
    syscall

PrintString:
    # ---print string----
    li $v0, 4
    la $a0, string
    syscall

Exit:
  li $v0, 0xa   # 10
  syscall 		# au revoir...

.data
string: .space 21
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
