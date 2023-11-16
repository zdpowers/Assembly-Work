# PRACTICE PROGRAM 3
# if (a <= b) c = b else c = a
.data
	a: .word 5
	b: .word 6
	c: .word 0
.text
.globl main
main:
	lw $t0, a
	lw $t1, b
	
	sle $t3, $t0, $t1	# if a is less than or equal to b, set t3 to 1, else 0
	beq $t3, 1, CequalsB	# is a is less than or equal to b
	beq $t3, 0, CequalsA	# if a is not less than or equal to b
	
	CequalsB:
		sw $t1, c	# store the vale of b to c
		j exit		# Exit
	
	CequalsA:
		sw $t0, c	# store value of a to c
		j exit		# Exit

exit:
	li $v0, 10
	syscall