.data
	arrf:		.space	400
	arrh:		.space	400
	arrg:		.space	400
	space:		.asciiz	" "
	enter:		.asciiz	"\n"
	
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

.macro getIndex(%d, %n, %i, %j)
	mul		%d, %n, %i
	add		%d, %d, %j
	sll		%d, %d, 2
.end_macro

.text
main:
	readInt($s0)
	readInt($s1)
	readInt($s2)
	readInt($s3)
	li		$t0, 0
	loop_i_1:
		beq		$t0, $s0, end_loop_i_1
		li		$t1, 0
		loop_j_1:
			beq		$t1, $s1, end_loop_j_1
			getIndex($t2, $s1, $t0, $t1)
			readInt($t3)
			sw		$t3, arrf($t2)
			addi	$t1, $t1, 1
			j		loop_j_1
		end_loop_j_1:
		addi	$t0, $t0, 1
		j		loop_i_1
	end_loop_i_1:
	li		$t0, 0
	loop_i_2:
		beq		$t0, $s2, end_loop_i_2
		li		$t1, 0
		loop_j_2:
			beq		$t1, $s3, end_loop_j_2
			getIndex($t2, $s3, $t0, $t1)
			readInt($t3)
			sw		$t3, arrh($t2)
			addi	$t1, $t1, 1
			j		loop_j_2
		end_loop_j_2:
		addi	$t0, $t0, 1
		j		loop_i_2
	end_loop_i_2:
	move	$s6, $s1
	sub		$s0, $s0, $s2
	sub		$s1, $s1, $s3
	addi	$s0, $s0, 1
	addi	$s1, $s1, 1
	li		$t0, 0
	
	loop_i_3:
		beq		$t0, $s0, end_loop_i_3
		li		$t1, 0
		loop_j_3:
			beq		$t1, $s1, end_loop_j_3
			li		$t2, 0
			getIndex($s4, $s1, $t0, $t1)
			lw		$s5, arrg($s4)
			loop_k_1:
				beq		$t2, $s2, end_loop_k_1
				li		$t3, 0
				loop_l_1:
					beq		$t3, $s3, end_loop_l_1
					add		$t4, $t0, $t2
					add		$t5, $t1, $t3
					getIndex($t6, $s6, $t4, $t5)
					lw		$t6, arrf($t6)
					getIndex($t7, $s3, $t2, $t3)
					lw		$t7, arrh($t7)
					mult	$t6, $t7
					mflo	$t6
					add		$s5, $s5, $t6
					addi	$t3, $t3, 1
					j		loop_l_1
				end_loop_l_1:
				addi	$t2, $t2, 1
				j		loop_k_1
			end_loop_k_1:
			sw		$s5, arrg($s4)
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
			beq		$t1, $s1, end_loop_j_4
			getIndex($t2, $s1, $t0, $t1)
			lw		$t2, arrg($t2)
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
	