.text
.globl __start
__start:
    # start of main program

    li $a0,-10    # Initialize variables
    li $a1,-30    #
    li $a2,120    #
    li $a3,200    #

    move $t0,$v0  # t0 = v0
    move $t1,$v1  # t1 = v1

    jal FindMax
    move $t0, $v0 # copy the max number (stored in $v0) to $t0

    la $a0,max
    li $v0,4
    syscall       # display "Max is :"

    move $a0,$t0  # copy the max number (stored in $t0) to $a0, to be able to print it

    li $v0,1
    syscall       # display max

    la $a0,endl
    li $v0,4
    syscall       # display end of line

    jal FindMin
    move $t1, $v0 # copy the min number (stored in $v0) to $t0

    la $a0,min
    li $v0,4
    syscall       # display "Min is :"

    move $a0,$t1  # copy the min number (stored in $t0) to $a0, to be able to print it

    li $v0,1
    syscall       # display min

    la $a0,endl
    li $v0,4
    syscall       # display end of line

    li $v0,10
    syscall       # exit

    # end of main program

# start of procedure
FindMax:
    # PLAN:
    # s0 = the maximum number

    addi $sp, $sp, -16  # Allocate space in the stack for 4 integers

    # BACK-UP THE REGISTERS
    sw $a0, 0($sp)
    sw $a1, 4($sp)
    sw $a2, 8($sp)
    sw $a3, 12($sp)

                                  # Starting off, let's say that a0 is currently the maximum value
InitMax:     move $s0, $a0           # $s0 = $a0

Compare1: bgt $s0, $a1, Compare2  # if $s0 > $a1, go to Compare2
          move $s0, $a1           # Else, move $a1 to $s0

Compare2: bgt $s0, $a2, Compare3  # if $s0 > $a2, go to Compare3
          move $s0, $a2           # Else, move $a2 to $s1

Compare3: bgt $s0, $a3, SaveMax      # if $s0 > $a3, go to Save
          move $s0, $a3           # Else, move $a3 to $s0

                                  # To return the maximum value back to the caller function, we must copy it to $v0
SaveMax:     move $v0, $s0           # $v0 = $s0

    # RESET THE BACKED-UP REGISTERS
    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $a2, 8($sp)
    lw $a3, 12($sp)

    addi $sp, $sp, 16           # Dislocate space in the stack for 4 integers

    jr $ra                      # jump back to the caller function
# end of procedure

# start of procedure
FindMin:
    # PLAN:
    # s0 = the minimum number

    addi $sp, $sp, -16  # Allocate space in the stack for 4 integers

    # BACK-UP THE REGISTERS
    sw $a0, 0($sp)
    sw $a1, 4($sp)
    sw $a2, 8($sp)
    sw $a3, 12($sp)

                                  # Starting off, let's say that a0 is currently the minimum value
InitMin:     move $s0, $a0           # $s0 = $a0

Compare4: blt $s0, $a1, Compare5  # if $s0 < $a1, go to Compare2
          move $s0, $a1           # Else, move $a1 to $s0

Compare5: blt $s0, $a2, Compare6  # if $s0 < $a2, go to Compare3
          move $s0, $a2           # Else, move $a2 to $s1

Compare6: blt $s0, $a3, SaveMin      # if $s0 < $a3, go to Save
          move $s0, $a3           # Else, move $a3 to $s0

                                  # To return the maximum value back to the caller function, we must copy it to $v0
SaveMin:     move $v0, $s0           # $v0 = $s0

    # RESET THE BACKED-UP REGISTERS
    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $a2, 8($sp)
    lw $a3, 12($sp)

    addi $sp, $sp, 16           # Dislocate space in the stack for 4 integers

    jr $ra                      # jump back to the caller function
# end of procedure

.data
max:  .asciiz "Max is : "
min:  .asciiz "Min is : "
endl: .asciiz "\n"
