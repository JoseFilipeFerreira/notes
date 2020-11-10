	.file	"vec-kernel.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	loop1
	.type	loop1, @function
loop1:
.LFB0:
	.cfi_startproc
	vmovss	.LC0(%rip), %xmm4
	xorl	%eax, %eax
	vmovss	.LC1(%rip), %xmm3
	.p2align 4,,10
	.p2align 3
.L2:
	vmovss	(%rdi,%rax), %xmm0
	vmulss	%xmm0, %xmm0, %xmm2
	vmulss	%xmm2, %xmm0, %xmm1
	vdivss	%xmm0, %xmm4, %xmm0
	vdivss	%xmm2, %xmm3, %xmm2
	vaddss	%xmm0, %xmm1, %xmm0
	vaddss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rsi,%rax)
	addq	$4, %rax
	cmpq	$200000000, %rax
	jne	.L2
	ret
	.cfi_endproc
.LFE0:
	.size	loop1, .-loop1
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.p2align 4,,15
	.globl	loop2
	.type	loop2, @function
loop2:
.LFB1:
	.cfi_startproc
	vmovss	.LC0(%rip), %xmm4
	xorl	%eax, %eax
	vmovss	.LC1(%rip), %xmm3
	.p2align 4,,10
	.p2align 3
.L6:
	vmovss	(%rdi,%rax), %xmm0
	vmulss	%xmm0, %xmm0, %xmm2
	vmulss	%xmm2, %xmm0, %xmm1
	vdivss	%xmm0, %xmm4, %xmm0
	vdivss	%xmm2, %xmm3, %xmm2
	vaddss	%xmm0, %xmm1, %xmm0
	vaddss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rsi,%rax)
	addq	$8, %rax
	cmpq	$200000000, %rax
	jne	.L6
	ret
	.cfi_endproc
.LFE1:
	.size	loop2, .-loop2
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
.LCOLDB5:
	.text
.LHOTB5:
	.p2align 4,,15
	.globl	loop3
	.type	loop3, @function
loop3:
.LFB2:
	.cfi_startproc
	vmovss	.LC1(%rip), %xmm5
	xorl	%eax, %eax
	vmovss	.LC0(%rip), %xmm8
	vmovss	.LC4(%rip), %xmm7
	vmovaps	%xmm5, %xmm6
	.p2align 4,,10
	.p2align 3
.L10:
	vmovss	(%rdi,%rax), %xmm1
	vcmpltss	%xmm1, %xmm6, %xmm0
	vmulss	%xmm1, %xmm1, %xmm2
	vandps	%xmm0, %xmm8, %xmm4
	vandnps	%xmm7, %xmm0, %xmm0
	vorps	%xmm4, %xmm0, %xmm0
	vdivss	%xmm1, %xmm0, %xmm0
	vmulss	%xmm2, %xmm1, %xmm3
	vdivss	%xmm2, %xmm5, %xmm2
	vaddss	%xmm3, %xmm0, %xmm0
	vaddss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rsi,%rax)
	addq	$4, %rax
	cmpq	$200000000, %rax
	jne	.L10
	ret
	.cfi_endproc
.LFE2:
	.size	loop3, .-loop3
	.section	.text.unlikely
.LCOLDE5:
	.text
.LHOTE5:
	.section	.text.unlikely
.LCOLDB7:
	.text
.LHOTB7:
	.p2align 4,,15
	.globl	loop4
	.type	loop4, @function
loop4:
.LFB3:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L14:
	vmovss	.LC6(%rip), %xmm1
	vmovss	0(%rbp,%rbx), %xmm0
	call	powf
	vmovss	0(%rbp,%rbx), %xmm1
	vmovss	.LC0(%rip), %xmm3
	vmovss	.LC1(%rip), %xmm4
	vdivss	%xmm1, %xmm3, %xmm2
	vmulss	%xmm1, %xmm1, %xmm1
	vdivss	%xmm1, %xmm4, %xmm1
	vaddss	%xmm0, %xmm2, %xmm0
	vaddss	%xmm1, %xmm0, %xmm1
	vmovss	%xmm1, (%r12,%rbx)
	addq	$4, %rbx
	cmpq	$200000000, %rbx
	jne	.L14
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE3:
	.size	loop4, .-loop4
	.section	.text.unlikely
.LCOLDE7:
	.text
.LHOTE7:
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.p2align 4,,15
	.globl	loop5
	.type	loop5, @function
loop5:
.LFB4:
	.cfi_startproc
	subq	$199999888, %rsp
	.cfi_def_cfa_offset 199999896
	xorl	%eax, %eax
	vmovss	.LC0(%rip), %xmm4
	vmovss	.LC1(%rip), %xmm3
	.p2align 4,,10
	.p2align 3
.L18:
	vmovss	4(%rdi,%rax), %xmm0
	vmulss	%xmm0, %xmm0, %xmm2
	vmulss	%xmm2, %xmm0, %xmm1
	vdivss	%xmm0, %xmm4, %xmm0
	vdivss	%xmm2, %xmm3, %xmm2
	vaddss	%xmm0, %xmm1, %xmm0
	vaddss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, -116(%rsp,%rax)
	addq	$4, %rax
	cmpq	$199999996, %rax
	jne	.L18
	leaq	-116(%rsp), %rax
	leaq	4(%rsi), %rdx
	leaq	199999880(%rsp), %rcx
	.p2align 4,,10
	.p2align 3
.L19:
	vmovss	-4(%rdx), %xmm0
	addq	$4, %rax
	addq	$4, %rdx
	vaddss	-4(%rax), %xmm0, %xmm0
	vmovss	%xmm0, -4(%rdx)
	cmpq	%rax, %rcx
	jne	.L19
	addq	$199999888, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE4:
	.size	loop5, .-loop5
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.text.unlikely
.LCOLDB9:
	.text
.LHOTB9:
	.p2align 4,,15
	.globl	loop6
	.type	loop6, @function
loop6:
.LFB5:
	.cfi_startproc
	vmovss	.LC0(%rip), %xmm5
	xorl	%eax, %eax
	vmovss	.LC1(%rip), %xmm4
	.p2align 4,,10
	.p2align 3
.L24:
	vmovss	(%rdi,%rax), %xmm2
	vmulss	%xmm2, %xmm2, %xmm3
	vmulss	%xmm3, %xmm2, %xmm0
	vaddss	4(%rsi,%rax), %xmm0, %xmm1
	vdivss	%xmm2, %xmm5, %xmm2
	vdivss	%xmm3, %xmm4, %xmm3
	vaddss	%xmm2, %xmm1, %xmm0
	vaddss	%xmm3, %xmm0, %xmm0
	vmovss	%xmm0, (%rsi,%rax)
	addq	$4, %rax
	cmpq	$199999996, %rax
	jne	.L24
	ret
	.cfi_endproc
.LFE5:
	.size	loop6, .-loop6
	.section	.text.unlikely
.LCOLDE9:
	.text
.LHOTE9:
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.p2align 4,,15
	.globl	loop_AoS
	.type	loop_AoS, @function
loop_AoS:
.LFB6:
	.cfi_startproc
	vmovss	.LC0(%rip), %xmm4
	leaq	400000000(%rdi), %rax
	vmovss	.LC1(%rip), %xmm3
	.p2align 4,,10
	.p2align 3
.L27:
	vmovss	(%rdi), %xmm0
	addq	$8, %rdi
	vmulss	%xmm0, %xmm0, %xmm2
	vmulss	%xmm2, %xmm0, %xmm1
	vdivss	%xmm0, %xmm4, %xmm0
	vdivss	%xmm2, %xmm3, %xmm2
	vaddss	%xmm0, %xmm1, %xmm0
	vaddss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, -4(%rdi)
	cmpq	%rdi, %rax
	jne	.L27
	ret
	.cfi_endproc
.LFE6:
	.size	loop_AoS, .-loop_AoS
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.p2align 4,,15
	.globl	loop_SoA
	.type	loop_SoA, @function
loop_SoA:
.LFB7:
	.cfi_startproc
	vmovss	.LC0(%rip), %xmm4
	xorl	%eax, %eax
	vmovss	.LC1(%rip), %xmm3
	.p2align 4,,10
	.p2align 3
.L30:
	vmovss	(%rdi,%rax), %xmm0
	vmulss	%xmm0, %xmm0, %xmm2
	vmulss	%xmm2, %xmm0, %xmm1
	vdivss	%xmm0, %xmm4, %xmm0
	vdivss	%xmm2, %xmm3, %xmm2
	vaddss	%xmm0, %xmm1, %xmm0
	vaddss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rsi,%rax)
	addq	$4, %rax
	cmpq	$200000000, %rax
	jne	.L30
	ret
	.cfi_endproc
.LFE7:
	.size	loop_SoA, .-loop_SoA
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	1092616192
	.align 4
.LC1:
	.long	1120403456
	.align 4
.LC4:
	.long	1101004800
	.align 4
.LC6:
	.long	1077936128
	.ident	"GCC: (GNU) 5.3.0"
	.section	.note.GNU-stack,"",@progbits
