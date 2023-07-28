.data 
	str: .asciz "enter the size of the array: "
	str2: .asciz "enter element: "
	str4: .asciz " "
.text 
.globl main

main:

	#;;;;;;;;;;;;;;;;; PRINTING INTEGER
	#li a0, 0
	#add a0,t3,x0 
        #li a7, 1
        #ecall
        #;;;;;;;;;;;;;;;;;
        
        
	#print "enter the size of the array: "
	li a7, 4
	la a0, str
	ecall
	
	#get the size from the user
	li a7, 5  
	ecall
	add t0, a0, zero  #t0 is the length of the array
	
		
	li t1,0 # i value for iteration	
	

addi t5,x0,-8
mul t5,t0,t5
add sp,sp,t5


start_array:
	bge t1,t0,print_array #  check i is bigger than array length( t1>t0)
	
	# print "enter element: "
	li a7, 4
	la a0, str2
	ecall
	
	#getting elements from the user
	li a7,5
	ecall
	add t3,a0,x0 # t3 is the element that currently given by the user.
	
	# adding to the array ;;;;;;;;;;;;
	sd t3,0(sp)
	addi sp,sp,-8
	
	
	addi t1,t1,1 #i++ for loop
	
	j start_array

sort_array: #to be contiuned
	li t1,1
	outer_loop:
		bge t1,t0,end_outer_loop
		li t3,1
		
		
				
end_outer_loop:
	li a7,10		

li t5,0
print_array:
	bge t5,t0,exit
	ld t3,0(sp)
	addi sp,sp,8
	
	li a7, 1    #system call code for print_int
	addi a0,t3,0
   	ecall      #print int
        li a7, 4    # system call code for print_str
    	la a0, str4  # address of string to print
    	ecall   
	


	
exit:
	li a7,10
	ecall 
        
	
