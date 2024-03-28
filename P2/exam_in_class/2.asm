.data
	space:	.asciiz	" "
	enter:	.asciiz	"\n"
	st:		.space	256
	ast:	.space	256
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

.macro push(%d)
	sw		%d, 0($sp)
	addi	$sp, $sp, -4
.end_macro

.macro pop(%d)
	addi	$sp, $sp, 4
	lw		%d, 0($sp)
.end_macro

.macro printSpace()
	li		$v0, 4
	la		$a0, space
	syscall
.end_macro

.macro printEnter()
	li		$v0, 4
	la		$a0, enter
	syscall
.end_macro

.text
main:
	readInt($s0)
	li		$t0, 0
	loop_i_1:
		beq		$t0, $s0, end_loop_i_1
		readInt($t1)
		sll		$t2, $t0, 2
		sw		$t1, ast($t2)
		addi	$t0, $t0, 1
		j		loop_i_1
	end_loop_i_1:
	li		$s1, 0	# pos
	li		$t0, 0
	li		$s2, 0	# returnSize
	loop_i_2:
		beq		$t0, $s0, end_loop_i_2
		li		$t1, 1	# alive
		sll		$t2, $t0, 2
		lw		$t2, ast($t2)	# ast[i]
		sub		$t5, $0, $t2
		while:
			beqz	$t1, end_while
			bgez	$t2, end_while
			blez	$s1, end_while
			addi	$t3, $s1, -1
			sll		$t3, $t3, 2
			lw		$t3, st($t3)
			blez	$t3, end_while
			slt		$t1, $t3, $t5
			if_1:
				bgt		$t3, $t5, else_1
				addi	$s1, $s1, -1
			else_1:
			j		while
		end_while:
		if_2:
			beqz	$t1, else_2
			sll		$t4, $s1, 2
			sw		$t2, st($t4)
			addi	$s1, $s1, 1
		else_2:
		addi	$t0, $t0, 1
		j		loop_i_2
	end_loop_i_2:
	printInt($s1)
	printEnter()
	li		$t0, 0
	loop_i_3:
		beq		$t0, $s1, end_loop_i_3
		sll		$t1, $t0, 2
		lw		$t1, st($t1)
		printInt($t1)
		printSpace()
		addi	$t0, $t0, 1
		j		loop_i_3
	end_loop_i_3:
	end
