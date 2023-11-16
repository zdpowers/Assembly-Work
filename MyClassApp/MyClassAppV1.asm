.include "C:\\Users\\zvckp\\Desktop\\MyClassApp\\macrosV2.asm"

.macro noinputwarning
	.data
		noInputMessage: .asciiz "No input was provided. Please enter the necessary information."
	.text
		# NO INPUT MESSAGE
		li $v0, 55			# MessageDialog
		la $a0, noInputMessage		# address of null-terminated string that is the message to user
		li $a1, 2			# Type of message: 0 = error, 1 = information, 2 = warning, 3 = question
		syscall
.end_macro

.macro badinputwarning
	.data
		invalidInputMessage: .asciiz "Invalid data type was inputted. Please enter a valid value."
	.text
		# INVALID INPUT MESSAGE
		li $v0, 55			# MessageDialog
		la $a0, invalidInputMessage	# address of null-terminated string that is the message to user
		li $a1, 0			# Type of message: 0 = error, 1 = information, 2 = warning, 3 = question
		syscall	
.end_macro
# USED AS VERSATILE PLACEHOLDER DURING DEVELOPMENT
.macro placeholderdialog (%message)
	li $v0, 55			# MessageDialog
	la $a0, %message		# address of null-terminated string that is the message to user
	li $a1, 1			# Type of message: 0 = error, 1 = information, 2 = warning, 3 = question
	syscall	
.end_macro 

.macro clearfullnamebuffer
	la $t0, clearNameBuffer
	la $t1, fullName
	li $t2, 50
	
	fifty:
		lb $t3, ($t0)		# load clearbuffer byte
		sb $t3, ($t1)		# Store it in fullname buffer
		addi $t0, $t0, 1	# go to next clearbuffer byte
		addi $t1, $t1, 1	# go to next fullname buffer byte
		subi $t2, $t2, 1	# decrease the loop counter
		beqz $t2, done		# Exit loop after 50 
		j fifty
	done:
		print_raw_string("Name Cleared")
	
.end_macro

.macro clearfilenamebuffer
	la $t0, clearFileName
	la $t1, fileName
	li $t2, 100
	
	hundred:
		lb $t3, ($t0)		# load clearbuffer byte
		sb $t3, ($t1)		# Store it in fullname buffer
		addi $t0, $t0, 1	# go to next clearbuffer byte
		addi $t1, $t1, 1	# go to next fullname buffer byte
		subi $t2, $t2, 1	# decrease the loop counter
		beqz $t2, done		# Exit loop after 50 
		j hundred
	done:
		print_raw_string("File Name Cleared")
	
.end_macro

.macro clearfilepathbuffer
	la $t0, clearFilePath
	la $t1, filePath
	li $t2, 500
	
	hundred:
		lb $t3, ($t0)		# load clearbuffer byte
		sb $t3, ($t1)		# Store it in fullname buffer
		addi $t0, $t0, 1	# go to next clearbuffer byte
		addi $t1, $t1, 1	# go to next fullname buffer byte
		subi $t2, $t2, 1	# decrease the loop counter
		beqz $t2, done		# Exit loop after 50 
		j hundred
	done:
		print_raw_string("File Path Cleared")
.end_macro

.macro clearclasslistbuffer
	la $t0, clearClassList
	la $t1, classListBuffer
	li $t2, 1024
	
	thousand:
		lb $t3, ($t0)		# load clearbuffer byte
		sb $t3, ($t1)		# Store it in fullname buffer
		addi $t0, $t0, 1	# go to next clearbuffer byte
		addi $t1, $t1, 1	# go to next fullname buffer byte
		subi $t2, $t2, 1	# decrease the loop counter
		beqz $t2, done		# Exit loop after 50 
		j thousand
	done:
		print_raw_string("File Path Cleared")
.end_macro

.macro cleargradelistbuffer
	la $t0, clearGradeList
	la $t1, gradeList
	li $t2, 1024
	
	thousand:
		lb $t3, ($t0)		# load clearbuffer byte
		sb $t3, ($t1)		# Store it in fullname buffer
		addi $t0, $t0, 1	# go to next clearbuffer byte
		addi $t1, $t1, 1	# go to next fullname buffer byte
		subi $t2, $t2, 1	# decrease the loop counter
		beqz $t2, done		# Exit loop after 50 
		j thousand
	done:
		print_raw_string("File Path Cleared")
.end_macro

.macro clearappendedgradelistbuffer
	la $t0, clearAppendedGradeList
	la $t1, appendedGradeList
	li $t2, 1024
	
	thousand:
		lb $t3, ($t0)		# load clearbuffer byte
		sb $t3, ($t1)		# Store it in fullname buffer
		addi $t0, $t0, 1	# go to next clearbuffer byte
		addi $t1, $t1, 1	# go to next fullname buffer byte
		subi $t2, $t2, 1	# decrease the loop counter
		beqz $t2, done		# Exit loop after 50 
		j thousand
	done:
		print_raw_string("Appended Grade List Cleared")
.end_macro

.macro clearappendedclasslistbuffer
	la $t0, clearAppendedClassList
	la $t1, appendedClassList
	li $t2, 1024
	
	thousand:
		lb $t3, ($t0)		# load clearbuffer byte
		sb $t3, ($t1)		# Store it in fullname buffer
		addi $t0, $t0, 1	# go to next clearbuffer byte
		addi $t1, $t1, 1	# go to next fullname buffer byte
		subi $t2, $t2, 1	# decrease the loop counter
		beqz $t2, done		# Exit loop after 50 
		j thousand
	done:
		print_raw_string("Appended Class List Cleared")
.end_macro

.macro clearnewgradebuffer
	la $t0, clearNewGrade
	la $t1, newGrade
	li $t2, 10
	
	ten:
		lb $t3, ($t0)		# load clearbuffer byte
		sb $t3, ($t1)		# Store it in fullname buffer
		addi $t0, $t0, 1	# go to next clearbuffer byte
		addi $t1, $t1, 1	# go to next fullname buffer byte
		subi $t2, $t2, 1	# decrease the loop counter
		beqz $t2, done		# Exit loop after 50 
		j ten
	done:
		print_raw_string("New Grade Cleared")
.end_macro
# USED TO CREATE A NEW BLANK FILE
.macro makefile (%filepath)
	.data
		blankText: .asciiz ""
	.text
		li $v0, 13
		la $a0, %filepath
		li $a1, 1
		li $a2, 0
		syscall
		move $s6, $v0
	
		li $v0, 15
		move $a0, $s6
		la $a1, blankText
		li $a2, 0
		syscall
	
		li   $v0, 16       # system call for close file
		move $a0, $s6      # file descriptor to close
		syscall            # close file	
.end_macro


.data
	# 'classListFile' IS THE FILE PATH TO THE TEXT FILE CONTAINING A LIST OF THE STUDENTS
	classListFile: .asciiz "C:\\Users\\zvckp\\Desktop\\MyClassApp\\CS502\\STUDENTS.txt"
	# 'path' IS THE FILE PATH TO THE FOLDER CONTAINING 'classListFile' AS WELL AS ALL OF THE STUDENT FILES
	path: .asciiz "C:\\Users\\zvckp\\Desktop\\MyClassApp\\CS502\\"
	
	fileExt: .asciiz ".txt"
	mainMenuText: .asciiz "                        MAIN MENU\n\nEnter indicated number to select option: \nOPTION                                        INPUT \nView Class List                                0 \nStudent Lookup                               1 \nAdd New Student                            2\n   "
	studentMenuText: .asciiz "                   STUDENT MENU\n\nEnter indicated number to select option: \nOPTION                                        INPUT \nView Grades List                             0 \nView Grade Count                           1 \nAdd New Grade                               2\n   "
	invalidInputError: .asciiz "Invalid input was entered. Please try again."
	lookUpFirstName: .asciiz "Enter First Name: "
	lookUpLastName: .asciiz "Enter Last Name: "
	lookUpGrade: .asciiz "Enter the number of the assignment to look up: "
	inputNewGrade: .asciiz "Enter new grade into student record: "
	addedSuccessfully: .asciiz "Successfully created record for the following student: \n"
	recordExists: .asciiz "A record already exists for the following student: \n"
	recordDoesNotExist: .asciiz "No record was found for the following student: \n"
	classListDialog: .asciiz "The following list of students are currently enrolled: \n"
	gradeListDialog: .asciiz "ASSIGNMENT GRADES: \n"
	inputFileName: .asciiz "Input file name for new student record (FirstLast.txt):\n"
	gradeAddedMessage: .asciiz "Grade added successfully!"
	placeholder8: .asciiz "Looking up the grade for Assignment #"
	placeholder9: .asciiz "Adding new assignment with a grade of: "
	
	firstNameInput: .space 20		# Holds value for text input of first name
	lastNameInput: .space 20		# Holds the value for text input of last name
	fullName: .space 50			# Holds value of concatenation of firstNameInput + lastNameInput
	clearNameBuffer: .space 50		# Used to clear the concatenated name after lookup
	
	fileNameBuffer: .space 50		# Will be used when making new file		NOT USED????????????
	
	gradeList: .space 1024			# Memory used for student grades
	clearGradeList: .space 1024		# Used to clear the student grades
	appendedGradeList: .space 1024		# Holds the student's grades + the new grade
	clearAppendedGradeList: .space 1024	# Used to clear the appended grades when finished
	newGrade: .space 10			# Used to hold the input value of new grade
	clearNewGrade: .space 10		# Used to clear the new grade input value
	
	listOfStudents: .space 1024		# Read in contents of 'STUDENTS.txt' text file			NOT USED?????????
	clearListOfStudents: .space 1024	# Used to clear memory of the read in contents of the 'STUDENTS.txt' text file  NOT USED????????????
	
	classListBuffer: .space 1024		# Read in contents of 'STUDENTS.txt' text file
	clearClassList: .space 1024		# Used to clear memory of the read in contents of the 'STUDENTS.txt' text file
	appendedClassList: .space 1024		# The read in contents of 'STUDENTS.txt' text file concatenated with the New Student Name
	clearAppendedClassList: .space 1024	# Used to clear the memoer of appendedClassList
	
	fileName: .space 100			# Used to store the value of the fullName (FirstLast concatenated) + the fileExtension '.txt' concatenated
	clearFileName: .space 100		# Used to clear the fileName memory
	
	filePath: .space 500			# Used to store the concatenated value of the root path + fileName 
	clearFilePath: .space 500		# Used to clear the filePath memory
	
	numberOfGradesDialog: .asciiz "Number of grades in student record: "
	
.text
.globl main
main:

	mainmenu:
		# MAIN MENU
		li $v0, 51						# InputDialogInt
		la $a0, mainMenuText					# address of null-terminated string that is the message to use
		syscall
		
		# MAIN MENU ERROR HANDLING
		# a1 contains the status (0 = OK):
		beq $a1, -2, end					# -2 = Cancel was Chosen
		beq $a1, -1, BadInputMainMenu				# -1 = input data cannot be correctly parsed
		beq $a1, -3, NoInputMainMenu				# -3 = OK was chosen but no data had been input into field

		# MAIN MENU OPTIONS
		# a0 contains the integer
		move $s7, $a0						# move value to s7 so that it can be used latter in the process to determine what direction to take the program
		beq $a0, 0, ViewClassList				# 0 = view class list
		beq $a0, 1, enternames					# 1 = student lookup
		beq $a0, 2, enternames					# 2 = add new student
		
	enternames:
		enterfirstname:
			# ENTER FIRST NAME
			li $v0, 54					# InputDialogString
			la $a0, lookUpFirstName			# address of null-terminated string that is the message to user
			la $a1, firstNameInput				# address of input buffer
			li $a2, 21					# maximum number of characters to read
			syscall
			# a1 contains status (0  = OK, buffer contains input string)
			beq $a1, -2, ReturnToMainMenu 			# -2 = Cancel was chosen. No change to buffer
			beq $a1, -3, NoInputFirstName 			# -3 = OK was chosen but no data has been input into field. No change to buffer.
			beq $a1, -4, BadInputFirstName			# -4 = length of the input string exceeded the specified maximum. Buffer contains the maximum allowable input string plus a terminating null.
		
		enterlastname:
			# ENTER LAST NAME
			li $v0, 54					# InputDialogString
			la $a0, lookUpLastName				# address of null-terminated string that is the message to user
			la $a1, lastNameInput				# address of input buffer
			li $a2, 21					# maximum number of characters to read
			syscall
			# a1 contains status (0  = OK, buffer contains input string)
			beq $a1, -2, ReturnToMainMenu			# -2 = Cancel was chosen. No change to buffer
			beq $a1, -3, NoInputLastName			# -3 = OK was chosen but no data has been input into field. No change to buffer.
			beq $a1, -4, BadInputLastName			# -4 = length of the input string exceeded the specified maximum. Buffer contains the maximum allowable input string plus a terminating null.
	
		beq $s7, 1, StudentMenu
		beq $s7, 2, AddNewStudent
		
	
	# PLACE HOLDER FOR LOOKING UP STUDENT
	StudentMenu:
		concat(firstNameInput, lastNameInput, fullName)	# FirstLast
		concat(fullName, fileExt, fileName)			# FirstLast.txt
		concat(path, fileName, filePath)			# FilePath\\FirstLast.txt
		
		# OPEN THE FILE WITH THE STUDENTS NAME
		li $v0, 13
		la $a0, filePath
		li $a1, 0
		li $a2, 0
		syscall
		move $s6, $v0
		bltz $s6, RecordDoesNotExist
		
		# CLOSE THE FILE
		li $v0, 16
		move $a0, $s6
		syscall
		
		# MENU OF OPTIONS TO PERFORM ON STUDENT'S FILE
		li $v0, 51
		la $a0, studentMenuText
		syscall
		
		# MAIN MENU ERROR HANDLING
		# a1 contains the status (0 = OK):
		beq $a1, -2, ReturnToMainMenu				# -2 = Cancel was Chosen
		beq $a1, -1, BadInputStudentMenu			# -1 = input data cannot be correctly parsed
		beq $a1, -3, NoInputStudentMenu			# -3 = OK was chosen but no data had been input into field

		# MAIN MENU OPTIONS
		# a0 contains the integer
		move $s7, $a0						# move value to s7 so that it can be used latter in the process to determine what direction to take the program
		beq $a0, 0, ViewGradesList				# 0 = view class list
		beq $a0, 1, LookUpGrade				# 1 = student lookup
		beq $a0, 2, InputGrade					# 2 = add new student
					
		clearfullnamebuffer					# Clear fullname buffer before returning to main menu
		clearfilenamebuffer					# Clear fileName buffer before returning to main menu
		clearfilepathbuffer					# Clear filePath buffer before returning to main menu
		j mainmenu
							
								
	ReturnToMainMenu:
		clearfullnamebuffer					# Clear fullname buffer before returning to main menu
		clearfilenamebuffer					# Clear fileName buffer before returning to main menu
		clearfilepathbuffer					# Clear filePath buffer before returning to main menu
		j mainmenu
	
	# STUDENT MENU PLACEHOLDERS
	ViewGradesList:
		# OPEN THE FILE WITH THE STUDENTS NAME
		li $v0, 13
		la $a0, filePath
		li $a1, 0
		li $a2, 0
		syscall
		move $s6, $v0
		
		# READ FROM GRADE LIST FILE
		li $v0, 14						# Read from file syscall
		move $a0, $s6						# file descriptor
		la $a1, gradeList					# address of input buffer
		li $a2, 1024						# max number of characters to read
		syscall
		
		# CLOSE THE FILE
		li $v0, 16
		move $a0, $s6
		syscall
		
		# PRINT THE Grades
		li $v0, 59
		la $a0, gradeListDialog
		la $a1, gradeList
		syscall
		
		cleargradelistbuffer
		j StudentMenu
		
		
	LookUpGrade:
		
		#-------------------------------------------------------------------------------------------------------------------------
		# OPEN THE FILE WITH THE STUDENTS NAME
		li $v0, 13
		la $a0, filePath
		li $a1, 0
		li $a2, 0
		syscall
		move $s6, $v0
		
		# READ FROM GRADE LIST FILE
		li $v0, 14						# Read from file syscall
		move $a0, $s6						# file descriptor
		la $a1, gradeList					# address of input buffer
		li $a2, 1024						# max number of characters to read
		syscall
		
		# CLOSE THE FILE
		li $v0, 16
		move $a0, $s6
		syscall
		
		la $t9, gradeList					# List of grades read from the file
		#li $t8, 0						# loop counter 
		li $t7, 0						# loop counter for number of lines
		
		readgrades:
			lb $t6, ($t9)					# load first byte of the file contents
			beq $t6, 10, increaselinecount			# if it is a new line, increase the new line count by 1
			beqz $t6, donereading				# if null, done reading
			addi $t9, $t9, 1				# Go to next byte of file contents
			j readgrades
		
		increaselinecount:
			addi $t7, $t7, 1				# Increase line count by 1
			addi $t9, $t9, 1				# Go to next byte of file contents
			j readgrades					# jump back to read grades
		
		donereading:
			# AT THIS POINT $t7 CONTIANS THE TOTAL NUMBER OF GRADES
			li $v0, 56
			la $a0, numberOfGradesDialog
			move $a1, $t7
			syscall
			
			cleargradelistbuffer
			j StudentMenu
		
		
		#----------------------------------------------------------------------------------------------------------------------------
		
		#cleargradelistbuffer
		#j StudentMenu
	
	InputGrade:
	
		li $v0, 54						# Input Dialog String
		la $a0, inputNewGrade					# address of null-terminated string that is the message to user
		la $a1, newGrade					# address of input buffer
		li $a2, 4						# max number of characters to read
		syscall
		# a1 contains the status (0 = OK):
		beq $a1, -2, StudentMenu				# -2 = Cancel was Chosen
		beq $a1, -1, BadInputGrade				# -1 = input data cannot be correctly parsed
		beq $a1, -3, NoInputGrade				# -3 = OK was chosen but no data had been input into field
		# POSSIBLY ADD ERROR MESSAGE FOR VALUE OF -4 AKA INPUT TOO LONG

		# OPEN THE FILE WITH THE STUDENTS NAME
		li $v0, 13
		la $a0, filePath
		li $a1, 0
		li $a2, 0
		syscall
		move $s6, $v0
		
		# READ FROM GRADE LIST FILE
		li $v0, 14						# Read from file syscall
		move $a0, $s6						# file descriptor
		la $a1, gradeList					# address of input buffer
		li $a2, 1024						# max number of characters to read
		syscall
		
		# CLOSE THE FILE
		li $v0, 16
		move $a0, $s6
		syscall
		
		# APPEND NEW GRADE HERE
		append(newGrade,gradeList,appendedGradeList)
		# PRINT THE Grades
		li $v0, 59
		la $a0, gradeListDialog
		la $a1, appendedGradeList				# THIS IS THE NEW LIST
		syscall
		
		# OPEN THE FILE FOR WRITING WITH THE STUDENTS NAME
		li $v0, 13
		la $a0, filePath
		li $a1, 1
		li $a2, 0
		syscall
		move $s6, $v0
		
		# WRITING TO TTHE FILE
		li $v0, 15						# Syscall for wtiring to file
		move $a0, $s6						# File Descriptor
		la $a1, appendedGradeList				# addredd of output buffer
		li $a2, 1024						# number of characters to write
		syscall
		
		# CLOSE FILE
		li $v0, 16
		move $a0, $s6
		syscall
		
		# MESSAGE THAT ADDITION WAS SUCCESSFUL!
		li $v0, 55						# MessageDialog
		la $a0, gradeAddedMessage				# Address of null-terminated string that is the message to use
		li $a1, 1						# Type of message, 1= information
		syscall
		
		clearnewgradebuffer
		cleargradelistbuffer
		clearappendedgradelistbuffer
		j StudentMenu
	
	
	# PLACE HOLDER FOR VIEW CLASS LIST
	ViewClassList:
		# OPEN CLASS LIST FILE
		li $v0, 13						# Open file syscall
		la $a0, classListFile					# $a0 = address of null-terminated string containing filename			
		li $a1, 0						# Flag: 0 = read, 1 = write
		li $a2, 0						# Mode: ignored
		syscall 
		move $s6, $v0						# move file descriptor
		# READ FROM CLASS LIST FILE
		li $v0, 14						# Read from file syscall
		move $a0, $s6						# file descriptor
		la $a1, classListBuffer				# address of inut buffer
		li $a2, 1024						# max number of characters to read
		syscall 
		
		# CLOSE FILE
		li $v0, 16
		move $a0, $s6
		syscall
		
		# PRINT THE STUDENTS
		li $v0, 59
		la $a0, classListDialog
		la $a1, classListBuffer
		syscall
		
		clearclasslistbuffer					# Clear the class list buffer before going back to main menu
		j mainmenu
				

	AddNewStudent:
		concat(firstNameInput, lastNameInput, fullName)	# FirstLast
		concat(fullName, fileExt, fileName)			# FirstLast.txt
		concat(path, fileName, filePath)			# FilePath\\FirstLast.txt
		makefile(filePath)					# Create new blank file
		
		# OPEN CLASS LIST FILE
		li $v0, 13						# Open file syscall
		la $a0, classListFile					# $a0 = address of null-terminated string containing filename			
		li $a1, 0						# Flag: 0 = read, 1 = write
		li $a2, 0						# Mode: ignored
		syscall 
		move $s6, $v0						# move file descriptor
		# READ FROM CLASS LIST FILE
		li $v0, 14						# Read from file syscall
		move $a0, $s6						# file descriptor
		la $a1, classListBuffer				# address of inut buffer
		li $a2, 1024						# max number of characters to read
		syscall
		
		# CLOSE FILE
		li $v0, 16
		move $a0, $s6
		syscall
		
		# APPEND NEW STUDENT HERE
		append(fullName,classListBuffer,appendedClassList)
		# PRINT THE STUDENTS
		li $v0, 59
		la $a0, classListDialog
		la $a1, appendedClassList				# THIS IS THE NEW LIST
		syscall
		
		# WRITE THE NEW LIST TO  THE FILE
		# OPEN CLASS LIST FILE FOR WRITING
		li $v0, 13						# Open file syscall
		la $a0, classListFile					# $a0 = address of null-terminated string containing filename			
		li $a1, 1						# Flag: 0 = read, 1 = write
		li $a2, 0						# Mode: ignored
		syscall 
		move $s6, $v0
		
		# WRITING TO TTHE FILE
		li $v0, 15						# Syscall for wtiring to file
		move $a0, $s6						# File Descriptor
		la $a1, appendedClassList				# addredd of output buffer
		li $a2, 1024						# number of characters to write
		syscall
		
		# CLOSE FILE
		li $v0, 16
		move $a0, $s6
		syscall
		
		# MESSAGE FOR SUCCESSFUL ADDITION
		li $v0, 59						# MessageDialogString
		la $a0, addedSuccessfully				# address of null-terminated string that is an information-type message to user
		la $a1, fullName					# address of null-terminated string to display after the first string
		syscall
		
		clearclasslistbuffer					# Clear the class list buffer before going back to main menu
		clearappendedclasslistbuffer				# Clear the appended class list buffer before going back to the main menu
		clearfullnamebuffer					# Clear fullname buffer before returning to main menu
		clearfilenamebuffer					# Clear fileName buffer before returning to main menu
		clearfilepathbuffer					# Clear filePath buffer before returning to main menu
		
		j mainmenu
	
	
	RecordDoesNotExist:
		# MESSAGE FOR RECORD NOT FOUND
		li $v0, 59						# MessageDialogString
		la $a0, recordDoesNotExist				# address of null-terminated string that is an information-type message to user
		la $a1, fullName					# address of null-terminated string to display after the first string
		syscall
		
		clearfullnamebuffer					# Clear fullname buffer before returning to main menu
		clearfilenamebuffer					# Clear fileName buffer before returning to main menu
		clearfilepathbuffer					# Clear filePath buffer before returning to main menu
		j mainmenu
		
	# ERROR HANDLING FIRSTNAME INPUT
	NoInputFirstName:
		noinputwarning
		j enterfirstname
	BadInputFirstName:
		badinputwarning
		j enterfirstname
	
	# ERROR HANDLING LAST NAME INPUT
	NoInputLastName:
		noinputwarning
		j enterlastname
	BadInputLastName:
		badinputwarning
		j enterlastname
		
	# ERROR HANDLING MAIN MENU INPUT
	NoInputMainMenu:
		noinputwarning
		j mainmenu
	BadInputMainMenu:
		badinputwarning
		j mainmenu
		
	# ERROR HANDLING STUDENT MENU INPUT
	NoInputStudentMenu:
		noinputwarning
		j StudentMenu
	BadInputStudentMenu:
		badinputwarning
		j StudentMenu
	
	# ERROR HANDLING GRADE LOOKUP INPUT
	NoInputLookUpGrade:
		noinputwarning
		j LookUpGrade
	BadInputLookUpGrade:
		badinputwarning
		j LookUpGrade
		
	# ERROR HANDLING INPUT GRADE INPUT
	NoInputGrade:
		noinputwarning
		j InputGrade
	BadInputGrade:
		badinputwarning
		j InputGrade
			
end:
	exitprogram