.text
.globl __start
__start:        # ecexution starts here
read_str:
    li $v0, 8       # code to read a string
    li $a1, 21      # max size = 20 bytes + 1
    la $a0, str_R   # $a0 points to the string
    syscall

print_str:
    li $v0, 4
    syscall

init_diff:
    li $t6, 32
load_a:
    li $t0, 'a'
load_z:
    li $t5, 'z'
    
    li $t7, 0

while:
    #la $t7, str_R
    #lbu $t1, 0($t7)

    lbu $t1, str_R($t7) # str_R+$t7 --> str_R[$t7]

    beqz $t1, print_endl
    blt $t1, $t0, store_char
    bgt $t1, $t5, store_char
    sub $t1, $t1, $t6

store_char:
    sb $t1, str_Caps($t7)   # copy character
    addi $t7, $t7, 1
    j while

print_endl:
    la $a0, endl
    syscall

print_Caps:
    la $a0, str_Caps
    syscall

Exit:
    li $v0, 10
    syscall

.data
    str_R: 		.asciiz "--------------------"
    str_Caps: 	.asciiz "--------------------"
    endl:		.asciiz "\n"
