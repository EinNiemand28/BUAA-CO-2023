.data
	arr1:	.space	256
	arr2:	.space	256
	arr3:	.space	256
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

.macro getIndex(%n, %d, %i, %j)
	mul		%d, %i, %n
	add		%d, %d, %j
	sll		%d, %d, 2
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
	li		$t0, 0
	loop_i_1:
		beq		$t0, $s0, end_loop_i_1
		li		$t1, 0
		loop_j_1:
			beq		$t1, $s0, end_loop_j_1
			getIndex($s0, $t2, $t0, $t1)
			li		$v0, 5
			syscall
			sw		$v0, arr1($t2)
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
			beq		$t1, $s0, end_loop_j_2
			getIndex($s0, $t2, $t0, $t1)
			li		$v0, 5
			syscall
			sw		$v0, arr2($t2)
			addi	$t1, $t1, 1
			j		loop_j_2
		end_loop_j_2:
		addi	$t0, $t0, 1
		j		loop_i_2
	end_loop_i_2:
	
	li		$t0, 0
	loop_i_3:
		beq		$t0, $s0, end_loop_i_3
		li		$t1, 0
		loop_j_3:
			beq		$t1, $s0, end_loop_j_3
			getIndex($s0, $t5, $t0, $t1)
			lw		$t5, arr3($t5)
			li		$t2, 0
			loop_k_1:
				beq		$t2, $s0, end_loop_k_1
				getIndex($s0, $t3, $t0, $t2)
				getIndex($s0, $t4, $t2, $t1)
				lw		$t3, arr1($t3)
				lw		$t4, arr2($t4)
				mult	$t3, $t4
				mflo	$t3
				add		$t5, $t5, $t3
				addi	$t2, $t2, 1
				j		loop_k_1
			end_loop_k_1:
			getIndex($s0, $t3, $t0, $t1)
			sw		$t5, arr3($t3)
			addi	$t1, $t1, 1
			j		loop_j_3
		end_loop_j_3:
		addi	$t0, $t0, 1
		j		loop_i_3			
	end_loop_i_3:
	
	li		$t0, 0
	loop_i_4:
		beq		$t0, $s0, end_loop_i_4
		li		$t1, 0
		loop_j_4:
			beq		$t1, $s0, end_loop_j_4
			getIndex($s0, $t2, $t0, $t1)
			lw		$t2, arr3($t2)
			printInt($t2)
			printSpace()
			addi	$t1, $t1, 1
			j		loop_j_4
		end_loop_j_4:
		printEnter()
		addi	$t0, $t0, 1
		j		loop_i_4
	end_loop_i_4:
	end
	
		