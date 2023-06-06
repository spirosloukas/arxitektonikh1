.text
.globl main

main:
  la  $s0, byte00

  # Part: A (Data segment is the same as in exercise 1.2)

  # lbu $t0, 10($s0)
  # lbu $t1, 11($s0)
  # lbu $t2, 12($s0)

  # Part: B (The new data segment is shown below)

  # lw $t0, 12($s0) # Offset is set to 12, since there is an extra byte (auto-allignment)
  # lh $t1,  6($s0)

  # Part: C (For this part, the data allignment is turned off)

  ulw $t0, 11($s0) # Offset is set to 11, since auto-allignment is turned off
  ulh $t1,  5($s0) # Same as above

  li $v0, 10
  syscall

.data
.align 0 # Automatic data allignment is turned off (0 : False)

byte00: .byte 0x01
byte01: .byte 0x02
byte02: .byte 0x03
byte03: .byte 0x04
byte04: .byte 0x05
half05: .half 0x6677
byte07: .byte 0x81
byte08: .byte 0x82
byte09: .byte 0x83
byte0A: .byte 0x84
word0B: .word 0x12345678
word10: .word 0x87654321