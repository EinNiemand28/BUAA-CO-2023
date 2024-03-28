.data
	Map:	.space	196
	flag:	.space	196
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

.macro getIndex(%d, %m, %i, %j)
	mul		%d, %m, %i
	add		%d, %d, %j
	sll		%d, %d, 2
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

.macro check()
	push($a0)
	li		$t6, 0
	for_i:
		beq		$t6, $s0, end_for_i
		li		$t7, 0
		for_j:
			beq		$t7, $s1, end_for_j
			getIndex($t5, $s1, $t6, $t7)
			lw		$t5, flag($t5)
			printInt($t5)
			printSpace()
			addi	$t7, $t7, 1
			j		for_j
		end_for_j:
		printEnter()
		addi	$t6, $t6, 1
		j		for_i
	end_for_i:
	printEnter()
	pop($a0)
.end_macro
			

.text
main:
	readInt($s0)
	readInt($s1)
	li		$s2, 0
	li		$t0, 0
	loop_i_1:
		beq		$t0, $s0, end_loop_i_1
		li		$t1, 0
		loop_j_1:
			beq		$t1, $s1, end_loop_j_1
			getIndex($t2, $s1, $t0, $t1)
			readInt($t3)
			sw		$t3, Map($t2)
			addi	$t1, $t1, 1
			j		loop_j_1
		end_loop_j_1:
		addi	$t0, $t0, 1
		j		loop_i_1
	end_loop_i_1:
	readInt($t0)
	readInt($t1)
	readInt($s3)
	readInt($s4)
	addi	$t0, $t0, -1
	addi	$t1, $t1, -1
	addi	$s3, $s3, -1	#target_x
	addi	$s4, $s4, -1	#target_y
	getIndex($t2, $s1, $t0, $t1)
	move	$a0, $t0	# x
	move	$a1, $t1	# y
	li		$s5, 1		# const 1
	sw		$s5, flag($t2)
	jal		dfs
	printInt($s2)
	end
	
dfs:
	push($ra)
	push($t0)
	push($t1)
	move	$t0, $a0
	move	$t1, $a1
	bne		$t0, $s3, else_1
	bne		$t1, $s4, else_1
	if_1:
		add		$s2, $s2, 1
		pop($t1)
		pop($t0)
		pop($ra)
		jr		$ra
	else_1:
	addi	$t2, $t0, 1
	beq		$t2, $s0, else_2
	getIndex($t3, $s1, $t2, $t1)
	lw		$t4, Map($t3)
	bnez	$t4, else_2
	lw		$t4, flag($t3)
	bnez	$t4, else_2
	if_2:
		sw		$s5, flag($t3)
		move	$a0, $t2
		move	$a1, $t1
		jal		dfs
		addi	$t2, $t0, 1
		getIndex($t3, $s1, $t2, $t1)
		sw		$0, flag($t3)
	else_2:
	beqz	$t0, else_3
	addi	$t2, $t0, -1
	getIndex($t3, $s1, $t2, $t1)
	lw		$t4, Map($t3)
	bnez	$t4, else_3
	lw		$t4, flag($t3)
	bnez	$t4, else_3
	if_3:
		sw		$s5, flag($t3)
		move	$a0, $t2
		move	$a1, $t1
		jal		dfs
		addi	$t2, $t0, -1
		getIndex($t3, $s1, $t2, $t1)
		sw		$0, flag($t3)
	else_3:
	addi	$t2, $t1, 1
	beq		$t2, $s1, else_4
	getIndex($t3, $s1, $t0, $t2)
	lw		$t4, Map($t3)
	bnez	$t4, else_4
	lw		$t4, flag($t3)
	bnez	$t4, else_4
	if_4:
		sw		$s5, flag($t3)
		move	$a0, $t0
		move	$a1, $t2
		jal		dfs
		addi	$t2, $t1, 1
		getIndex($t3, $s1, $t0, $t2)
		sw		$0, flag($t3)
	else_4:
	beqz	$t1, else_5
	addi	$t2, $t1, -1
	getIndex($t3, $s1, $t0, $t2)
	lw		$t4, Map($t3)
	bnez	$t4, else_5
	lw		$t4, flag($t3)
	bnez	$t4, else_5
	if_5:
		sw		$s5, flag($t3)
		move	$a0, $t0
		move	$a1, $t2
		jal		dfs
		addi	$t2, $t1, -1
		getIndex($t3, $s1, $t0, $t2)
		sw		$0, flag($t3)
	else_5:
	pop($t1)
	pop($t0)
	pop($ra)
	jr		$ra
		
	
	