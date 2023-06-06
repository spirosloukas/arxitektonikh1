.text
.globl main

main:
  la  $s0, byte00       # Load the first byte's adress, so we can start reading data

  lbu $t0, ($s0)        # Load the first (unsigned) byte in $t0
  lhu $t1, ($s0)        # Load the first (unsigned) half-word in $t1
  lw  $t2, ($s0)        # Load the first word in $t2

  lbu $t3, 4($s0)       # Load the fifth (unsigned) byte in $t3
  lhu $t4, 4($s0)       # Load the third (unsigned) half-word in $t4
  lw  $t5, 4($s0)       # Load the second (unsigned) word in $t5

  lb $t0, ($s0)         # Load the first (signed) byte in $t0
  lh $t1, ($s0)         # Load the first (signed) half-word in $t1
  lw $t2, ($s0)         # Load the first word in $t2

  # Sign extension will occur for the first two cases that follow, due to
  # integer overflow (e.g. 0x81 = 129, which cannot be stored as an 8 bit
  # signed integer, since the the biggest 8 bit signed integer is +127)

  lb $t3, 4($s0)        # Load the fifth (signed) byte in $t3
  lh $t4, 4($s0)        # Load the third (signed) half-word in $t4
  lw $t5, 4($s0)        # Load the second word in $t5

  lbu $t6, 4($s0)       # Load the fifth (unsigned) byte in $t6
  sb  $t6, 16($s0)      # Store $t6's lowest byte on the address 0x10010010

  li $v0, 10            # Load the "exit" instruction in $v0
  syscall               # Exit the program

# Notice how there is no difference between signed/unsigned word loading,
# since each word contains the maximum number of bits that can be stored
# in a memory element, so basically there is no sign extension.

.data

byte00: .byte 0x01      # Allocates the first byte in the data segment
byte01: .byte 0x02      # Allocates the second byte in the data segment
byte02: .byte 0x03      # etc..
byte03: .byte 0x04
byte04: .byte 0x81
byte05: .byte 0x82
byte06: .byte 0x83
byte07: .byte 0x84

word08: .word 0x12345678
word0C: .word 0x87654321