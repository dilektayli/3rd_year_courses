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
mv t0, a7 

# allocate memory dynamically for array
slli a0, a7, 2
li a7, 9  # system code for allocating memory dynamically     
ecall

#mv t1, x0
li t1,0
#mv t2, a7
addi x17,a7,0
mv t6, a7
mv a1, a7

initializeArray:
    bge t1, t0, endOfinitializeArray

    li a7, 4    # system call code for print_str
    la a0, str2  # address of string to print
    ecall     # print the string

    li a7, 5   #system call code for scan integer
    ecall
    sd a7, 0(x17)

    addi t1, t1, 1 #counter
    addi t2, t2, 4 
    j initializeArray

endOfinitializeArray:

###Sorting Array
mv t1, x0
addi t1, t1, 1

outerloop:
bge t1, t0, end2
mv t3, x0
addi t3, t3, 1
mv t6, a1
##innerloop
sort:
    bge t3, t0, end
    ld a7, 0(t6)
    ld a3, 4(t6)
    slt t4, a7, a3 
    beq t4, x0, swap
    addi t6, t6, 4
    addi t3, t3, 1 #counter
    j sort
swap:
   mv t5, a7
   mv a7, a3
   mv a3, t5
   sw a7, 0(t6)
   sw a3, 4(t6)
   addi t6, t6, 4
   addi t3, t3, 1 #counter
   j sort
end:
addi t1, t1, 1 #counter
j outerloop 
end2:

mv t1, x0

li a7, 4    # system call code for print_str
la a0, str3  # address of string to print
ecall     # print the string

printArray:
    bge t1, t0, ending
    ld a7, 0(a1)
    mv t3, a7
    li a7, 1    #system call code for print_int
    mv a0, t3    # integer to print
    ecall      #print int
    li a7, 4    # system call code for print_str
    la a0, str4  # address of string to print
    ecall     # print the string
    addi a1, a1, 4
    addi t1, t1, 1 #counter
    j printArray

ending:

li a7, 10 # terminate program
ecall


