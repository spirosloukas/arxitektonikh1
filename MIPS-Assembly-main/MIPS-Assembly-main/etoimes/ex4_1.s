.text
.globl main

main:

# Initialize variables
init_var:   li $a0, -10
            li $a1, -30
            li $a2, 120
            li $a3, 200

            li $s0, 39
            li $s1, 10

            jal find_max_and_min

            move $t0, $v0
            move $t1, $v1

displ_max:  la $a0, max
            li $v0, 4
            syscall              # Display "Max is : "
            move $a0, $t0
            li $v0, 1
            syscall              # Dispay max

            li $v0, 4            # Loads the string printing code (4) in $v0
            la $a0, endl         # $a0 points to endl
            syscall              # Print a newline ('\n') character

displ_min:  la $a0, min
            li $v0, 4
            syscall              # Display "Min is : "
            move $a0, $t1
            li $v0, 1
            syscall              # Dispay min

            li $v0, 4            # Loads the string printing code (4) in $v0
            la $a0, endl         # $a0 points to endl
            syscall              # Print a newline ('\n') character

exit:       li $v0, 10           # Loads the "exit" instruction into $v0
            syscall              # System call to terminate the program


# Finds the maximum and the minimum integers in a set of 4 integers
find_max_and_min:
            addi $sp, $sp, -8    # Adjust stack for 2 items
            sw $s0, 0($sp)
            sw $s1, 4($sp)

hold_min:   move $s0, $a0        # $s0 holds the min value and is initialized to $a0

cont4:      ble  $s0, $a1, cont5 # if (min < $a1) continue (goto cont5)
            move $s0, $a1        # else update the min value, so that min = $a1

cont5:      ble  $s0, $a2, cont6 # if (min < $a2) continue (goto cont6)
            move $s0, $a2        # else update the min value, so that min = $a2

cont6:      ble  $s0, $a3, svmin # if (min < $a3) continue (goto svmin)
            move $s0, $a3        # else update the min value, so that min = $a3

svmin:      move $v0, $s0        # Finally, save the min value in the register $v0

hold_max:   move $s1, $a0        # $s1 holds the max value and is initialized to $a0

            bge  $s1, $a1, cont2 # if (max > $a1) continue (goto cont2)
            move $s1, $a1        # else update the max value, so that max = $a1

cont2:      bge  $s1, $a2, cont3 # if (max > $a2) continue (goto cont3)
            move $s1, $a2        # else update the max value, so that max = $a2

cont3:      bge  $s1, $a3, svmax # if (max > $a3) continue (goto svmax)
            move $s1, $a3        # else update the max value, so that max = $a3

svmax:      move $v1, $s1        # Finally, save the max value in the register $v1

rstore_rgs: lw $s0, 0($sp)       # Restore saved registers from stack
            lw $s1, 4($sp)
            addi $sp, $sp, 8
  
end_proced: jr $ra               # End of procedure

.data
# Data goes here

max:  .asciiz "Max is : "
min:  .asciiz "Min is : "
endl: .asciiz "\n"