# PRACTICE PROGRAM 1
# if (a < 0) a = -a
.data
	a: .word 4
.text
.globl main
main:
	lw $t0, a		# Load a into $s0
	slti $t1, $t0, 0	# if t2 is less than 0, st t1 to 1, else, zero
	beq $t1, 0, exit	# if t1 is 0, then a is not less than 0, so sign is not changed
	
	mul $t0, $t0, -1	# Multiply by negative 1 to change sign
	sw $t0, a		# save value to a	
exit:
	li $v0, 10
	syscall
