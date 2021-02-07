# Write a recursive function get_min to return the smallest element in an array of words. 
# Call the function in your main program and pass it an array of 10 elements.

.data 
len:    	.word 10
list:		.word -4, 6, 7, -2, 1, 3, -9, 4, 2, -5 

.text 
main:		la $a1, list		# $a1 holds addresses of the list
		la $a2, len		# $a2 holds the adress of len(list)
		lw $t5, 0($a2)		# $t5 holds len(list)
		sll $a3, $t5, 2		# $a3 holds 4*len(list)
		add $t0, $zero, $zero	# $t0 = 4*i = 0 (initialize the index)
		addi $sp, $sp, -4	# updates stack pointer
		sw $t0, 0($sp)		# pushes i value to the stack
		jal get_min		# call get_min(list, len)
		li $v0, 1
		addi $a0, $v1, 0	# print function return
		syscall
		# finish program
		li $v0, 10 
		syscall
	
get_min:	lw $s0, 0($sp)		# $s0 = 4*i
		addi $s7, $a3, -4	# $s7 = 4*len(list) - 4
		lw $s5, 0($a2)		# $s5 holds len(list)
		ble $s5, $zero, ESCAPE	# if len(list) <= 0 return -1
		blt $s0, $s7, rec	# branch to rec if 4*i < 4*len(list) - 4
base:		add $s2, $s0, $a1	# s2 = addrs(list[i])
		lw $s1, 0($s2)		# $s1 = list[0]
		sw $s1, 0($sp)		# put return value onto stack
		jr $ra			# return to caller
rec:		addi $s0, $s0, 4	# update 4*i
		addi $sp, $sp, -4 	# update stack pointer
		sw $ra, 0($sp) 		# put $ra value onto stack 
		addi $sp, $sp, -4 	# update stack pointer
		sw $s0, 0($sp) 		# put 4*i on stack
		jal get_min 		# recursive cal
		lw $v0, 0($sp)		# pop return value from stack onto $v0
		addi $sp, $sp, 4	# update stack pointer
		lw $ra, 0($sp)		# pop return address value
		addi $sp, $sp, 4	# update stack pointe
		lw $s0, 0($sp)		# pops 4*i value of current call
		addi $sp, $sp, 4	# update stack pointer
		add $s2, $s0, $a1	# s2 = addrs(list[i])
		lw $s1, 0($s2)		# $s1 is current element value
		bge $s1, $v1, skip_min	# branch if current >= previous
		add $v1, $s1, $zero	# otherwise, updates return to new min
skip_min:	addi $sp, $sp, -4 	# push min result 
		sw $v1, 0($sp) 		# onto stack	
		jr $ra	
ESCAPE:		addi $v1, $zero, -1	# returns -1
		jr $ra
		
	