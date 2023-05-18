###################################################
###################################################
# #
# text segment #
# #
###################################################

## 4.2 exercise
.text
.globl main
main:


# start of main program
la $a0,prompt

li $v0,4
syscall # display "Enter integer number :"
 
li $v0,5
syscall # read integer
move $a0,$v0

jal proc

la $a0,endl
li $v0,4
syscall # display end of line


move $a0,$t0 



li $v0,10
syscall # exit
# end of main program


# start of procedure
proc:
    addi $sp, $sp, -8
    sw $a0 , 0($sp)
    sw $ra , 4($sp)
    beq $a0, $zero, end
    addi $a0 , $a0 ,-1
    jal proc

    end:

    li $v0,1
    lw $a0, 0($sp)
    syscall

    la $a0,endl
    li $v0,4
    syscall # display end of line
    
    addi $sp, $sp, 4
    lw $ra , 0($sp)
    addi $sp, $sp ,4
    jr $ra

# end of procedure

#################################################
# #
# data segment #
# #
#################################################
.data
endl: .asciiz "\n"
prompt: .asciiz "Enter integer number :" 

#################################################
# #
# End of File #
# #
#################################################
