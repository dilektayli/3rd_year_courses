.data
length:	.word	1	
array:	.word	0 : 150	
line:	.asciz	"\n"	
delimeter:	.asciiz "  "		
	
message:	.asciz	"Array Size: "
number:	.asciz	"\nNumber: "

.text
.globl	main

main:

	li	a7, 4			
	la	a0, message	
	ecall					
	li a7, 5			
	ecall				
	la      s9, length		
	sw	a7, 0(s9)		
	li	t0, 0			
	lw	s8, length		
	la	s9, array
	li  s0, 1
	li  s4, 4		

input_loop:

	beq	t0, s8, out
	li	a7, 4			
	la	a0, number
	ecall	
	li	a7, 5			
	ecall				
	sw	a7, 0(s9)	
	add	t0, t0, s0	
	add	s9, s9, s1		
	j	input_loop	

out:


	addi t0,s0,0
	lw	s8, length		
			

outer_loop:

	la	s9, array		
	beq	t0,  s8, end_outer	
	addi t1,t0,0	

inner_loop:

	slli	t2, t1, 2	
	la	s9, array		
	add	s9, s9, t2		
	beq	x0, t1, end_inner
	lw	t3, 0(s9)		
	lw	t4, -4(s9)		
	bge	t3, t4, end_inner	
	lw	t5, 0(s9)
	sw	t4, 0(s9)
	sw	t5, -4(s9)
	addi	t1, t1, -1
	j	inner_loop		

end_inner:

	add	t0, t0, s0		
	j	outer_loop		

end_outer:	

	li	a7, 4			
	la	a0, line		
	ecall				
	li	t0, 0
	lw	s8, length
	la	s9, array
	
print_loop:

	beq	t0, s8, finish
	li	a7, 1
	lw	a0, 0(s9)
	ecall
	li	a7, 4
	la	a0, delimeter
	ecall
	add 	s9, s9, s1
	add 	t0, t0, s0
	j	print_loop
	
finish:
	li	a7, 10			
	ecall				