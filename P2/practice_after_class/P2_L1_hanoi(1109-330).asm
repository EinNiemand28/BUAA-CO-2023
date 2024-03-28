.data
	MOVE1:	.asciiz	"move disk "
	MOVE2:	.asciiz	" from "
	MOVE3:	.asciiz	" to "
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

.macro push(%d)
	sw		%d, 0($sp)
	addi	$sp, $sp, -4
.end_macro

.macro pop(%d)
	addi	$sp, $sp, 4
	lw		%d, 0($sp)
.end_macro

.macro Move_(%id, %from, %to)
	li		$v0, 4
	la		$a0, MOVE1
	syscall
	printInt(%id)
	li		$v0, 4
	la		$a0, MOVE2
	syscall
	li		$v0, 11
	move	$a0, %from
	syscall
	li		$v0, 4
	la		$a0, MOVE3
	syscall
	li		$v0, 11
	move	$a0, %to
	syscall
	printEnter()
.end_macro

.text
main:
	readInt($s0)
	move	$t0, $s0
	li		$t1, 'A'
	li		$t2, 'B'
	li		$t3, 'C'
	move	$s1, $t0
	move	$a1, $t1
	move	$a2, $t2
	move	$a3, $t3
	jal		hanoi
	end

hanoi:
	push($ra)
	push($t0)
	push($t1)
	push($t2)
	push($t3)
	
	move	$t0, $s1
	move	$t1, $a1
	move	$t2, $a2
	move	$t3, $a3
	bnez	$t0, else_1
	if_1:
		Move_($t0, $t1, $t2)
		Move_($t0, $t2, $t3)
		pop($t3)
		pop($t2)
		pop($t1)
		pop($t0)
		pop($ra)
		jr		$ra
	else_1:
	addi	$t4, $t0, -1
	move	$s1, $t4
	move	$a1, $t1
	move	$a2, $t2
	move	$a3, $t3
	jal		hanoi
	Move_($t0, $t1, $t2)
	addi	$t4, $t0, -1
	move	$s1, $t4
	move	$a1, $t3
	move	$a2, $t2
	move	$a3, $t1
	jal		hanoi
	Move_($t0, $t2, $t3)
	addi	$t4, $t0, -1
	move	$s1, $t4
	move	$a1, $t1
	move	$a2, $t2
	move	$a3, $t3
	jal		hanoi
	pop($t3)
	pop($t2)
	pop($t1)
	pop($t0)
	pop($ra)
	jr		$ra
	
	