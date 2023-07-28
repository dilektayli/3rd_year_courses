.data 
	str: .asciz "enter a number: "
	str2: .asciz "result: "
.text 
.globl main


#PRINT THE SUM UNTIL THE ENTERED VALUE. 

main:
	#print the instruction
	li a7, 4
	la a0,str
	ecall

#get number from the user
	li a7,5
	ecall
	add t0,a0,x0
	
	# beq t0,x0,exit ;; içeride kontrol ediyor
	jal function
	
	li a7, 4    # system call code for print_str
	la a0, str2  # address of string to print
	ecall     # print the string
	
	#li a0, 1   #system call code for print_int
	#add t3,a0,x10
	#ecall  
	
	li a0, 0
	add a0,a3,x0
        li a7, 1# Print integer. (the value is taken from a0)
        ecall
	li a7,10
	ecall 

function:
	addi sp, sp, -16
	sw ra, 8(sp)
	sw a0, 0(sp)
	beq a0,x0, exit # return 5
	addi a0,a0,-1
	jal function
	lw a0, 0(sp)
	lw ra, 8(sp)
	addi sp,sp,16
	add a3,a3,a0
	jr ra

exit:
# return 5 here
addi a3,x0,0 
addi sp,sp,16
jr ra