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
	vmovaps	.LC0(%rip), %ymm4
	xorl	%eax, %eax
	vmovaps	.LC1(%rip), %ymm3
	.p2align 4,,10
	.p2align 3
.L2:
	vmovups	(%rdi,%rax), %xmm0
	vinsertf128	$0x1, 16(%rdi,%rax), %ymm0, %ymm0
	vmulps	%ymm0, %ymm0, %ymm2
	vdivps	%ymm0, %ymm4, %ymm1
	vmulps	%ymm0, %ymm2, %ymm0
	vaddps	%ymm0, %ymm1, %ymm0
	vdivps	%ymm2, %ymm3, %ymm2
	vaddps	%ymm2, %ymm0, %ymm0
	vmovups	%xmm0, (%rsi,%rax)
	vextractf128	$0x1, %ymm0, 16(%rsi,%rax)
	addq	$32, %rax
	cmpq	$200000000, %rax
	jne	.L2
	vzeroupper
	ret
	.cfi_endproc
.LFE0:
	.size	loop1, .-loop1
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB5:
	.text
.LHOTB5:
	.p2align 4,,15
	.globl	loop2
	.type	loop2, @function
loop2:
.LFB1:
	.cfi_startproc
	vmovss	.LC3(%rip), %xmm4
	xorl	%eax, %eax
	vmovss	.LC4(%rip), %xmm3
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
.LCOLDE5:
	.text
.LHOTE5:
	.section	.text.unlikely
.LCOLDB7:
	.text
.LHOTB7:
	.p2align 4,,15
	.globl	loop3
	.type	loop3, @function
loop3:
.LFB2:
	.cfi_startproc
	vmovaps	.LC1(%rip), %ymm4
	xorl	%eax, %eax
	vmovaps	.LC0(%rip), %ymm6
	vmovaps	.LC6(%rip), %ymm5
	.p2align 4,,10
	.p2align 3
.L9:
	vmovups	(%rdi,%rax), %xmm0
	vinsertf128	$0x1, 16(%rdi,%rax), %ymm0, %ymm0
	vcmpltps	%ymm0, %ymm4, %ymm1
	vmulps	%ymm0, %ymm0, %ymm3
	vblendvps	%ymm1, %ymm6, %ymm5, %ymm1
	vdivps	%ymm0, %ymm1, %ymm2
	vmulps	%ymm0, %ymm3, %ymm0
	vaddps	%ymm0, %ymm2, %ymm1
	vdivps	%ymm3, %ymm4, %ymm0
	vaddps	%ymm0, %ymm1, %ymm0
	vmovups	%xmm0, (%rsi,%rax)
	vextractf128	$0x1, %ymm0, 16(%rsi,%rax)
	addq	$32, %rax
	cmpq	$200000000, %rax
	jne	.L9
	vzeroupper
	ret
	.cfi_endproc
.LFE2:
	.size	loop3, .-loop3
	.section	.text.unlikely
.LCOLDE7:
	.text
.LHOTE7:
	.section	.text.unlikely
.LCOLDB9:
	.text
.LHOTB9:
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
.L12:
	vmovss	.LC8(%rip), %xmm1
	vmovss	0(%rbp,%rbx), %xmm0
	call	powf
	vmovss	0(%rbp,%rbx), %xmm1
	vmovss	.LC3(%rip), %xmm3
	vmovss	.LC4(%rip), %xmm4
	vdivss	%xmm1, %xmm3, %xmm2
	vmulss	%xmm1, %xmm1, %xmm1
	vdivss	%xmm1, %xmm4, %xmm1
	vaddss	%xmm0, %xmm2, %xmm0
	vaddss	%xmm1, %xmm0, %xmm1
	vmovss	%xmm1, (%r12,%rbx)
	addq	$4, %rbx
	cmpq	$200000000, %rbx
	jne	.L12
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
.LCOLDE9:
	.text
.LHOTE9:
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.p2align 4,,15
	.globl	loop5
	.type	loop5, @function
loop5:
.LFB4:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	xorl	%eax, %eax
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x78,0x6
	leaq	-200000016(%rbp), %rcx
	subq	$199999888, %rsp
	addq	$4, %rcx
	vmovaps	.LC0(%rip), %ymm4
	vmovaps	.LC1(%rip), %ymm3
	.p2align 4,,10
	.p2align 3
.L16:
	vmovups	4(%rdi,%rax), %xmm0
	vinsertf128	$0x1, 20(%rdi,%rax), %ymm0, %ymm0
	vmulps	%ymm0, %ymm0, %ymm2
	vmulps	%ymm2, %ymm0, %ymm1
	vdivps	%ymm0, %ymm4, %ymm0
	vaddps	%ymm0, %ymm1, %ymm0
	vdivps	%ymm2, %ymm3, %ymm2
	leaq	(%rax,%rcx), %rdx
	addq	$32, %rax
	vaddps	%ymm2, %ymm0, %ymm0
	vmovups	%xmm0, (%rdx)
	vextractf128	$0x1, %ymm0, 16(%rdx)
	cmpq	$199999968, %rax
	jne	.L16
	leaq	-200000016(%rbp), %rcx
	xorl	%eax, %eax
	vmovss	.LC3(%rip), %xmm4
	vmovss	.LC4(%rip), %xmm3
	leaq	199999972(%rcx), %rdx
	.p2align 4,,10
	.p2align 3
.L17:
	vmovss	199999972(%rdi,%rax), %xmm0
	vmulss	%xmm0, %xmm0, %xmm2
	vdivss	%xmm0, %xmm4, %xmm1
	vmulss	%xmm0, %xmm2, %xmm0
	vdivss	%xmm2, %xmm3, %xmm2
	vaddss	%xmm0, %xmm1, %xmm0
	vaddss	%xmm2, %xmm0, %xmm0
	vmovss	%xmm0, (%rdx,%rax)
	addq	$4, %rax
	cmpq	$28, %rax
	jne	.L17
	leaq	-200000016(%rbp), %rax
	leaq	4(%rsi), %rdx
	addq	$4, %rax
	leaq	-16(%rbp), %rcx
	.p2align 4,,10
	.p2align 3
.L18:
	vmovss	-4(%rdx), %xmm0
	addq	$4, %rax
	addq	$4, %rdx
	vaddss	-4(%rax), %xmm0, %xmm0
	vmovss	%xmm0, -4(%rdx)
	cmpq	%rax, %rcx
	jne	.L18
	vzeroupper
	addq	$199999888, %rsp
	popq	%r10
	.cfi_def_cfa 10, 0
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	loop5, .-loop5
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.p2align 4,,15
	.globl	loop6
	.type	loop6, @function
loop6:
.LFB5:
	.cfi_startproc
	vmovaps	.LC0(%rip), %ymm6
	xorl	%eax, %eax
	vmovaps	.LC1(%rip), %ymm5
	.p2align 4,,10
	.p2align 3
.L24:
	vmovups	4(%rsi,%rax), %xmm2
	vinsertf128	$0x1, 20(%rsi,%rax), %ymm2, %ymm2
	vmovups	(%rdi,%rax), %xmm3
	vinsertf128	$0x1, 16(%rdi,%rax), %ymm3, %ymm3
	vmulps	%ymm3, %ymm3, %ymm4
	vmulps	%ymm4, %ymm3, %ymm1
	vaddps	%ymm1, %ymm2, %ymm2
	vdivps	%ymm3, %ymm6, %ymm1
	vdivps	%ymm4, %ymm5, %ymm0
	vaddps	%ymm1, %ymm2, %ymm1
	vaddps	%ymm0, %ymm1, %ymm0
	vmovups	%xmm0, (%rsi,%rax)
	vextractf128	$0x1, %ymm0, 16(%rsi,%rax)
	addq	$32, %rax
	cmpq	$199999968, %rax
	jne	.L24
	vmovss	.LC3(%rip), %xmm5
	xorl	%eax, %eax
	vmovss	.LC4(%rip), %xmm4
	.p2align 4,,10
	.p2align 3
.L25:
	vmovss	199999968(%rdi,%rax), %xmm2
	vmulss	%xmm2, %xmm2, %xmm3
	vmulss	%xmm2, %xmm3, %xmm0
	vaddss	199999972(%rsi,%rax), %xmm0, %xmm1
	vdivss	%xmm2, %xmm5, %xmm2
	vdivss	%xmm3, %xmm4, %xmm3
	vaddss	%xmm2, %xmm1, %xmm0
	vaddss	%xmm3, %xmm0, %xmm0
	vmovss	%xmm0, 199999968(%rsi,%rax)
	addq	$4, %rax
	cmpq	$28, %rax
	jne	.L25
	vzeroupper
	ret
	.cfi_endproc
.LFE5:
	.size	loop6, .-loop6
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.section	.text.unlikely
.LCOLDB12:
	.text
.LHOTB12:
	.p2align 4,,15
	.globl	loop_AoS
	.type	loop_AoS, @function
loop_AoS:
.LFB6:
	.cfi_startproc
	vmovss	.LC3(%rip), %xmm4
	leaq	400000000(%rdi), %rax
	vmovss	.LC4(%rip), %xmm3
	.p2align 4,,10
	.p2align 3
.L29:
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
	jne	.L29
	ret
	.cfi_endproc
.LFE6:
	.size	loop_AoS, .-loop_AoS
	.section	.text.unlikely
.LCOLDE12:
	.text
.LHOTE12:
	.section	.text.unlikely
.LCOLDB13:
	.text
.LHOTB13:
	.p2align 4,,15
	.globl	loop_SoA
	.type	loop_SoA, @function
loop_SoA:
.LFB7:
	.cfi_startproc
	vmovaps	.LC0(%rip), %ymm4
	xorl	%eax, %eax
	vmovaps	.LC1(%rip), %ymm3
	.p2align 4,,10
	.p2align 3
.L32:
	vmovups	(%rdi,%rax), %xmm0
	vinsertf128	$0x1, 16(%rdi,%rax), %ymm0, %ymm0
	vmulps	%ymm0, %ymm0, %ymm2
	vdivps	%ymm0, %ymm4, %ymm1
	vmulps	%ymm0, %ymm2, %ymm0
	vaddps	%ymm0, %ymm1, %ymm0
	vdivps	%ymm2, %ymm3, %ymm2
	vaddps	%ymm2, %ymm0, %ymm0
	vmovups	%xmm0, (%rsi,%rax)
	vextractf128	$0x1, %ymm0, 16(%rsi,%rax)
	addq	$32, %rax
	cmpq	$200000000, %rax
	jne	.L32
	vzeroupper
	ret
	.cfi_endproc
.LFE7:
	.size	loop_SoA, .-loop_SoA
	.section	.text.unlikely
.LCOLDE13:
	.text
.LHOTE13:
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC0:
	.long	1092616192
	.long	1092616192
	.long	1092616192
	.long	1092616192
	.long	1092616192
	.long	1092616192
	.long	1092616192
	.long	1092616192
	.align 32
.LC1:
	.long	1120403456
	.long	1120403456
	.long	1120403456
	.long	1120403456
	.long	1120403456
	.long	1120403456
	.long	1120403456
	.long	1120403456
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC3:
	.long	1092616192
	.align 4
.LC4:
	.long	1120403456
	.section	.rodata.cst32
	.align 32
.LC6:
	.long	1101004800
	.long	1101004800
	.long	1101004800
	.long	1101004800
	.long	1101004800
	.long	1101004800
	.long	1101004800
	.long	1101004800
	.section	.rodata.cst4
	.align 4
.LC8:
	.long	1077936128
	.ident	"GCC: (GNU) 5.3.0"
	.section	.note.GNU-stack,"",@progbits
