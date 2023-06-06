.text
       	.globl __start
__start:			# execution starts here

	# la $s0, bytes # s0 holds the memory address of label "bytes"
    # lbu $t0, 0($s0) <==> lbu $t0, bytes
    # t0 stores the item located at the address:
    # abs($s0) + 0 ==> first item of "bytes" ==> 0x01, since offset is 0

    # LOAD BYTE
    lbu $t0, bytes      # stores 0x01 into t0
    lbu $t1, bytes + 1  # stores 0x02 into t1
    lbu $t2, bytes + 2  # stores 0x03 into t2
    lbu $t3, bytes + 3  # stores 0x04 into t2
    lbu $t4, bytes + 4  # stores 0x81 into t4
    lbu $t5, bytes + 5  # stores 0x82 into t5
    lbu $t6, bytes + 6  # stores 0x83 into t6
    lbu $t7, bytes + 7  # stores 0x84 into t7

    # LOAD HALF-WORD
    lh $t0, bytes       # Stores the first two bytes (2 bytes = 1 halfword) into t1
    lh $t1, bytes + 2   # Stores 0x03 and 0x04 into t1. In order to reach 0x03, the offset is 2.

    # LOAD WORD
    lw $s0, words
    lw $s1, words + 4   # To go to the next word, we add 4, since 1 word = 4 bytes

    # EXIT
	li $v0, 0xa   # 10
	syscall 	  # au revoir...

.data
bytes: .byte 0x01, 0x02, 0x03, 0x04, 0x81, 0x82, 0x83, 0x84
words: .word 0x12345678, 0x87654321
