.data
str: .asciz "Enter a number: "
str2: .asciz "Enter an array element: "
str3: .asciz "Your sorted array is:  "
str4: .asciz "  "
arr:    .space 4
.text
.globl main

main:
	li a7, 4    # system call code for print_str
	la a0, str  # address of string to print
	ecall     # print the string

	li a7, 5   #system call code for scan integer
	ecall

	addi t0,a7,0


	# allocate memory dynamically for array
	slli a0, a7, 3
	li a7, 9  # system code for allocating memory dynamically     
	ecall
	
	addi t1,x0,0
	addi t2,a7,0
	addi t6,a7,0
	addi x9,a7,0



initializeArray:
    bge t1, t0, endOfinitializeArray

    li a7, 4    # system call code for print_str
    la a0, str2  # address of string to print
    ecall     # print the string

    li a7, 5   #system call code for scan integer
    ecall
    sw a7, 0(t2)

    addi t1, t1, 1 #counter
    addi t2, t2, 8
    j initializeArray

endOfinitializeArray:

###Sorting Array

addi t1,x0,0
addi t1, t1, 1

outerloop:
bge t1, t0, end2
addi t3,x0,0
addi t3, t3, 1
addi t6,x9,0

##innerloop
sort:
    bge t3, t0, end
    lb a7, 0(t6)
    lb x8, 8(t6)
    slt t4, a7, x8 
    beq t4, x0, swap
    addi t6, t6, 8
    addi t3, t3, 1 #counter
    j sort
swap:
   addi t5,a7,0
   addi a7,x8,0
   addi x8,t5,0
   sw a7, 0(t6)
   sw x8, 8(t6)
   addi t6, t6, 8
   addi t3, t3, 1 #counter
   j sort
end:
addi t1, t1, 1 #counter
j outerloop 
end2:


addi t1,x0,0

li a7, 4    # system call code for print_str
la a0, str3  # address of string to print
ecall     # print the string

printArray:
    bge t1, t0, ending
    lb a7, 0(x9)
    addi t3,a7,0
    li a7, 1    #system call code for print_int
    addi a0,t3,0
    ecall      #print int
    li a7, 4    # system call code for print_str
    la a7, str4  # address of string to print
    ecall     # print the string
    addi x9, x9, 8
    addi t1, t1, 1 #counter
    j printArray

ending:

li a7, 10 # terminate program
ecall