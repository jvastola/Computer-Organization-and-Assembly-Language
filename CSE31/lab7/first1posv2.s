main:   add $t5, $t0, $t0
    lui $a0,0x8000
    jal first1pos
    jal printv0
    lui $a0,0x0001
    jal first1pos
    jal printv0
    li  $a0,1
    jal first1pos
    jal printv0
    add $a0,$0,$0
    jal first1pos
    jal printv0
    li  $v0,10
    syscall

first1pos:
    beq    $a0, $0, minus
    addi    $s1, $0, 31
    addi    $t2,$0, 0x80000000  #mask
    addi    $sp, $sp, -4
    sw  $ra, 0($sp)
    jal     loop
    lw  $ra, 0($sp)
    addi    $sp, $sp, 4
    jr  $ra

loop:
    and $t1, $a0, $t2 #check before shift 0 or 1
    bne $t1, $0, end
    addi    $s1, $s1, -1
    srl $t2, $t2, 1
    j   loop

minus:
    addi    $v0, $0, -1
    jr  $ra

end:
    addi    $v0, $s1, 0
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
