.data
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

.macro pow3(%d)
	move	$a0, %d
	mul		%d, %d, $a0
	mul		%d, %d, $a0
.end_macro

.text
main:
	readInt($s0)
	readInt($s1)
	li		$s2, 9
	li		$t0, 1
	loop_i_1:
		beq		$t0, $s2, end_loop_i_1
		li		$t1, 0
		loop_j_1:
			beq		$t1, $s2, end_loop_j_1
			li		$t2, 0
			loop_k_1:
				beq		$t2, $s2, end_loop_k_1
				sll		$t3, $t0, 1
				sll		$t4, $t0, 3
				add		$t3, $t3, $t4
				add		$t3, $t3, $t1
				sll		$t4, $t3, 1
				sll		$t3, $t3, 3
				add		$t3, $t3, $t4
				add		$t3, $t3, $t2
				blt		$t3, $s0, else_1
				bge		$t3, $s1, end_loop_i_1
				if_1:
					li		$t4, 0
					move	$t5, $t0
					pow3($t5)
					add		$t4, $t4, $t5
					move	$t5, $t1
					pow3($t5)
					add		$t4, $t4, $t5
					move	$t5, $t2
					pow3($t5)
					add		$t4, $t4, $t5
					bne		$t4, $t3, else_1
					printInt($t3)
					printEnter()
				else_1:
				addi	$t2, $t2, 1
				j		loop_k_1
			end_loop_k_1:
			addi	$t1, $t1, 1
			j		loop_j_1
		end_loop_j_1:
		addi	$t0, $t0, 1
		j		loop_i_1
	end_loop_i_1:
	end
