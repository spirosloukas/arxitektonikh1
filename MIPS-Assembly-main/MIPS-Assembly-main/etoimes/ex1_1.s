.text
.globl main

main:
  la $t2, str                # $t2 points to the string
  li $t1, 0                  # $t1 holds the count

next_ch:
  lb $t0, ($t2)              # Get a byte from string
  beqz $t0, str_end          # Zero (z) means end of string
  add $t1, $t1, 1            # Increment count
  add $t2, 1                 # Move pointer one character
  j next_ch                  # Go round the loop again

str_end:
  la $a0, ans                # System call to print
  li $v0, 4                  # out a message
  syscall
  move $a0, $t1              # System call to print
  li $v0, 1                  # out the length worked out
  syscall
  la $a0, endl               # System call to print
  li $v0, 4                  # out a newline
  syscall

exit:
  li $v0, 10
  syscall

.data

str:  .asciiz "hello world"
ans:  .asciiz "Length is "
endl: .asciiz "\n"
