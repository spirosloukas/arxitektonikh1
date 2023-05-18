###################################################
###################################################
# #
# text segment #
# #
###################################################

## 4.1 exercise
.text
.globl main
main:

# start of main program
li $a0,-10 # Initialize variables
li $a1,-30 #
li $a2,120 #
li $a3,200 #

jal MinMax

move $t0,$v0
move $t1,$v1
la $a0,max
li $v0,4
syscall # display "Max is :"
move $a0,$t0
li $v0,1
syscall # display max
la $a0,endl
li $v0,4
syscall # display end of line
la $a0,min
li $v0,4
syscall # display "Min is :"
move $a0,$t1
li $v0,1
syscall # display min
la $a0,endl
li $v0,4
syscall # display end of line
li $v0,10
syscall # exit

# end of main program


# start of procedure
MinMax:
addi $sp, $sp,-8
sw $s0, 0($sp)
sw $s1, 4($sp)

blt $a0 , $a1 ,a0h
move $s0, $a1
move $s1, $a0
j con
a0h: 
    move $s0, $a0
    move $s1, $a1
con:
    blt $a2, $s0 ,mva2 
    check1 : blt $a3, $s0 ,mva3
    bgt $a2, $s1 ,mvag2
    check2 : bgt $a3, $s1 ,mvag3
    j end

mva2:
    move $s0, $a2
    j check1
mva3:
    move $s0, $a3
    j end
mvag2:
    move $s1, $a2
    j check2
mvag3:
    move $s1, $a3
    j end
end:

move $v0, $s1
move $v1, $s0

lw $s0, 0($sp)
lw $s1, 4($sp)
addi $sp, $sp, 8
jr $ra
#
# end of procedure

li $v0,10
syscall # au revoir...
#################################################
# #
# data segment #
# #
#################################################
.data
endl: .asciiz "\n"
max: .asciiz "max is : "
min: .asciiz "min is : "

#################################################
# #
# End of File #
# #
#################################################
