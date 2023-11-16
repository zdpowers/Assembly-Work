# PRACTICE PROGRAM 4
# for (i=0; i<10; i++) a[i] += 5
.data
	a: .word 5, 9, 2, 1, 4, 6, 3, 9, 2, 1
	len: .word 10
.text
.globl main
main:
	li $t0, 0	# t0 = i
	lw $t1, len	# t1 = len = 10
	forLoop:
		beq $t0, $t1, exit	# If i=10, exit
		mul $t2, $t0, 4		# multiply i by 4 to get each word
		lw $t3, a($t2)		# load the value in array a at position i*4
		addi $t3, $t3, 5	# a[i] += 5
		sw $t3, a($t2)		# save modified value
		addi $t0, $t0, 1	# i++
		j forLoop

exit:
	li $v0, 10
	syscall