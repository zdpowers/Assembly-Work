# EXIT THE PROGRAM
.macro exitprogram
	li $v0, 10			
	syscall
.end_macro 
# NICE EASY WAY TO PRINT NEW LINE
.macro newline
	li $a0, 10
	li $v0, 11
	syscall		#New line
.end_macro
# PRINTS STRING THAT YOU TYPE
.macro print_raw_string (%str)
	.data
		myStr: .asciiz %str
	.text
		li $v0, 4
		la $a0, myStr
		syscall
.end_macro
# DIALOG PROMPT FOR STRING INPUT
.macro stringinput (%prompt, %strlabel, %numchars)
	li $v0, 54		# InputDialogString
	la $a0, %prompt		# message to user
	la $a1, %strlabel	# address of input buffer
	li $a2, %numchars	# maximum number of characters to read
	syscall
.end_macro
# PRINT STRING FROM LABEL
.macro printstring (%strlabel)
	li $v0, 4
	la $a0, %strlabel
	syscall
.end_macro
# PRINT STRING FROM REGISTER
.macro printstr(%str)
	li $v0, 4
	move $a0, %str
	syscall 
.end_macro 
# PRINT INTEGER FROM REGISTER
.macro printint (%int)
	li $v0, 1
	move $a0, %int
	syscall
.end_macro
# GET LENGTH OF STRING
.macro getlen (%strlabel)
	li $t0, 0 		# initialize loop counter
	la $t1, %strlabel	# load string into t1
	
	loop:
		lb $t2, ($t1) # # load the content of the address stored in $t1
		beq $t2, $zero, finish # exit if $t1 == null
		
		addi $t0, $t0, 1 #increment loop counter
		addi $t1, $t1, 1 # go to next byte
		
		j loop
	finish:
		beq $t0, $zero, output
		subi $t0, $t0, 1
	output:
		printint($t0)
		newline	
.end_macro
# CHECK IF STRINGS ARE THE SAME (CASE SENSITIVE)
.macro checkstr (%str1, %str2)
	.data
	stringsEqual: .asciiz "Strings are the same."
	stringsUnequal: .asciiz "Strings not the same."

	.text
	li $t0, 0 		# initialize loop counter
	la $t1, %str1		# load string1 into t1
	la $t2, %str2		# load string2 into t2
	
	loop:
		lb $t3, ($t1)  # load the content of the address stored in $t1 (str1)
		lb $t4, ($t2)	# load the content of the address stored in $t2 (str2)
		bne $t3, $t4, notequal # exit if $t1 != $t2
		add $t5, $t3, $t4	# checking if both strings are at the end
		beqz $t5, equal		# add more branches for if == 10 or 20, for if one or both terminate with new line char
		
		addi $t1, $t1, 1 # go to next byte of str1
		addi $t2, $t2, 1 # go to next byte of str2

		j loop
	equal:
		printstring(stringsEqual)
		j done
	notequal:
		printstring(stringsUnequal)
		j done
	done:
		newline
.end_macro
# Add Null Terminator
.macro nullterminate(%str1, %str2)
	la $t0, 0 		# initialize loop counter
	la $t1, %str1		# load string1 into t1
	
	strloop:
		lb $t3, ($t1)  		# load the content of the address stored in $t1 (str1)
		beq $t3, 10, nullloop 	# if == newline, start loop to add null
		beqz $t3, nullloop	# if == null or 0, start loop to add null
		sb $t3, %str2($t0)		# store character byte
		
		addi $t1, $t1, 1 	# go to next byte of str1
		addi $t0, $t0, 1 	# go to next byte of str2
	nullloop:
		sb $zero, %str2($t0)	# Add 0 to end of str
		
	
.end_macro 
# CONCATENATE STRINGS
.macro concat (%str1, %str2, %str3)

	la $t0, 0 		# initialize loop counter
	la $t1, %str1		# load string1 into t1
	la $t2, %str2		# load string2 into t2
	#la $t8, %str3		# string that is returned
	
	str1loop:
		lb $t3, ($t1)  		# load the content of the address stored in $t1 (str1)
		beq $t3, 10, str2loop 	# if == newline, start loop on second string
		beqz $t3, str2loop	# if == null or 0, start loop on second string
		sb $t3, %str3($t0)		# store character byte
		
		addi $t1, $t1, 1 	# go to next byte of str1
		addi $t0, $t0, 1 	# go to next byte of str
		print_raw_string("loop1")
		newline
		j str1loop

	str2loop:
		lb $t3, ($t2)  		# load the content of the address stored in $t1 (str1)
		beq $t3, 10, endconcat 	# if == newline, start loop on second string
		beqz $t3, endconcat		# if == null or 0, start loop on second string
		sb $t3, %str3($t0)		# store character byte
		
		addi $t2, $t2, 1 	# go to next byte of str1
		addi $t0, $t0, 1 	# go to next byte of str
		print_raw_string("loop2")
		newline
		j str2loop
	endconcat:
		print_raw_string("END")
		newline
		printstring(%str3)
				
.end_macro
# OPEN FILE (action 0 to read, 1 to write)
.macro openfile (%fn, %action)		# MODIFY TO BE READ OF WRTIE (HAVE THE USER INPUT 1 OR 0 FOR FLAG)
	li $v0, 13		# syscall for open file
	la $a0, %fn		# input file name
	li $a1, %action		# read = 0, write = 1
	li $a2, 0
	syscall 		# open the file
	move $s0, $v0		# save the file descriptor to $s0
	#move $s1, $a0		# save the file name to $s1
	
	#printstring(opened)
	#printstring(%fn)
	#newline
.end_macro
# CLOSE FILE
.macro closefile 
	li $v0, 16
	move $a0, $s0
	syscall
	#printstring(closed)
	#printstr($s1)		# File name was previously saved to s1
.end_macro
# READ FROM FILE
.macro readfile (%buffer, %numchars)
	li $v0, 14		# syscall for read file
	move $a0, $s0		# file descriptor
	la $a1, %buffer		# Input Buffer
	li $a2, %numchars	# Max characters to be read
	syscall
.end_macro
# CONVERTS CHAR REPRESENTATION OF NUMBER INTO INT FROM LABEL VALUE
.macro chartoint (%char)
	la $s1, %char
	li $t0, 10
	li $s2, 0
	
	lp:
		lbu $t1, ($s1)	#load unsigned char from array into t1
		beq $t1, $zero, FIN	# NULL terminator found
		blt $t1, 48, error   #check if char is not a digit (ascii<'0')	
		bgt $t1, 57, error   #check if char is not a digit (ascii>'9')
		addi $t1, $t1, -48   #converts t1's ascii value to dec value
		mul $s2, $s2, $t0    #sum *= 10
  		add $s2, $s2, $t1    #sum += array[s1]-'0'
  		addi $s1, $s1, 1     #increment array address
  		j lp                 #jump to start of loop
  		
	error:          #if non digit chars are entered, readInt returns 0
		add $s2, $zero, $zero
		j FIN
	FIN:
		li $v0, 1
		add $a0, $s2, $zero
		syscall
.end_macro
# CONVERTS CHAR TO INT FROM REGISTER VALUE
.macro intfromchar (%char)
	move $s1, %char
	li $t0, 10
	li $s2, 0
	
	lp:
		lbu $t1, ($s1)	#load unsigned char from array into t1
		beq $t1, $zero, FIN	# NULL terminator found
		blt $t1, 48, error   #check if char is not a digit (ascii<'0')	
		bgt $t1, 57, error   #check if char is not a digit (ascii>'9')
		addi $t1, $t1, -48   #converts t1's ascii value to dec value
		mul $s2, $s2, $t0    #sum *= 10
  		add $s2, $s2, $t1    #sum += array[s1]-'0'
  		addi $s1, $s1, 1     #increment array address
  		j lp                 #jump to start of loop
  		
	error:          #if non digit chars are entered, readInt returns 0
		add $s2, $zero, $zero
		j FIN
	FIN:
		li $v0, 1
		add $a0, $s2, $zero
		syscall
.end_macro

# Used to append value onto new line of a file, copies value, adds newline, then copies content of file
.macro append (%str1, %str2, %str3)

	la $t0, 0 		# initialize loop counter
	la $t1, %str1		# load string1 into t1
	la $t2, %str2		# load string2 into t2
	li $t9, 10		# new line
	#la $t8, %str3		# string that is returned
	
	str1loop:
		lb $t3, ($t1)  		# load the content of the address stored in $t1 (str1)
		beq $t3, 10, addnewline 	# if == newline, start loop on second string
		beqz $t3, addnewline	# if == null or 0, start loop on second string
		sb $t3, %str3($t0)		# store character byte
		
		addi $t1, $t1, 1 	# go to next byte of str1
		addi $t0, $t0, 1 	# go to next byte of str
		print_raw_string("loop1")
		newline
		j str1loop
	
	addnewline:
		sb $t9, %str3($t0)	# Add newline before compying rest of string
		addi $t0, $t0, 1 	# go to next byte of str
		j str2loop
		
	str2loop:
		lb $t3, ($t2)  		# load the content of the address stored in $t1 (str1)
		#beq $t3, 10, endconcat 	# if == newline, start loop on second string
		beqz $t3, endconcat		# if == null or 0, start loop on second string
		sb $t3, %str3($t0)		# store character byte
		
		addi $t2, $t2, 1 	# go to next byte of str1
		addi $t0, $t0, 1 	# go to next byte of str
		print_raw_string("loop2")
		newline
		j str2loop
	endconcat:
		print_raw_string("END")
		newline
		printstring(%str3)
				
.end_macro
