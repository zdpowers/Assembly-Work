# PRACTICE PROGRAM 4
# for (i=0; i<10; i++)  C+=5;  Note: use immediate load/add instructions
.data
	c: .word 0
.text
.globl main
main:
	li $t0, 0	# t0 = i
	lw $s0, c	# s0 = c
	forLoop:
		beq $t0, 10, exit	# If i=10, exit
		addi $s0, $s0, 5	# c+=5
		addi $t0, $t0, 1	# i++
		j forLoop
exit:
	sw $s0, c			# save the new value of c
	li $v0, 10			# Exit program
	syscall