.text
.globl main
main:   
        la $a0 , string
        li $v0 , 4
        syscall
        li $v0 , 5
        syscall
        move $t0 , $v0
        move $t1 , $v0
        li $t2 , 10
        li $t3 , 0
        jal while

while:  beqz $t0 , exiting
        jal while1



while1: beqz $t1 , read
        div $t1 , $t2
        mflo $s0
        mfhi $s1
        jal printsymbol
        move $t1 , $s0
        addi $t3 , $t3 , 1
        j while1

printsymbol:  move $a0 , $s1
              li $v0 , 1
              syscall
              la $a0 , multi
              li $v0 , 4
              syscall
              move $a0 , $t2
              li $v0 , 1
              syscall
              la $a0 , power
              li $v0 , 4
              syscall
              move $a0 , $t3
              li $v0 , 1
              syscall
              la $a0 , plus
              li $v0 , 4
              syscall
              jr $ra


read:       la $a0 , endline
            li $v0 , 4
            syscall
            la $a0 , string
            li $v0 , 4
            syscall
            li $v0 , 5
            syscall
            move $t0 , $v0
            move $t1 , $v0
            li $t3 , 0
            j while





exiting:  li $v0 , 10
          syscall



.data
string: .asciiz "Give an integer value : "  
multi:  .asciiz "*"
plus: .asciiz "+"
power: .asciiz "^"
endline: .asciiz "\n"