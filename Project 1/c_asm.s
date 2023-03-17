/* Kai Ibarrondo */
	.section .data
/* initialized global data */
str1:	.string "Enter a string of 0s and 1s: "
str2:   .string "%c"
str3:	.string "Invalid input: program terminating\n"
str4:   .string "Input accepted\n"
str5:   .string "Input rejected\n"
state:  .long	0		# int state = 0
EE:	.long	0		    # int EE = 0
OE:	.long	1		    # int OE = 0
OO:	.long	2		    # int OO = 0
EO:	.long	3		    # int EO = 0
/* uninitialized global data */
	.comm char, 1
/* main function */
	.text
.globl main
main:
	pushl %ebp
	movl %esp, %ebp		# start
	pushl $str1		    # push str1 onto stack
	call printf		    # call print function
	addl $4, %esp		# deallocate parameter to printf
	
loop:
	pushl $char         # push char address of a onto stack
	pushl $str2 		# push address of str onto stack
	call scanf 		    # call scanf: value read stored into char
	addl $8, %esp 		# pop arguments off stack
	mov char, %al		# move char to %al register
	cmpb $'\n', %al 	# compare '\n' to char in %al register
	je .L2			    # if '\n' and %al are equal jump to L2
	cmpb $'0', %al   	# compare 0 to char in %al register
	je .switch		    # if '0' and %al are equal jump to L0
	cmpb $'1', %al		# compare '1' to char in %al registar 
	jne .L1			    # if '1' and %al are not equal jump to L1
	
.switch:
	movl state, %eax    # move state to the %eax register
	cmpl EE, %eax		# compare the value in EE (0) to the %eax (state)
	je .case0		    # if EE and %eax are equal jump to case0
	cmpl OE, %eax		# compare the value in OE (1) to the %eax (state)
	je .case1		    # if OE and %eax are equal jump to case1
	cmpl OO, %eax		# compare the value in OO (2) to the %eax (state)
	je .case2		    # if OO and %eax are equal jump to case2
	cmpl EO, %eax		# compare the value in EO (2) to the %eax (state)
	je .case3		    # if OO and %eax are equal jump to case3
	jmp loop		    # break back to the loop
	
.case0:
	mov char, %al		# move char to %al register (%al = char)
	cmpb $'0', %al		# compare '0' to %al register
	jne .else0		    # if '0' and %al register are not equal jump to else0
	movl OE, %eax		# if '0' and %al register are equal move OE in %eax register (%eax = OE)
	movl %eax, state	# move %eax register into state (state = %eax)
	jmp loop		    # break back to loop

.case1:
	mov char, %al		# move char to %al register (%al = char)
	cmpb $'0', %al		# compare '0' to %al register
	jne .else1		    # if '0' and %al register are not equal jump to else1
	movl EE, %eax		# if '0' and %al register are equal move EE in %eax register (%eax = EE)
	movl %eax, state	# move %eax register into state (state = %eax)
	jmp loop		    # break back to loop
	
.case2:
	mov char, %al		# move char to %al register (%al = char)
	cmpb $'0', %al		# compare '0' to %al register
	jne .else2		    # if '0' and %al register are not equal jump to else2
	movl EO, %eax		# if '0' and %al register are equal move EO in %eax register (%eax = EO)
	movl %eax, state	# move %eax register into state (state = %eax)
	jmp loop		    # break back to loop
	
.case3:
	mov char, %al		# move char to %al register (%al = char)
	cmpb $'0', %al		# compare '0' to %al register
	jne .else3		    # if '0' and %al register are not equal jump to else3
	movl OO, %eax		# if '0' and %al register are equal move OO in %eax register (%eax = OO)
	movl %eax, state	# move %eax register into state (state = %eax)
	jmp loop		    # break back to loop
	
.else0:
	movl EO, %ecx		# move EO into %ecx register (%ecx = EO)
	movl %ecx, state	# move %ecx register into state (state = %ecx)
	jmp loop		    # break back to loop

.else1:
	movl OO, %ecx		# move OO into %ecx register (%ecx = OO)
	movl %ecx, state	# move %ecx register into state (state = %ecx)
	jmp loop		    # break back to loop
	
.else2:
	movl OE, %ecx		# move OE into %ecx register (%ecx = OE)
	movl %ecx, state	# move %ecx register into state (state = %ecx)
	jmp loop		    # break back to loop

.else3:
	movl EE, %ecx		# move EE into %ecx register (%ecx = EE)
	movl %ecx, state	# move %ecx register into state (state = %ecx)
	jmp loop		    # break back to loop

.L1:
	pushl $str3		    # push str3 onto stack
	call printf		    # call print
	addl $4, %esp  		# deallocate parameter to printf
	jmp .L4			    # jump to L4 to exit
	
.L2:
	movl EE, %eax		# move EE into %eax register
	movl state, %ebx	# move state into %ebx register
	cmpl %ebx, %eax		# compare %eax register to %ebx register (this is checking if state == EE)
	je .L3			    # if %eax register and %ebx register are equal jump to L3. (this means that there are equal 1's and 0's)
	pushl $str5		    # push str5 onto stack (this means that state != EE, so we print reject message)
	call printf		    # call print
	addl $4, %esp		# deallocate parameter to printf
	jmp .L4			    # jump to L4 to exit
	
.L3:
	pushl $str4		    # push str4 onto stack
	call printf		    # call print function (this prints accept message)
	addl $4, %esp		# deallocate parameter to printf
	jmp .L4			    # jump to L4 to exit
	
.L4: 
	leave			    # end
	ret
