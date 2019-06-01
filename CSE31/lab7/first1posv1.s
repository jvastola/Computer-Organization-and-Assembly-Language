main:   add $t5, $t0, $t0
    lui $a0,0x8000 #should be 31
    jal first1pos
    jal printv0
    lui $a0,0x0001  #should be 16
    jal first1pos
    jal printv0
    li  $a0,1   #should be 0
    jal first1pos
    jal printv0
    add $a0,$0,$0   #should be -1
    jal first1pos
    jal printv0
    li  $v0,10
    syscall

first1pos:  # your code goes here
    beq    $a0, $0, minus
    addi    $s1, $0, 31 #counter
    addi    $sp, $sp, -4
    sw  $ra, 0($sp)
    jal     loop
    lw  $ra, 0($sp)
    addi    $sp, $sp, 4
    jr  $ra

loop:
    slt $t1, $a0, $0
    bne $t1, $0, end
    addi    $s1, $s1, -1
    sll $a0, $a0, 1
    j   loop
end:
    addi    $v0, $s1, 0
    jr  $ra

minus:
    addi    $v0, $0, -1
    jr  $ra

printv0:
    addi    $sp,$sp,-4
    sw  $ra,0($sp)
    add $a0,$v0,$0
    li  $v0,1
    syscall
    li  $v0,11
    li  $a0,'\n'
    syscall
    lw  $ra,0($sp)
    addi    $sp,$sp,4
    jr  $ra
