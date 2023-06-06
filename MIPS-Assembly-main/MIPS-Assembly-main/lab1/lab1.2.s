.text
       	.globl __start
__start:			# execution starts here

    # 1.2.b
    lbu $t0, bytes  # loads 0x01 into $t0
    lhu $t1, bytes  # loads 0x201 into $t1
    lw $t2, bytes   # loads 0x4030201 into $t2

    # 1.2.c
    lbu $t3, bytes + 4  # loads 0x81 into $t3
    lhu $t4, bytes + 4  # loads 0x8281 into $t4
    lw $t5, bytes + 4   # loads 0x84838281 into $t5

    # 1.2.d
    lb $t0, bytes   # loads 0x01 into $t0 (signed, but no actual changes from the previous unsigned load)
    lh $t1, bytes   # loads 0x201 into $t1 (signed, but no actual changes from the previous unsigned load)
    lw $t2, bytes   # loads 0x4030201 int $t2 (signed, but no actual changes from the previous unsigned load)

    lb $t3, bytes + 4   # loads 0x81 into $t3 (signed, sign extension with 1's takes place)
    lh $t4, bytes + 4   # loads 0x8281 into $t4 (signed, sign extension with 1's takes place)
    lw $t5, bytes + 4   # loads 0x84838281 into $t5 (signed, but no actual changes from the previous unsigned load, since there's no room left any sign extensions)

    # 1.2.e
    lbu $t6, bytes + 4  # loads 0x81 into $t6 (unsigned)
    sb $t6, bytes + 16  # stores 0x81 into memory, RIGHT AFTER 0x87654321

    # Exit
	li $v0, 0xa   # 10
	syscall 	  # au revoir...

.data
bytes: .byte 0x01, 0x02, 0x03, 0x04, 0x81, 0x82, 0x83, 0x84
words: .word 0x12345678, 0x87654321
