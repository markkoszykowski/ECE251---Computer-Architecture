/* -- Final Project -- */
.data

/* How much space to allocate for scratch array */
.balign 4
scratch: .skip 12

/* How much space to allcate for Reverse Polish Notation array */
.balign 4
rpn: .skip 40

/* Format for printf to print the solution */
.balign 4
answerformat: .asciz "%lf\n"

.text

.global main

main:
	push {r4, r5, r6, r7, lr} // Push the values of r0-r7 and lr onto the stack
	ldr r4, [r1, #4] // r4 <- argv[1]
	mov r1, #69 // r1 <- 'E'
	push {r1} // Push r1 onto stack
	mov r2, #0 // r2 <- #0
	mov r3, #0 // r3 <- #0
loop1:
	ldrb r0, [r4, +r2] // r0 <- *(r4 + r2)
	cmp r0, #48 // Compare r0 and '0'
	beq transfer // If equal branch to transfer
	cmp r0, #49 // Compare r0 to '1'
	beq transfer // If equal branch to transfer
	cmp r0, #50 // Compare r0 to '2'
	beq transfer // If equal branch to transfer
	cmp r0, #51 // Compare r0 to '3'
	beq transfer // If equal branch to transfer
	cmp r0, #52 // Compare r0 to '4'
	beq transfer // If equal branch to transfer
	cmp r0, #53 // Compare r0 to '5'
	beq transfer // If equal branch to transfer
	cmp r0, #54 // Compare r0 to '6'
	beq transfer // If equal branch to transfer
	cmp r0, #55 // Compare r0 to '7'
	beq transfer // If equal branch to transfer
	cmp r0, #56 // Compare r0 to '8'
	beq transfer // If equal branch to transfer
	cmp r0, #57 // Compare r0 to '9'
	beq transfer // If equal branch to transfer
	cmp r0, #46 // Compare r0 to '.'
	beq transfer // If equal branch to transfer
	cmp r0, #123 // Compare r0 to '{'
	beq cpar // If equal branch to cpar
	cmp r0, #125 // Compare r0 to '}'
	beq opar // If equal branch to opar
	cmp r0, #0 // Compare r0 to NULL
	beq finalcopy // If equal branch to finalcopy
	b operator // Branch to operator
transfer:
	ldr r5, address_of_rpn // r5 <- &address_of_rpn
	strb r0, [r5, +r3] // *(r5 + r3) <- r0
	add r2, r2, #1 // r2 = r2 + #1
	add r3, r3, #1 // r3 = r3 + #1
	b loop1 // Branch to loop1
cpar:
	push {r0} // Push value of r0 onto the stack
	add r2, r2, #1 // r2 = r2 + #1
	b loop1 // Branch to loop1
opar:
	pop {r0} // Pop value from top of stack to r0
	cmp r0, #123 // Compare r0 to '}'
	beq reachedclosed // If equal branch to reachedclosed
	ldr r5, address_of_rpn // r5 <- &address_of_rpn
	bl checknum // Branch with a link to checknum
	strb r0, [r5, +r3] // *(r5 + r3) <- r0
	add r3, r3, #1 // r3 = r3 + #1
	b opar // Branch to opar
reachedclosed:
	add r2, r2, #1 // r2 = r2 + #1
	b loop1 // Branch to loop1
operator:
	bl checknum // Branch with a link to checknum
	pop {r1} // Pop value from top of stack to r1
	cmp r1, #69 // Compare r1 to 'E'
	beq emptystack // If equal branch to emptystack
	b precendence // Branch to precendence
precendence:
	cmp r1, #123 // Compare r1 to '{'
	beq emptystack // If equal branch to emptystack
	cmp r0, #43 // Compare r0 to '+'
	beq takeoff // If equal branch to takeoff
	cmp r0, #45 // Compare r0 to '-'
	beq takeoff // If equal branch to takeoff
	cmp r0, #42 // Compare r0 to '*'
	beq checkstack // If equal branch to checkstack
	cmp r0, #47 // Compare r0 to '/'
	beq checkstack // If equal branch to checkstack
takeoff:
	ldr r5, address_of_rpn // r5 <- &address_of_rpn
	bl checknum // Branch with a link to checknum
	strb r1, [r5, +r3] // *(r5 + r3) <- r1
	add r3, r3, #1 // r3 = r3 + #1
	b operator // Branch to operator
checkstack:
	cmp r1, #47 // Compare r1 to '/'
	beq takeoff // If equal branch to takeoff
	cmp r1, #42 // Compare r1 to '*'
	beq takeoff // If equal branch to takeoff
	b emptystack // Branch to emptystack
emptystack:
	push {r1} // Push value of r1 onto stack
	push {r0} // Push value of r0 onto stack
	add r2, r2, #1 // r2 = r2 + #1
	b loop1 // Branch to loop1
checknum:
	push {lr} // Push the value of lr onto stack
	sub r3, r3, #1 // r3 = r3 - #1
	ldrb r6, [r5, +r3] // r6 <- *(r5 + r3)
	cmp r6, #48 // Compare r6 to '0'
	bleq addspace // If equal branch with a link to addspace
	cmp r6, #49 // Compare r6 to '1'
	bleq addspace // If equal branch with a link to addspace
	cmp r6, #50 // Compare r6 to '2'
	bleq addspace // If equal branch with a link to addspace
	cmp r6, #51 // Compare r6 to '3'
	bleq addspace // If equal branch with a link to addspace
	cmp r6, #52 // Compare r6 to '4'
	bleq addspace // If equal branch with a link to addspace
	cmp r6, #53 // Compare r6 to '5'
	bleq addspace // If equal branch with a link to addspace
	cmp r6, #54 // Compare r6 to '6'
	bleq addspace // If equal branch with a link to addspace
	cmp r6,	#55 // Compare r6 to '7'
	bleq addspace // If equal branch with a link to addspace
	cmp r6, #56 // Compare r6 to '8'
	bleq addspace // If equal branch with a link to addspace
	cmp r6, #57 // Compare r6 to '9'
	bleq addspace // If equal branch with a link to addspace
	add r3, r3, #1 // r3 = r3 + #1
	pop {lr} // Pop value from top of stack to lr
	bx lr // Branch back to where came from
addspace:
	add r3, r3, #1 // r3 = r3 + #1
	mov r6, #32 // r6 <- ' '
	strb r6, [r5, +r3] // *(r5 + r3) <- r6
	bx lr // Branch back to where came from
finalcopy:
	pop {r0} // Pop value from top of stack to r0
	cmp r0, #69 // Compare r0 to 'E'
	beq init // If equal branch to init
	ldr r5, address_of_rpn // r5 <- &address_of_rpn
	bl checknum // Branch with a link to checknum
	strb r0, [r5, +r3] // *(r5 + r3) <- r0
	add r3, r3, #1 // r3 = r3 + #1
	b finalcopy // Branch to finalcopy
init:
	mov r0, #0 // r0 <- NULL
	ldr r5, address_of_rpn // r5 <- &address_of_rpn
	strb r0, [r5, +r3] // *(r5 + r3) <- r0
	mov r2, #0 // r2 <- #0
	mov r4, #0 // r4 <- #0
loop2:
	ldr r1, address_of_rpn // r1 <- &address_of_rpn
	ldrb r3, [r1, +r2] // r3 <- *(r1 + r2)
	cmp r3, #48 // Compare r3 to '0'
	beq mvscratch // If equal branch to mvscratch
	cmp r3, #49 // Compare r3 to '1'
	beq mvscratch // If equal branch to mvscratch
	cmp r3, #50 // Compare r3 to '2'
	beq mvscratch // If equal branch to mvscratch
	cmp r3, #51 // Compare r3 to '3'
	beq mvscratch // If equal branch to mvscratch
	cmp r3, #52 // Compare r3 to '4'
	beq mvscratch // If equal branch to mvscratch
	cmp r3, #53 // Compare r3 to '5'
	beq mvscratch // If equal branch to mvscratch
	cmp r3, #54 // Compare r3 to '6'
	beq mvscratch // If equal branch to mvscratch
	cmp r3, #55 // Compare r3 to '7'
	beq mvscratch // If equal branch to mvscratch
	cmp r3, #56 // Compare r3 to '8'
	beq mvscratch // If equal branch to mvscratch
	cmp r3, #57 // Compare r3 to '9'
	beq mvscratch // If equal branch to mvscratch
	cmp r3, #46 // Compare r3 to '.'
	beq mvscratch // If equal branch to mvscratch
	cmp r3, #0 // Compare r3 to NULL
	beq end // If equal branch to end
	cmp r3, #32 // Compare r3 to ' '
	beq convert // If equal branch to convert
	cmp r3, #42 // Compare r3 to '*'
	beq multiply // If equal branch to multiply
	cmp r3, #43 // Compare r3 to '+'
	beq addition // If equal branch to addition
	cmp r3, #45 // Compare r3 to '-'
	beq subtraction // If equal branch to subtraction
	cmp r3, #47 // Compare r3 to '/'
	beq division // If equal branch to division
	add r2, r2, #1 // r2 = r2 + #1
	b loop2 // Branch to loop2
mvscratch:
	ldr r5, address_of_scratch // r5 <- &address_of_scratch
	strb r3, [r5, +r4] // *(r5 + r3) <- r3
	add r4, r4, #1 // r4 = r4 + #1
	add r2, r2, #1 // r2 = r2 + #1
	b loop2 // Branch to loop2
convert:
	ldr r5, address_of_scratch // r5 <- &address_of_scratch
	mov r3, #0 // r3 <- NULL
	strb r3, [r5, +r4] // *(r5 + r3) <- r3
	mov r6, r2 // r6 <- r2
	ldr r0, address_of_scratch // r0 <- &address_of_scratch
	bl atof // Branch with a link to external function atof
	vpush {d0} // Push value of d0 onto the stack
	mov r2, r6 // r2 <- r6
	mov r4, #0 // r4 <- #0
	add r2, r2, #1 // r2 = r2 + 1
	b loop2 // Branch to loop2
multiply:
	vpop {d4} // Pop value from top of stack to d4
	vpop {d5} // Pop value from top of stack to d5
	vmul.f64 d4, d4, d5 // d4 = d4 * d5
	vpush {d4} // Push value of d4 onto the stack
	add r2, r2, #1 // r2 = r2 + #1
	b loop2 // Branch to loop2
addition:
	vpop {d4} // Pop value from top of stack to d4
	vpop {d5} // Pop value from top of stack to d5
	vadd.f64 d4, d4, d5 // d4 = d4 + d5
	vpush {d4} // Push value of d4 onto the stack
	add r2, r2, #1 // r2 = r2 + #1
	b loop2 // Branch to loop2
subtraction:
	vpop {d4} // Pop value from top of stack to d4
	vpop {d5} // Pop value from top of stack to d5
	vsub.f64 d4, d5, d4 // d4 = d5 - d4
	vpush {d4} // Push value of d4 onto the stack
	add r2, r2, #1 // r2 = r2 + #1
	b loop2 // Branch to loop2
division:
	vpop {d4} // Pop value from top of stack to d4
	vpop {d5} // Pop value from top of stack to d5
	vdiv.f64 d4, d5, d4 // d4= d5 / d4
	vpush {d4} // Push value of d4 onto the stack
	add r2, r2, #1 // r2 = r2 + #1
	b loop2 // Branch to loop2
end:
	vpop {d4} // Pop value from top of stack to d4
	vmov r3, r2, d4 // r2 & r3 <- d4
	ldr r0, address_of_answerformat // r0 <- &address_of_answerformat
	bl printf // Branch with a link to external function printf
	pop {r4, r5, r6, r7, lr} // Pop values from top of stack to r4-r7 and lr
	bx lr

address_of_rpn: .word rpn
address_of_answerformat: .word answerformat
address_of_scratch: .word scratch
