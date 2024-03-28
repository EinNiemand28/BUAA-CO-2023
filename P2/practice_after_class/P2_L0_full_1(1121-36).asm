.data
	array:	.space	28
	symbol:	.space	28
	space:	.asciiz	" "
	enter:	.asciiz "\n"
	
.macro end
	li	$v0, 10
	syscall
.end_macro

.macro readInt(%d)
	li	$v0, 5
	syscall
	move %d, $v0
.end_macro

.macro printInt(%d)
	li	$v0, 1
	move $a0, %d
	syscall
.end_macro

.macro printEnter()
	la	$a0, enter
	li	$v0, 4
	syscall
.end_macro

.macro printSpace()
	la	$a0, space
	li	$v0, 4
	syscall
.end_macro

.macro push(%d)
	sw	%d, 0($sp)
	addi $sp, $sp, -4
.end_macro

.macro pop(%d)
	addi $sp, $sp, 4
	lw	%d, 0($sp)
.end_macro

.text
main:
	readInt($s0)
	li	$t0, 0
	li	$t1, 0
	li	$a0, 0 # index
	jal	FullArray
	end
	
	
FullArray:
	push($ra)
	push($t0)
	push($t1)
	
	move $t0, $a0 # index
	li	$t1, 0 # i
	blt	$t0, $s0, else1
	if1:
		loop1:
			beq	$t1, $s0, end_loop1
			sll	$t2, $t1, 2
			lw	$t2, array($t2) # array[i]
			printInt($t2)
			printSpace()
			addi $t1, $t1, 1
			j	loop1
		end_loop1:
		printEnter()
		pop($t1)
		pop($t0)
		pop($ra)
		jr	$ra # return
	else1:
	li	$t1, 0
	loop2:
		beq $t1, $s0, end_loop2 # t1:i
		sll	$t2, $t1, 2
		lw	$t3, symbol($t2) # symbol[i]
		bnez $t3, else2
		if2:
			sll	$t3, $t0, 2 # index
			addi $t4, $t1, 1
			sw	$t4, array($t3) # array[index] = i + 1
			li	$t3,1 
			sw	$t3, symbol($t2) # symbol[i] = 1
			addi $a0, $t0, 1 # new index
			jal	FullArray
			li	$t3, 0
			sll	$t2, $t1, 2 # remember to reset
			sw	$t3, symbol($t2) # symbol[i] = 0
		else2:
		addi $t1, $t1, 1
		j	loop2
	end_loop2:
	pop($t1)
	pop($t0)
	pop($ra)
	jr	$ra
	
