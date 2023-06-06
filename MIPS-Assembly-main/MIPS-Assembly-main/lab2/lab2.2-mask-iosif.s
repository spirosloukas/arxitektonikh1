.text		
       	.globl __start 
__start:
	
lw $t0, word
andi $t1, $t0, 0xff00 #mask byte 0
andi $t2, $t0, 0x00ff #mask byte 1

lw $t0, word2
andi $t3, $t0, 0xff00 #mask byte 2
andi $t4, $t0, 0x00ff #mask byte 3

or $s1, $t1, $t2
or $s2, $t3, $t4
or $s3, $s1, $s2

li $v0, 10
syscall


	
	
	
.data
word: .word 0xAABB
word2: .word 0xCCDD

newline: .asciiz "\n"