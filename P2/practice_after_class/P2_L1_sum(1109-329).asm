.macro end
	li	$v0, 10
	syscall
.end_macro

.macro readInt(%d)
	li	$v0, 5
	syscall
	move %d, $v0
.end_macro

.macro printuInt(%d)
	li	$v0, 36
	move $a0, %d
	syscall
.end_macro

.text
	readInt($s0)
	li	$t0, 1
	li	$t1, 1
	li	$t2, 0
	
loop1:
	bgt	$t0, $s0, end_loop1
	multu $t1, $t0
	mflo $t1
	addu $t2, $t2, $t1
	addi $t0, $t0, 1
	j	loop1
	
end_loop1:
	printuInt($t2)
	end
	
	