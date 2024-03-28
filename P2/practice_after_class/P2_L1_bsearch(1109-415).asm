.data
	arr:	.space 4000
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

.text
main:
	readInt($s0)
	li		$t0, 0
	loop_i_1:
		beq		$t0, $s0, end_loop_i_1
		sll		$t1, $t0, 2
		readInt($t2)
		sw		$t2, arr($t1)
		addi	$t0, $t0, 1
		j		loop_i_1
	end_loop_i_1:
	readInt($s1)
	li		$t0, 0
	loop_i_2:
		beq		$t0, $s1, end_loop_i_2
		readInt($s2)
		jal		binary_search
		addi	$t0, $t0, 1
		j		loop_i_2
	end_loop_i_2:
	end

binary_search:
	li		$t2, 0
	li		$s3, 0
	addi	$t3, $s0, -1
	# t2 low t3 high t4 mid
	while:
		bgt		$t2, $t3, end_while
		add		$t4, $t2, $t3
		srl		$t4, $t4, 1
		sll		$t1, $t4, 2
		lw		$t1, arr($t1)
		blt		$s2, $t1, if_1
		bgt		$s2, $t1, else_if_1
		else_1:
			li		$a0, 1
			li		$v0, 1
			syscall
			printEnter()
			li		$s3, 1
			j		end_while
		if_1:
			addi	$t3, $t4, -1
			j		while
		else_if_1:
			addi	$t2, $t4, 1
			j		while
	end_while:
	bnez	$s3, else_2
	if_2:
		printInt($0)
		printEnter()
	else_2:
	jr		$ra
	