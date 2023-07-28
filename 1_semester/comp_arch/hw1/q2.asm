.data 
	str: .asciz "enter a number: "
	str2: .asciz "result: "
.text 
.globl main


main:
	#print the instruction
	li a7, 4
	la a0,str
	ecall

#get number from the user
	li a7,5
	ecall
	add t0,a0,x0
	
	# call the function
	jal function
	
	#print "result"
	li a7, 4    
	la a0, str2  
	ecall     
	
	# Print integer. (the value is taken from  =>  a0)
	li a0, 0
	add a0,a3,x0
        li a7, 1
        ecall

	# exit the program
	li a7,10
	ecall 

function:
	addi sp, sp, -16  # create stack pointer for x and return address
	sw ra, 8(sp) # return address
	sw a0, 0(sp) # x value
	beq a0,x0, exit  # check a0<0 if so branch to exit.
	addi a0,a0,-1  #x = x -1
	jal function  #call function
	lw a0, 0(sp)  # load the values from stack
	lw ra, 8(sp)
	addi sp,sp,16 # clear the stack
	addi t2,x0,2  #t2 = 2
	mul a3,a3,t2 #a3 = 2* a3
	add a3,a3,a0  # remember the value we sent to stack (a0)
	jr ra  #return back

exit:
# return 5 here
addi a3,x0,5 
addi sp,sp,16
jr ra