# Write a function get_n that takes n as an argument, 
# and returns the n-th word of global array list which has len words. 
# Also write code at label main to call get_n function. 
# If n is less than 1 or bigger than len, your function should return -1.

.data 
len:    .word 5
list:	.word -4, 6, 7, -2, 1 

.text 
main:		la $a1, list		# $a1 holds addresses of the list
		la $a2, len		# $a2 holds the adress of len(list)
		addi $a3, $zero, 2	# n = 2
		jal get_n		# call get_n(list, len, n)
		li $v0, 1
		addi $a0, $v1, 0	# print function return
		syscall
		# finish program
		li $v0, 10 
		syscall
	
get_n:		lw $s1, 0($a2)		# $s1 = len(list)
		add $s0, $zero, $zero	# $s0 = i = 0 (initialize the index)
		ble $a2, $zero, END	# returns -1 if len <= 0
LOOP:		bge $s0, $s1, END	# branch if i >= len(list)
		addi $s7, $zero, 1	# $s7 = 1
		blt $a3, $s7, END	# branch if n < 1
		sll $s5, $s0, 2		# $s5 = 4*s0 = 4*i
		addi $s4, $a3, -1	# n = index + 1
		beq $s0, $s4, EXIT	# branch if i+1 = n
		addi $s0, $s0, 1    	# i++ 
		j LOOP			# branches back to the top
END:		addi $v1, $zero, -1	# return -1
		jr $ra
EXIT:		add $s3, $a1, $s5	# $s3 holds addr(list[i])
		lw $s2, 0($s3)		# $s2 = n-th element
		add $v1, $s2, $zero	# returns by adding $s2 into $v0
		jr $ra

	