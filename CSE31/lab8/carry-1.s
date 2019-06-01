.data
    n1: .word 0x7fffffff
    n2: .word 0x80000000
    #n1: .word 0xffffffff
    #n2: .word 1
    #n2: .word 0
.text
main:
    lw $t3, n1
    lw $t4, n2
    addu $t2, $t3, $t4
    sltu $t2, $t2, $t3 #0 or 1

    li $v0, 1
    add $a0, $t2, $zero
    syscall #print
    li  $v0,10
    syscall #end
