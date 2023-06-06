.text
.globl main

main:       li $v0, 6
            syscall

            mov.s $f12, $f0
            li $v0, 2
            syscall

exit:       li $v0, 10
            syscall

.data

endl: .asciiz "\n"