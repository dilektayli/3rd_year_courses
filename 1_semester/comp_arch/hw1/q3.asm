.data 
	str: .asciz "enter the size of the array: "
	str2: .asciz "enter element: "
	space: .asciz " "
.text 
.globl main

main:
	#print "enter the size of the array: "
	li a7, 4
	la a0, str
	ecall
	
	#get the size from the user
	li a7, 5  
	ecall
	add t0, a0, zero  #t0 is the length of the array
	
	addi t1,x0,0 # i value for iteration	
	add s0, x0,sp # base address for array for initializing array
	addi s1, sp,0 # base address for array for sorting array
	addi s2, sp,0 # base address for array for printing array



start_array:
	bge t1,t0,sort_array #  check i is bigger than array length( t1>t0)
	
	# print "enter element: "
	li a7, 4
	la a0, str2
	ecall
	
	#getting elements from the user
	li a7,5
	ecall
	add t3,a0,x0 # t3 is the element that currently given by the user.
	
	# adding to the array ;;;;;;;;;;;;
	addi s0,s0,4
	sw a0,(s0)
	#;;;;;;;;;;;;;;;
	
	
	addi t1,t1,1 #i++ for loop
	j start_array



li t1,0 #outer loop iteration
li t2,0 #inner loop iteration
mv s1,sp
sort_array: 
	outer_loop:
		# beq t1,t0,print_array
		addi t1,t1,1
		j inner_loop
		
	inner_loop:
		addi s1,s1,4
		ld t5,(s1)
		addi s1,s1,4
		ld t6,(s1)
		addi t2,t2,1
		bge t5,t6,change
		j outer_loop	
	change:
		mv a3,t5
		mv t5,t6
		mv t6,a3
		j outer_loop

mv s2,s1		
print_array:

	bge t4,t0,exit #t4 iteration value
	addi s2,s2,4
	ld t6,(s2)
	
	#addi sp,sp,4
	#ld t6,0(sp)
	

	#print array element
	li a0, 0
	add a0,t6,x0 
        li a7, 1
        ecall
	
	
	#print space
	li a7, 4
	la a0, space
	ecall
	
        addi t4,t4,1 #increment iteration value
        j print_array
	
	
exit:
	li a7,10
	ecall 
        
	
