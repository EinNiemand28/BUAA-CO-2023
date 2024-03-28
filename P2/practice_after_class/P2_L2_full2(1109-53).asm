.data
	symbol:	.space	28
	array:	.space	28
	enter:	.asciiz	"\n"
	space:	.asciiz	" "
	
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

.macro push(%d)
	sw		%d, 0($sp)
	addi	$sp, $sp, -4
.end_macro

.macro pop(%d)
	addi	$sp, $sp, 4
	lw		%d, 0($sp)
.end_macro

.text
main:
	readInt($s0)
	li		$s1, 1
	li		$t0, 0	# index
	li		$t1, 0	# i
	move	$a0, $t0
	jal		FullArray
	end
	
FullArray:
	push($ra)
	push($t0)
	push($t1)
	
	li		$t1, 0
	move	$t0, $a0
	blt		$t0, $s0, else_1
	if_1:
		loop_i_1:
			beq		$t1, $s0, end_loop_i_1
			sll		$t2, $t1, 2
			lw		$t2, array($t2)
			printInt($t2)
			printSpace()
			addi	$t1, $t1, 1
			j		loop_i_1
		end_loop_i_1:
		printEnter()
		pop($t1)
		pop($t0)
		pop($ra)
		jr		$ra
	else_1:
	move	$t1, $s0
	loop_i_2:
		beqz	$t1, end_loop_i_2
		sll		$t2, $t1, 2
		lw		$t3, symbol($t2)
		bnez	$t3, else_2
		if_2:
			sll		$t3, $t0, 2
			sw		$t1, array($t3)
			sw		$s1, symbol($t2)
			addi	$a0, $t0, 1
			jal		FullArray
			sll		$t2, $t1, 2
			sw		$0, symbol($t2)
		else_2:
		addi	$t1, $t1, -1
		j		loop_i_2
	end_loop_i_2:
	pop($t1)
	pop($t0)
	pop($ra)
	jr		$ra