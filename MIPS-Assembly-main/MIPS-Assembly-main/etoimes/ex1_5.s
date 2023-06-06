.text
.globl main

main:
  li $v0, 5             # Loads the "read integer" instruction code in $v0
  syscall               # System call to read an integer

  add $a0, $v0, $zero   # Same as move $a0, $v0

  li $v0, 1             # Loads the "print integer" instruction code into $v0
  syscall               # System call to print an integer

  li $v0, 10            # Loads the "exit" instruction code into $v0
  syscall               # System call to terminate the program

.data
  # Data goes here
