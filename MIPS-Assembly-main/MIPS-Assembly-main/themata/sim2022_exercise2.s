.text
.globl main
main:   
        
         li $a1 , 5
        la $a0 , string
        li $v0 , 8
        syscall
        move $t1 , $v0
        li $t2 , 0
        li $t0 , 0
        addi $t4 , $a1 , -1
        jal while


while: lb $t1 , string($t0)
       beq $t0 , $t4 , read
       addi $t1 , $t1 , -48
       bge $t1 , 8 , exit
       beqz $t1 , print
       beq $t1 , 1 , print1
       beq $t1 , 2 , print2
       beq $t1 , 3 , print3
       beq $t1 , 4 , print4
       beq $t1 , 5 , print5
       beq $t1 , 6 , print6
       beq $t1 , 7 , print7
       

print:      la $a0 , zero
            addi $t2 , $t2 , 1
            beq $t2 , 4 , exit
            jal printSTRING
            jal additional

print1:     la $a0 , one
            jal printSTRING
            jal additional

print2:     la $a0 , two
            jal printSTRING
            jal additional

print3:     la $a0 , three
            jal printSTRING
            jal additional

print4:     la $a0 , four
            jal printSTRING
            jal additional

print5:     la $a0 , five 
            jal printSTRING
            jal additional

print6:     la $a0 , six
            jal printSTRING
            jal additional

print7:     la $a0 , seven
            jal printSTRING
            jal additional

printSTRING:   li $v0 , 4
               syscall
               jr $ra

additional:  addi $t0 , $t0 , 1
             j while

exit:   la $a0 , endline
        li $v0 , 4
        syscall
        la $a0 , string1
        li $v0 , 4
        syscall
        la $a0 , endline
        li $v0 , 4
        syscall
        li $v0 , 10
        syscall

exit1:   li $v0 , 10
        syscall

read:   la $a0 , endline
        li $v0 , 4
        syscall
        li $t1 , 0
        la $a0 , string
        li $v0 , 8
        syscall
        move $t1 , $v0
        li $a1 , 5
        li $t2 , 0
        li $t0 , 0
        addi $t4 , $a1 , -1
        j while


.data
input: .asciiz "4567"
string:   .space 5
string2:   .space 5

zero:      .asciiz "000"
one: .asciiz "001"
two:    .asciiz "010"
three: .asciiz "011"
four: .asciiz "100"
five: .asciiz "101"
six: .asciiz "110"
seven: .asciiz "111"
endline: .asciiz "\n"
string1: .asciiz "Invalid Input."
zero1: .asciiz "0000"
