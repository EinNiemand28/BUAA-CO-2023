.data
	arr:	.space	256
	str:	.asciiz	"The result is:"
	space:	.asciiz	" "
	enter:	.asciiz	"\n"

.macro end
	li		$v0, 10
	syscall
.end_macro

.macro readInt(%d)
	li		$v0, 5
	syscall
	move 	%d, $v0
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

.macro getIndex(%d, %m, %i, %j)
	mul		%d, %m, %i
	add		%d, %d, %j
	sll		%d, %d, 2
.end_macro

.text
main:
	readInt($s0)
	readInt($s1)
	li		$t0, 0
	loop_i_1:
		beq		$t0, $s0, end_loop_i_1
		li		$t1, 0
		loop_j_1:
			beq		$t1, $s1, end_loop_j_1
			getIndex($t2, $s1, $t0, $t1)
			readInt($t3)
			sw		$t3, arr($t2)
			addi	$t1, $t1, 1
			j		loop_j_1
		end_loop_j_1:
		addi	$t0, $t0, 1
		j		loop_i_1
	end_loop_i_1:
	li		$t0, 0
	loop_i_2:
		beq		$t0, $s0, end_loop_i_2
		li		$t1, 0
		loop_j_2:
			beq		$t1, $s1, end_loop_j_2
			getIndex($t2, $s1, $t0, $t1)
			readInt($t3)
			lw		$t4, arr($t2)
			add		$t4, $t4, $t3
			sw		$t4, arr($t2)
			addi	$t1, $t1, 1
			j		loop_j_2
		end_loop_j_2:
		addi	$t0, $t0, 1
		j		loop_i_2
	end_loop_i_2:
	li		$v0, 4
	la		$a0, str
	syscall
	printEnter()
	li		$t1, 0
	loop_j_3:
		beq		$t1, $s1, end_loop_j_3
		li		$t0, 0
		loop_i_3:
			beq		$t0, $s0, end_loop_i_3
			getIndex($t2, $s1, $t0, $t1)
			lw		$t2, arr($t2)
			printInt($t2)
			printSpace()
			addi	$t0, $t0, 1
			j		loop_i_3
		end_loop_i_3:
		printEnter()
		addi	$t1, $t1, 1
		j		loop_j_3
	end_loop_j_3:
	end