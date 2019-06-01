
    .text

main:
    li $a0, 0
    jal putDec
    li $a0, '\n'
    li $v0, 11
    syscall

    li $a0, 1
    jal putDec
    li $a0, '\n'
    li $v0, 11
    syscall

    li $a0, 196
    jal putDec
    li $a0, '\n'
    li $v0, 11
    syscall

    li $a0, -1
    jal putDec
    li $a0, '\n'
    li $v0, 11
    syscall

    li $a0, -452
    jal putDec
    li $a0, '\n'
    li $v0, 11
    syscall

    li $a0, 2
    jal mystery
    move $a0, $v0
    jal putDec
    li $a0, '\n'
    li $v0, 11
    syscall

    li $a0, 3
    jal mystery
    move $a0, $v0
    jal putDec
    li $a0, '\n'
    li $v0, 11
    syscall

    li $a0, 7
    jal mystery
    move $a0, $v0
    jal putDec
    li $a0, '\n'
    li $v0, 11
    syscall

    li $a0, 32
    jal mystery
    move $a0, $v0
    jal putDec
    li $a0, '\n'
    li $v0, 11
    syscall


    li  $v0, 10     # terminate program
    syscall

putDec:
    ## FILL IN ##
    bgt $a0, 0, loop
    beq $a0, $zero, zero
    add $t0, $a0, $zero
    li  $a0, '-'	
    li  $v0, 11
    syscall	#print negative sign
    mul $a0, $t0,-1
    j   loop
zero:
    add $t0, $a0, $zero
    li  $a0, '0'
    li  $v0, 11
    syscall	#print out
    add $a0, $t0, $zero
loop:
    beq $a0, $zero, return
    add $sp, $sp, -8
    sw  $ra, 0($sp)
    div $a0, $a0,  10	
    mfhi    $t0	#Hi=a0%10
    sw  $t0, 4($sp)

    jal loop
    lw  $ra, 0($sp)
    lw  $t0, 4($sp)
    add $sp, $sp, 8
    add $a0, $t0, '0'
           
    li  $v0, 11
    syscall
return:
    jr  $ra

mystery: #2^n-1-1
    li $t0, 2
    sub $a0, $a0, 1
    sllv $t0, $t0, $a0
    sub $t0, $t0, 1
    move $v0, $t0
    jr $ra
