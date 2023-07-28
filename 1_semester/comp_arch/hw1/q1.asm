.data 
	str: .asciz "enter a number: "
	space: .asciz "\n"
	star: .asciz "* "
.text 
.globl main


# https://www.techcrashcourse.com/2016/01/print-right-triangle-star-pattern-in-c.html #;;;;; check this website to understand loops 
 

main:
#print the instruction
	li a7, 4
	la a0,str
	ecall

#get number from the user
	li a7,5
	ecall
	add t0,a0,x0
	
li t1, 0 # iteration value for outer value
outer_loop:
	slt t3,t1,t0 # compare i<rows 
	beq t3,x0,exit
	#beq t1, t0, exit #;;; alternative way to check 
	addi t1,t1, 1 # increment i i++
	li t2, 0 # iteration value for inner value
	
	
inner_loop:
	slt t4, t2, t1 #compare j<i+1
	beq t4,x0,end_inner_loop
	#beq t2,t1,end_inner_loop #;;alternative way to check
	#write *
	li a7,4 
	la a0, star
	ecall
	addi t2,t2, 1 #increment j j++
	b inner_loop  # turn to inner loop


end_inner_loop:
	#write space
	li a7, 4
	la a0, space
	ecall
	b outer_loop #turn to outer lopp

exit:
li a7, 10 
ecall 	
