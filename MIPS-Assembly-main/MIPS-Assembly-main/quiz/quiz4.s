.text
.globl __start
__start: # execution starts here
    lw $s1, the_word

        addi $t0, $zero, 32
loop:   sll $s2, $s2, 1
        andi $t1, $s1, 1
        or $s2, $s2, $t1
        srl $s1, $s1, 1
        addi $t0, $t0, -1
        bne $t0, $zero, loop

	li $v0, 0xa   # 10
	syscall 		# au revoir...

.data
the_word: .word 0xAABBCCDD
