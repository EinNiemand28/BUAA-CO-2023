.data
	array:	.space 20

.macro end
	li	$v0, 10
	syscall
.end_macro

.macro readInt(%d)
	li	$v0, 5
	syscall
	move %d, $v0
.end_macro

.macro readCh(%d)
	li	$v0, 12
	syscall
	move %d, $v0
.end_macro

.text
	readInt($s0)
	li	$t0, 0
	
loop1:
	beq	$t0, $s0, end_loop1
	readCh($t1)
	sb	$t1, array($t0)
	addi $t0, $t0, 1
	j	loop1
	
end_loop1:
	li	$t0, 0
	addi $t2, $s0, -1
loop2:
	beq $t0, $s0, end_loop2
	lb	$t1, array($t0)
	sub	$t3, $t2, $t0
	lb	$t3, array($t3)
	bne $t1, $t3, not_equal
	addi $t0, $t0, 1
	j	loop2
	
end_loop2:
	li	$a0, 1
	li	$v0, 1
	syscall
	end
	
not_equal:
	li	$a0, 0
	li	$v0, 1
	syscall
	end
	