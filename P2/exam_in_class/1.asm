.data
	space:	.asciiz	" "
	enter:	.asciiz	"\n"
	arr1:	.space	256
	arr2:	.space	256
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
		sw		$t1, arr1($t2)
		addi	$t0, $t0, 1
		j		loop_i_1
	end_loop_i_1:
	li		$t0, 0
	readInt($s1)
	loop_i_2:
		beq		$t0, $s1, end_loop_i_2
		readInt($t1)
		sll		$t2, $t0, 2
		sw		$t1, arr2($t2)
		addi	$t0, $t0, 1
		j		loop_i_2
	end_loop_i_2:
	add		$s2, $s0, $s1
	li		$t0, 0	# index of arr1
	li		$t1, 0	# index of arr2
	li		$t2, 0	# i
	loop_i_3:
		beq		$t2, $s2, end_loop_i_3
		beq		$t0, $s0, case_1
		beq		$t1, $s1, case_2
		j		case_3
		case_1:
			sll		$t3, $t1, 2
			lw		$t3, arr2($t3)
			printInt($t3)
			printSpace()
			addi	$t1, $t1, 1
			addi	$t2, $t2, 1
			j		loop_i_3
		case_2:
			sll		$t3, $t0, 2
			lw		$t3, arr1($t3)
			printInt($t3)
			printSpace()
			addi	$t0, $t0, 1
			addi	$t2, $t2, 1
			j		loop_i_3
		case_3:
			sll		$t3, $t0, 2
			lw		$t3, arr1($t3)
			sll		$t4, $t1, 2
			lw		$t4, arr2($t4)
			bgt		$t3, $t4, else_1
			if_1:
				printInt($t3)
				printSpace()
				addi	$t0, $t0, 1
				addi	$t2, $t2, 1
				j		loop_i_3
			else_1:
				printInt($t4)
				printSpace()
				addi	$t1, $t1, 1
				addi	$t2, $t2, 1
				j		loop_i_3
	end_loop_i_3:
	end