	.data
	# This shows you can use a .word and directly encode the value in hex
	# if you so choose
num1:	.float 1.0
num2:	.word 0x4a000000
num3: 	.word 0x4a000000
result:	.word 0
string: .asciiz "\n"

	.text
main:
	la $t0, num1
	lwc1 $f2, 0($t0)
	lwc1 $f4, 4($t0)
	lwc1 $f6, 8($t0)

	# Print out the values of the summands

	li $v0, 2
	mov.s $f12, $f2 #first value
	syscall

	li $v0, 4
	la $a0, string #new line
	syscall

	li $v0, 2
	mov.s $f12, $f4 #next value
	syscall

	li $v0, 4
	la $a0, string #new line
	syscall

	li $v0, 2
	mov.s $f12, $f6 #last value
	syscall

	li $v0, 4
	la $a0, string
	syscall
	li $v0, 4
	la $a0, string
	syscall

	# Do the actual addition

	add.s $f12, $f2, $f4
	add.s $f12, $f12, $f6

	li $v0, 2	#now lets print the first sum
	syscall
	li $v0, 4
	la $a0, string  #prints a new line
	syscall

	#add another way
	add.s $f12, $f2, $f6
	add.s $f12, $f12, $f4

	
	# At this point, $f12 holds the sum, and $s0 holds the sum which can
	# be read in hexadecimal

	li $v0, 2
	syscall
	li $v0, 4
	la $a0, string
	syscall

	# This jr crashes MARS
	# jr $ra
