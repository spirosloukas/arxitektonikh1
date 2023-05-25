.text
    .globl __start

__start:
    la $a0, prompt
    li $v0, 4
    syscall

    li $v0, 6
    syscall

    la $a0, endprompt
    li $v0, 4
    syscall

    mov.s $f12, $f0
    li $v0, 2
    syscall

    li $v0, 10
    syscall

.data
    prompt: .asciiz "Give a float: "
    endprompt: .asciiz "\nYour float is: "
