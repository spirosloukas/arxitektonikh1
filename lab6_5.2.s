###################################################
###################################################
# #
# text segment #
# #
###################################################

## 5.2 exercise

.text
.globl main
main:
    l.s $f0, x             #load data
    l.s $f1, y
    l.s $f2, pInf
    l.s $f3, nInf
    l.s $f4, NaN
    l.s $f5, zero_zero

    mul.s $f12, $f0, $f1    # x * y
    jal print_float
    jal print_newl

    mul.s $f12, $f0, $f3    # x * -inf
    jal print_float
    jal print_newl

    div.s $f12, $f1, $f5    # y / 0
    jal print_float
    jal print_newl

    div.s $f12, $f5, $f5    # 0 / 0
    jal print_float
    jal print_newl

    mul.s $f12, $f5, $f2    # 0 * +inf
    jal print_float
    jal print_newl

    div.s $f12, $f2, $f3    # +inf / -inf
    jal print_float
    jal print_newl

    add.s $f12, $f2, $f3    # +inf + (-inf)
    jal print_float
    jal print_newl

    add.s $f12, $f0, $f4    # x + NaN
    jal print_float
    jal print_newl

    j exit

print_newl:         # print new line character
    la $a0, endl
    li $v0, 4
    syscall 
    j $ra

print_float:        # print float in $f12
    li $v0, 2
    syscall
    j $ra

exit:               # exit program
    li $v0, 10
    syscall

#################################################
# #
# data segment #
# #
#################################################
.data
zero_zero: .float 0.0
pInf: .word 0x7f800000
nInf: .word 0xff800000
NaN: .word 0x7f800001
x: .float 1.5
y: .float -0.75
endl: .asciiz "\n"

#################################################
# #
# End of File #
# #
#################################################
