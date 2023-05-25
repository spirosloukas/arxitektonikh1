###################################################
###################################################
# #
# text segment #
# #
###################################################

## 5.1 exercise
.text
.globl main
main:

    la $a0, prompt
    li $v0, 4
    syscall

    li $v0, 6
    syscall

    la $a0, endprompt
    li $v0, 4
    syscall

    mov.s $f12, $f0         #move float to $f12

    li $v0, 2
    syscall

    li $v0, 10
    syscall

#################################################
# #
# data segment #
# #
#################################################
.data
prompt: .asciiz "Give a float: \n"
endprompt: .asciiz "Your float is: "

#################################################
# #
# End of File #
# #
#################################################

