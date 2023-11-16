# PRACTICE PROGRAM 6
# While (s2[i] = s1[i] != '/0') i++
.data
	s1: .asciiz "hi"
	    .align 2
	s2: .space 4
	dialog: .asciiz "Input: "
.text
.globl main
main:
	# prompts for input to save into s2
	li $v0, 54
	la $a0, dialog
	la $a1, s2
	li $a2, 4
	syscall
	
	la $a1, s1		# load s1 into a1
	la $a2, s2		# load s2 into a2
	jal sub1
	
	sll $0, $0, 0
	
exit:
	li $v0, 10
	syscall

sub1:
	li $t0, 0		# i
	loop:
		lb $t1, ($a1)			# load byte at address s1 into t1
		lb $t2, ($a2)			# load byte at address s2 into t2
		beq $t1, $t2, checknull	# if s2[i] = s1[i], check if they equal '/0'
		beq $t1, 0, return		# if s1[i] = null, exit
		beq $t2, 0, return		# if s2[i] = null, exit
		
		addi $a1, $a1, 1		# Go to next element of s1
		addi $a2, $a2, 1		# Go to next element of s2
		j loop
		
	
	checknull:
		beq $t1, 0, equalsnull		# if s2[i] = s1[i] = null, branch without i++
		addi $t0, $t0, 1		# else i++
		
		addi $a1, $a1, 1		# Go to next element of s1
		addi $a2, $a2, 1		# Go to next element of s2
		j loop
		
	equalsnull:
		j return
		
	return:
		jr $ra