.text
.globl main
main:
        
        li $v0 , 6
        syscall
        mov.s $f10 , $f0
        l.s $f5 , zero
        jal while
        
while:  c.eq.s $f10 , $f5
        bc1t exit
        mov.s $f3 , $f0
        cvt.w.s $f1 , $f0     #Conversion to integer
        mfc1 $t1 , $f1
        mtc1 $t1 , $f2
        cvt.s.w $f4 , $f2       #Conversion to float
        c.eq.s $f4 , $f0        # If $f4==$f0 , then the integer has been found.
        bc1t process
        bc1f process1 


process:    la $a0 , string
            li $v0 , 4
            syscall
            move $a0 , $t1
            li $v0 , 1
            syscall
            la $a0 , endline
            li $v0 , 4
            syscall
            li $v0 , 6
            syscall 
            mov.s $f10 , $f0
            j while 


process1:       la $a0 , string1
                li $v0 , 4
                syscall
                la $a0 , endline
                li $v0 , 4
                syscall
                li $v0 , 6
                syscall 
                mov.s $f10 , $f0 
                j while



exit:   la $a0 , exit1
        li $v0 , 4
        syscall
        la $a0 ,endline
        li $v0 , 4
        syscall
        li $v0 , 10
        syscall


.data
string:     .asciiz "FOUND-INTEGER = "
string1: .asciiz "NOT-INTEGER"
endline: .asciiz "\n"
zero:    .float 0.0
exit1:      .asciiz "Invalid Input . Exiting..."