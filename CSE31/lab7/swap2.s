.text
main:
    la  $a0,n1
    la  $a1,n2
    jal swap
    li  $v0,1   # print n1 and n2; should be 27 and 14
    lw  $a0,n1
    syscall
    li  $v0,11
    li  $a0,' '
    syscall
    li  $v0,1
    lw  $a0,n2
    syscall
    li  $v0,11
    li  $a0,'\n'
    syscall
    li  $v0,10  # exit
    syscall

swap:
	lw	$t1,0($sp)	#temp=t1
	lw	$t0,0($a0)	#t0= *px
	sw	$t0,0($t1)	#*px=*temp
	lw	$t0,0($a1)	#t0= *py
	sw	$t0,0($a0)	#*py=py
	lw	$t1,0($t1)	#t1=*temp
	sw	$t1,0($a1)	#*py=*temp
  	jr $ra	
    
    .data
n1: .word   14
n2: .word   27
