.data
	arr:	.space	4000
	space:	.asciiz	" "
	enter:	.asciiz	"\n"
	
.macro end
	li		$v0, 10
	syscall
.end_macro

.macro readInt(%d)
	li		$v0, 5
	syscall
	move	%d, $v0
.end_macro

.macro printInt(%d)
	li		$v0, 1
	move	$a0, %d
	syscall
.end_macro

.macro printEnter()
	li		$v0, 4
	la		$a0, enter
	syscall
.end_macro

.macro printSpace()
	li		$v0, 4
	la		$a0, space
	syscall
.end_macro

.text
main:
	readInt($s0)
	li		$s1, 1			# len = 1
	sw		$s1, arr($0)	# arr[0] = 1
	li		$t0, 2			# i
	li		$s2, 10			# const 10
	loop_i_1:
		bgt		$t0, $s0, end_loop_i_1
		li		$t1, 0		# j
		li		$t2, 0		# index of arr[]
		loop_j_1:
			beq		$t1, $s1, end_loop_j_1
			lw		$t3, arr($t2)
			mul		$t3, $t3, $t0
			sw		$t3, arr($t2)
			addi	$t2, $t2, 4
			addi	$t1, $t1, 1
			j		loop_j_1
		end_loop_j_1:
		li		$t1, 0
		li		$t2, 0
		while:
			if_1:
				lw		$t3, arr($t2)
				beqz	$t3, if_2
				j	else
			if_2:
				bge		$t1, $s1, end_while
			else:
			div		$t3, $s2
			mfhi	$t3
			sw		$t3, arr($t2)
			addi	$t2, $t2, 4
			lw		$t3, arr($t2)
			mflo	$t4
			add		$t3, $t3, $t4
			sw		$t3, arr($t2)
			addi	$t1, $t1, 1
			j		while
		end_while:
		move	$s1, $t1
		addi	$t0, $t0, 1
		j		loop_i_1
	end_loop_i_1:
	addi	$t0, $s1, -1
	sll		$t0, $t0, 2
	loop:
		lw		$t1, arr($t0)
		printInt($t1)
		beqz	$t0, end_loop
		addi	$t0, $t0, -4
		j		loop
	end_loop:
	end