	.text

############################################################
## CSO1 Spring 2023 - Homework 5 
## 
## Computing ID: rfz9cu
## 
## You must update your ID above to receive credit.  Note
## that this is an individual assignment and you may NOT
## use a compiler.
############################################################                         

############################################################
##   modulo routine (calculates mod using add/subtract)   ##
############################################################

	.globl	modulo

modulo:
	pushq %rdi
	# setting x
	pushq %rsi
	# setting y
	cmpq %rsi, 0
	# seeing if y is 0
	jmp return_zero
	# if it is then jump to return zero

loop:
	cmpq %rdi, 0
	#checking if x is 0
	jl end
	# if x gets negative then go to end
	subq %rsi, %rdi
	# doing subtraction
	jmp loop
	# repeat the loop

end:
	addq %rdi, %rsi
	# adding the last subtraction
	movq %rdi, %rax
	# moving x into rax
	popq %rsi
	popq %rdi
	# popping x and y
	retq
	#returning the value

return_zero:
	xorq %rax, %rax
	# xor rax with itself cause it will always be 0
	popq %rsi
	popq %rdi
	# popping x and y
	retq
	# returning the value

############################################################
##                 end of modulo routine                  ##
############################################################



############################################################
##            gcd routine (gcd using modulo)              ##
############################################################

	.globl	gcd
gcd:
	pushq %rdi
	# setting x
	pushq %rsi
	# setting y
	cmpq %rdi, %rsi
	# seeing if x == y
	jmp return_y
	# jumping to return_y
	cmpq %rsi, 0
	# seeing if y is equal to 0
	jmp return_x
	# jumping to return_x
	callq modulo
	# calling modulo
	movq %rsi, %rdi
	# moving y into the first argument
	movq %rax, %rsi
	# moving modulo result into the second argument
	callq gcd
	# calling gcd on y and the modulo result
	popq %rsi
	popq %rdi
	# popping the arguments
	retq

return_y:
	movq %rdi, %rax
	# moving y into rax
	popq %rsi
	popq %rdi
	# popping x and y
	retq

return_x:
	movq %rsi, %rax
	# moving x into rax
	popq %rsi
	popq %rdi
	# popping x and y
	retq

############################################################
##                 end of gcd routine                     ##
############################################################



############################################################
##           prime routine (prime using gcd)              ##
############################################################

	.globl	prime
prime:
	pushq %rdi
	pushq %rsi
	# pushing x and i
	cmpq %rdi, %rsi
	# is i in rsi? 
	# checking if rdi is equal to i
	# basically like it reached the end of i increments
	jmp is_prime
	# go to is prime function
	call gcd
	# calling gcd on x and i
	cmpq 1, %rax
	# checking if 1 is equal to gcd result
	jmp not_prime
	# if x greatest common denom isnt 1 then its not prime
	incq %rsi
	# increment i
	jmp prime
	# call the loop again

is_prime:
	movq 1, %rax
	# moving 1 to result
	popq %rsi
	popq %rdi
	# popping arguments
	retq

not_prime:
	movq 0, %rax
	# moving 0 to result
	popq %rsi
	popq %rdi
	# popping arguements
	retq


############################################################
##                end of prime routine                    ##
############################################################




############################################################
	.globl	printNum
printNum:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%fs:40, %rax
	movq	%rax, 16(%rsp)
	movb	$48, 15(%rsp)
	testq	%rdi, %rdi
	je	.LBB0_9
	movq	%rdi, %r14
	movabsq	$1000000000000000, %rbx
	cmpq	%rbx, %rdi
	jae	.LBB0_5
	movabsq	$-3689348814741910323, %rsi
.LBB0_3:
	movq	%rbx, %rcx
	movq	%rbx, %rax
	mulq	%rsi
	movq	%rdx, %rbx
	shrq	$3, %rbx
	cmpq	%r14, %rbx
	ja	.LBB0_3
	cmpq	$10, %rcx
	jb	.LBB0_7
.LBB0_5:
	movabsq	$-3689348814741910323, %r12
	leaq	15(%rsp), %r15
.LBB0_6:
	xorl	%edx, %edx
	movq	%r14, %rax
	divq	%rbx
	movq	%rax, %rcx
	mulq	%r12
	shrl	$2, %edx
	andl	$-2, %edx
	leal	(%rdx,%rdx,4), %eax
	subl	%eax, %ecx
	orb	$48, %cl
	movb	%cl, 15(%rsp)
	movl	$1, %edi
	movl	$1, %edx
	movq	%r15, %rsi
	callq	write@PLT
	movq	%rbx, %rax
	mulq	%r12
	shrq	$3, %rdx
	cmpq	$9, %rbx
	movq	%rdx, %rbx
	ja	.LBB0_6
	jmp	.LBB0_7
.LBB0_9:
	leaq	15(%rsp), %rsi
	movl	$1, %edi
	movl	$1, %edx
	callq	write@PLT
.LBB0_7:
	leaq	15(%rsp), %rsi
	movb	$10, (%rsi)
	movl	$1, %edi
	movl	$1, %edx
	callq	write@PLT
	movq	%fs:40, %rax
	cmpq	16(%rsp), %rax
	jne	.LBB0_8
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.LBB0_8:
	callq	__stack_chk_fail@PLT
############################################################




############################################################
	.globl	main
main:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	leaq	.L.str(%rip), %rsi
	movl	$1, %edi
	movl	$9, %edx
	callq	write@PLT
	leaq	7(%rsp), %rbx
	movb	$48, (%rbx)
	movb	$48, %al
	xorl	%r14d, %r14d
.LBB1_1:
	movsbq	%al, %rax
	leaq	(%r14,%r14,4), %rcx
	leaq	(%rax,%rcx,2), %r14
	addq	$-48, %r14
	xorl	%edi, %edi
	movl	$1, %edx
	movq	%rbx, %rsi
	callq	read@PLT
	movb	7(%rsp), %al
	cmpb	$10, %al
	jne	.LBB1_1
	leaq	.L.str.1(%rip), %rsi
	xorl	%ebx, %ebx
	xorl	%edi, %edi
	movl	$9, %edx
	callq	write@PLT
	leaq	7(%rsp), %r15
	movb	$48, (%r15)
	movb	$48, %al
.LBB1_3:
	movsbq	%al, %rax
	leaq	(%rbx,%rbx,4), %rcx
	leaq	(%rax,%rcx,2), %rbx
	addq	$-48, %rbx
	xorl	%edi, %edi
	movl	$1, %edx
	movq	%r15, %rsi
	callq	read@PLT
	movb	7(%rsp), %al
	cmpb	$10, %al
	jne	.LBB1_3
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	modulo@PLT
	movq	%rax, %r15
	leaq	.L.str.2(%rip), %rsi
	movl	$1, %edi
	movl	$8, %edx
	callq	write@PLT
	movq	%r15, %rdi
	callq	printNum
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	gcd@PLT
	movq	%rax, %r15
	leaq	.L.str.3(%rip), %rsi
	movl	$1, %edi
	movl	$12, %edx
	callq	write@PLT
	movq	%r15, %rdi
	callq	printNum
	movq	%r14, %rdi
	callq	prime@PLT
	movq	%rax, %r15
	leaq	.L.str.4(%rip), %rsi
	movl	$1, %edi
	movl	$10, %edx
	callq	write@PLT
	movq	%r15, %rdi
	callq	printNum
	movq	%rbx, %rdi
	callq	prime@PLT
	movq	%rax, %rbx
	leaq	.L.str.5(%rip), %rsi
	movl	$1, %edi
	movl	$10, %edx
	callq	write@PLT
	movq	%rbx, %rdi
	callq	printNum
	movq	%fs:40, %rax
	cmpq	8(%rsp), %rax
	jne	.LBB1_6
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.LBB1_6:
	callq	__stack_chk_fail@PLT
############################################################




############################################################
	.section	.rodata
.L.str:
	.asciz	"Enter x: "
.L.str.1:
	.asciz	"Enter y: "
.L.str.2:
	.asciz	"x % y = "
.L.str.3:
	.asciz	"gcd(x, y) = "
.L.str.4:
	.asciz	"x prime = "
.L.str.5:
	.asciz	"y prime = "
############################################################
