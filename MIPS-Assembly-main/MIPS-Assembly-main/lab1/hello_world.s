.text
.globl __start

__start:            # execution starts here
    la $a0, message # load the message from memory

    li $v0, 4       # systeam call to print the message
    syscall

    li $v0, 10      # program termination
    syscall

.data
message: .asciiz "Hello World"
