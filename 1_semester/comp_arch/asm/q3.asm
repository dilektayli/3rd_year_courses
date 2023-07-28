.data 
	str: .asciz "enter the size of the array: "
	str2: .asciz "enter the elements for the array: \n"
	array: .word 0 : 100 # allocate space for 100 ints
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
	add t1, t1, a0  #t1 is the length of the array
	
	#load address of array 
	la t0,array #stack pointer for the array
	li t2,0
	li t3,0
	li t5,0 #stack pointers to clean the stack to use it again for writing
	li t6,0 #stack pointers
	
	#set loop variables to 0
	la a0,str2
	li a7,4
	addi x22,zero,0 #outer loop i
	addi x23,zero,0 #inner loop k
	ecall
	
create: 
	beq t2,t1,out
	li a7,5
	ecall 
	sw a0,0(t0) # store the value of a0(given by user) in the t0 which is array 
	addi t2,t2,1
	addi t0,t0,4 
	addi t5,t5,4
	jal create
	
out:
	sub t0,t0,t5 # clean stack by decreasing 4
	jal outer_loop
	
out_2:
	jal print_array
	
	
outer_loop:
	beq x22,t1,out_2
inner_loop:
	sub x24,t1,x22
	addi x24,x24,-1
	beq x23,x24,end_2
	
	lw x9,0(t0) #arr[n]
	lw x12,4(t0) #arr[n+1]
	
	bge x12,x9,no_swap
	sw x12,0(t0)
	sw x9,4(t0)
	
no_swap:
	addi x23,x23,1
	addi t0,t0,4 # increment stack pointer to go to the next array element
	addi t6,t6,4
	j inner_loop

end_2:
	sub t0,t0,t6
	addi t6,zero,0
	addi x22,x22,1
	addi x23,zero,0
	j outer_loop
	
print_array:
	beq t1,t3, done
	li a7,1
	lw a0,0(t0)
	ecall 
	la a0,space
	li a7,4
	ecall 
	addi t3,t3,1
	addi t0,t0,4
	j print_array
done:
	li a7,10
	ecall 