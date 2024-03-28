.data
	array:	.space 104
	flag:	.space 104
	temp:	.space 4
	tot:	.word 26
	space:	.asciiz " "
	enter:	.asciiz "\n"
	
.text
	li	$v0, 5
	syscall
	move $s0, $v0
	lw	$s1, tot
	li	$t0, 0
	
loop1:
	beq	$t0, $s0, end_loop1
	li	$v0, 8
	la	$a0, temp
	li	$a1, 4
	syscall
	lw	$t1, temp
	andi $t2, $t1, 0xff
	addi $t2, $t2, -97
	sll $t3, $t2, 2
	lw	$t1, array($t3)
	bnez $t1, is_flag
	sll $t3, $s2, 2
	sw	$t2, flag($t3)
	addi $s2, $s2 ,1
	
is_flag:
	addi $t1, $t1, 1
	sll $t3, $t2, 2
	sw	$t1, array($t3)
	addi $t0, $t0, 1
	j	loop1
	
end_loop1:
	li	$t0, 0
	
loop2:
	beq	$t0, $s2, end_loop2
	sll	$t1, $t0, 2
	lw	$t2, flag($t1)
	addi $a0, $t2, 97
	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
	li	$v0, 1
	sll $t2, $t2, 2
	lw	$a0, array($t2)
	syscall
	li	$v0, 4
	la	$a0, enter
	syscall
	addi $t0, $t0, 1
	j	loop2
	
end_loop2:	
	li	$v0, 10
	syscall
