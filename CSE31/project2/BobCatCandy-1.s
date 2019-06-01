.data
str0: .asciiz "\nWelcome to BobCat Candy, home to the famous BobCat Bars!\n"
strprice: .asciiz "Please enter the price of a BobCat Bar:\n"
strwrapper: .asciiz "Please enter the number of wrappers needed to exchange for a new bar:\n"
strnum: .asciiz "How, how much do you have?\n"
strrun: .asciiz "Good! Let me run the number ...\n"
strbuy: .asciiz "You first buy "
strnew: .asciiz "Then, you will get another "
strbars: .asciiz " bars.\n"
strfin1: .asciiz "With $"
strfin2: .asciiz ", you will receive a maximum of "
strfin3: .asciiz  " BobCat Bars!"


.text

main:

        li      $v0, 4
        la      $a0, str0
        syscall #print str0

        la      $a0, strprice
        syscall #print enter price
        li      $v0, 5
        syscall #get input:price
        add $t0, $v0, $0  # save input:price in $t0

        li      $v0, 4
        la      $a0, strwrapper
        syscall #print enter wrappers
        li $v0, 5
        syscall #get input:wrappers
        add $t1, $v0, $0  # save input:wrappers in $t1

        la      $v0, 4
        la      $a0, strnum
        syscall #print enter num
        li $v0, 5
        syscall #get input:num
        add $t2, $v0, $0  # save input:num in $t2

        li      $v0, 4
        la      $a0, strrun
        syscall #print strrun

        add $a0,$0,$t0  #price
        add $a1,$0,$t1  #wrapeprs
        add $a2,$0,$t2  #num

        addi $sp,$sp,-8
        sw $ra, 4($sp)
        sw $a2, 0($sp)
        jal maxBars     # Call maxBars to calculate the maximum number of BobCat Bars

        # Print out final statement here
        #"With $xx, you will receive a maximum xx of BobCat Bars!"
        add $t0,$v0,$0  #save sum

        li      $v0, 4
        la      $a0, strfin1
        syscall
        li      $v0, 1
        lw $a0, 0($sp)# restore num
        syscall #print num
        li      $v0, 4
        la      $a0, strfin2
        syscall
        li      $v0, 1
        add $a0,$t0,$0  #sum
        syscall #print max
        li      $v0, 4
        la      $a0, strfin3
        syscall

        j end

maxBars:
    # $a0 = price
    # $a1 = wrappers
    # $a2 = money
    # print (money/number)
    #return 
    addi    $sp, $sp, -4
        sw $ra 0($sp)
        addi $v0, $zero, 0
        
    blt  $a2, $a0, exit
    div $t0 , $a2, $a0
        li      $v0, 4
        la      $a0, strbuy
        syscall #print strbuy
        li      $v0, 1
        add $a0, $t0, $zero
        syscall #print num
        li      $v0, 4
        la      $a0, strbars
        syscall #print strbars

        add $a0, $t0, $zero
        addi $v0, $zero, 0
       	jal newBars     # Call a helper function to keep track of the number of bars.
        lw  $ra, 0($sp)
        addi    $sp, $sp, 4
        jr $ra

newBars:
        #int recur(int y, int x)
        #{
        #if (y <= 1){
        #      return 1;
        #}
        #printf("%d", y/x);
        #return recur(y/x, x)+y;
        #}
        # a0 = bars
        # a1 = wrappers
	
	addi    $sp, $sp, -4
        sw $ra 0($sp)    
	add $v0, $a0, $v0
        ble $a0, 1, exit
        blt $a0, $a1, exit
       	
       	div $a0, $a0, $a1
       	
       	
       	addi    $sp, $sp, -8
        sw $a0, 0($sp)    
	sw $v0, 4($sp)
       	li      $v0, 4
        la      $a0, strnew
        syscall #print strnew
        li      $v0, 1
        lw $a0, 0($sp)
        syscall #print num
        li      $v0, 4
        la      $a0, strbars
        syscall #print strbars
       	lw $a0, 0($sp)
        lw $v0, 4($sp)
        addi    $sp, $sp, 8
       	
       	
       	jal newBars
exit:
	lw $ra 0($sp)    
	addi $sp, $sp, 4
	jr $ra
end:
        # Terminating the program
        lw $ra, 4($sp)
        addi $sp, $sp 8
        li $v0, 10
        syscall
