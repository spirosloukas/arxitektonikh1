.text
.globl main

main:
  la $a0, string_buf      # Loads string buffer's base address into $a0
  li $a1, 21              # Loads the buffer's size into $a1 (including '\0')

  li $v0, 8               # Loads the "read string" instruction code into $v0
  syscall                 # System call to read a string

  li $v0, 4               # Loads the "print string" instruction code into $v0
  syscall                 # System call to print a string

  sb $zero, 5($a0)        # Replaces the 6th character of the string stored in string_buf
                          # with the '\0' character (denoted by $zero in this case)

  li $v0, 4               # Loads the "print string" instruction code into $v0
  syscall                 # System call to print a string (it now prints the first 5 characters
                          # of the initial string)

  li $v0, 10              # Loads the "exit" instruction code into $v0
  syscall                 # System call to terminate the program

.data

string_buf: .space 21     # .space <bytes> allocates <bytes> bytes of memory on the data segment
                          # (in this case, 21 bytes are allocated: 20 for the string and 1 for '\0')
