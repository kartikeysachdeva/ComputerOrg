# Complete below a program to find the maximum value in the array list which has len elements, 
# and return it in one of the return-value registers. 
.data 
len:    	.word 5 
list:		.word -4, 6, 7, -2, 1

.text 
main:		la $a1, list		# $a1 holds addresses of the list
		la $a2, len		# $a2 holds the adress of len(list)
		add $t0, $zero, $zero	# $t0 = 4*i = 0 (initialize the index)
		lw $t1, 0($a2)		# $t1 = len(list)
		ble $t1, $zero, ESCAPE	# returns -1 if len(list) <= 0
		sll $t5, $t1, 2		# $t5 = 4*$t1 = 4*len(list)
		lw $t2, 0($a1)		# $t2 is the current max of the list
LOOP:		bge $t0, $t5, END	# brach if i >= 4*len(list)
		add $t3, $a1, $t0	# $t3 holds addr(list[i])
		lw $t4, 0($t3)		# $t4 = current
		ble $t4, $t2, ELSE	# branch if current <= max
		add $t2, $t4, $zero	# otherwise, update $t2 to the new max
ELSE:		addi $t0, $t0, 4	# update i
		j LOOP			# branches back to the top
ESCAPE:		add $t2, $zero, -1	# returns -1
END:		add $v1, $t2, $zero	# returns by adding $t2 into $v1
		li $v0, 1
		addi $a0, $v1, 0	# print result
		syscall
	