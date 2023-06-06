.text
.globl main

main:
  li $v0, 5             # Reads the first integer
  syscall

  move $s0, $v0         # Moves it to $s0

  li $v0, 5             # Reads the second integer
  syscall

  move $s1, $v0         # Moves it to $s1

  add $a0, $s0, $s1     # Stores their sum in $a0
  li $v0, 1             # .. and prints it
  syscall;

  sub $a0, $s0, $s1     # Stores their difference in $a0
  li $v0, 1             # .. and prints it
  syscall;

  li $v0, 10            # Loads the "exit" instruction into $v0
  syscall               # System call to terminate the program ..

.data
  # Data goes here