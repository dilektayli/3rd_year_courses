.global _start
_start:
	  la a0, helloworld	        # prepare to print string  
          li a7, 4			# print string
          ecall

        li a0, 0            # File descriptor, 0 for STDIN
        li a7, 5            # System call code for read integer. The value will be in a0
        ecall
        
        add t0, zero, a0 # for storing lenght of array
        
        li a7, 11
        
        ecall
        
        add t1, zero, zero # for index of array
        add s0, zero, sp # base adress of array
        add s1, zero, sp # also base address
        
        TakeInputLoop:
        	mv a0, t1
        	li a7, 1# Print integer. (the value is taken from a0)
        	ecall
        	li a0, ':'
        	li a7, 11
        	ecall
     		li a0, 0            # File descriptor, 0 for STDIN
       		li a7, 5            # System call code for read integer. The value will be in a0
       		ecall
       		addi s0, s0, 4
       		sw a0, (s0)
       		addi t1, t1, 1
       		li a0, '\n'
        	li a7, 11
        	ecall
        	

       		bne t1, t0, TakeInputLoop
       		
       	mv s0, s1 # define of base address of array to s0
       	addi s0, s0, -4
       	addi t1, zero, -1
       	addi t2, zero, 0
       	addi s8, zero, 0
       	
       	OuterLoop:
       		addi s0, s0, 4
       		addi t1, t1, 1
       		#; addi s10, t1, 1
       		beq t0, t1, PrintArray
       		mv t2,t1
       		mv s1, s0 
       		lw t3, (s0)
       		mv t5, t3
       		mv t6, s0
       		j InnerLoop
     	
     	InnerLoop:
     		addi t2, t2, 1
       		addi s1, s1, 4
       		addi s10, t2, -1
       		bge s10, t0, Swap
     		lw t4, (s1)
     		bge t4, t5, InnerLoop
     		mv t5, t4
     		mv t6, s1
     		j InnerLoop
     	
     	Swap:
     		sw t5, (s0)
     		sw t3, (t6) 
     		j OuterLoop
     		
     	
     	PrintArray:	
     		addi s3, s3, 4
     		lw a0, (s3)
        	li a7, 1			# Print integer. (the value is taken from a0)
        	ecall
        	li a0, ' '
        	li a7, 11
        	ecall
        	addi s8, s8, 1
        	beq s8, t0, Exit
        	j PrintArray
     		
     	Exit:
        	addi a7, zero, 93        #Exit process 
        	addi a0, zero, 13
        	
	.ascii "Size of array?:"
	ecall 

.data	
helloworld:  of array
        mv s3, s0 # define of base address of array to s0
        li a0, '\n'
