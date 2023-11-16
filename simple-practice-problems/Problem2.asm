# PRACTICE PROGRAM 2
# if (a > 0) a = -a
.data
	a: .word 4
.text
.globl main
main:
	lw $t0, a		# Load a into $s0
	slt $t1, $zero, $t0	# if 0 is less than t0, set t1 to 1, else set it to 0
	beq $t1, 0, exit	# if t1 is 0, then t0 is less than 0, so exit
	
	mul $t0, $t0, -1	# Multiply by negative 1 to change sign
	sw $t0, a		# save value to a
exit:
	li $v0, 10
	syscall