/* -- project2.s */
.data

/* Name of unsorted file */
.balign 4
ufile: .asciz "unsorted.txt"

/*Name of sorted file */
.balign 4
sfile: .asciz "sorted.txt"

/* File reading mode for fopen */
.balign 4
readmode: .asciz "r"

/* File writing mode for fopen */
.balign 4
writemode: .asciz "w"

/* How much space to allocate for scratch string */
.balign 4
str: .skip 12

/* How much space to allocate for integer array */
.balign 4
array: .skip 400

/* Format for sprintf to perform itoa conversion */
.balign 4
format: .asciz "%d\n"

.text

.global main
main:
	push {r4, r5, r6, r8, r9, lr} // push r4-r9, lr onto stack
	subs sp, sp, #4 // sp = sp - #4
	ldr r0, address_of_ufile // r0 <- &address_of_ufile
	ldr r1, address_of_rmode // r1 <- &address_of_rmode
	bl fopen // Branch and link to fopen
	str r0, [sp] // *sp <- r0
	mov r4, #0 // r4 <- #0 (arraylen = 0)
readloop:
	ldr r0, address_of_str // r0 <- &address_of_str
	mov r1, #10 // r1 <- #10
	ldr r2, [sp] // r2 <- *sp
	bl fgets // Branch and link to fgets
	cmp r0, #0 // Compare str to NULL
	beq init // If r0 = NULL, branch to init
	bl atoi // Branch and link to atoi
	ldr r1, address_of_array // r1 <- &address_of_array
	str r0, [r1, +r4, lsl #2] // *(r1 + (r4 * #4)) <- r0
	add r4, r4, #1 // r4 <- r4 + #1
	b readloop // Branch to readloop
init:
	sub r4, r4, #1 // r4 <- r4 - #1
	ldr r0, address_of_array // r0 <- &address_of_array
	mov r1, #0 // r1 <- #0 (i = 0)
	mov r2, #0 // r2 <- #0 (num = 0)
loop1:
	cmp r1, r4 // Compare r1 to r4
	bge sortedfile // If r1 > r4, branch to sortedfile
	mov r5, #0 // r5 <- #0 (j = 0)
	sub r3, r4, r1 // r3 <- r4 - r1
	b loop3 // Branch to loop3
loop2:
	add r1, r1, #1 // r1 <- r1 + #1
	cmp r2, #0 // Compare r2 to #0
	beq sortedfile // If r2 = #0, branch to sortedfile
	b loop1 // Branch to loop1
loop3:
	cmp r5, r3 // Compare r5 and r3
	bge loop2 // If r5 > r3, branch to loop2
	add r6, r5, #1 // r6 <- r5 + #1
	ldr r8, [r0, +r5, lsl #2] // r8 <- *(r0 + (r5 * #4))
	ldr r9, [r0, +r6, lsl #2] // r9 <- *(r0 + (r6 * #4))
	cmp r8, r9 // Compare r8 and r9
	bgt swap // If r8 > r9, branch to swap
	add r5, r5, #1 // r5 <- r5 + #1
	b loop3 // Branch to loop3
swap:
	str r9, [r0, +r5, lsl #2] // *(r0 + (r5 * #4)) <- r9
	str r8, [r0, +r6, lsl #2] // *(r0 + (r6 * #4)) <- r8
	add r2, r2, #1 // r2 <- r2 + #1
	add r5, r5, #1 // r5 <- r5 + #1
	b loop3 // Branch to loop3
sortedfile:
	ldr r0, address_of_sfile // r0 <- &address_of_sfile
	ldr r1, address_of_wmode // r1 <- &address_of_wmode
	bl fopen // Branch and link to fopen
	str r0, [sp] // *sp <- r0
	mov r5, #0 // r5 <- #0
writeloop:
	ldr r0, address_of_array // r0 <- &address_of_array
	ldr r2, [r0, +r5, lsl #2] // r2 <- *(r0 + (r5 * #4))
	ldr r1, address_of_format // r1 <- &address_of_format
	ldr r0, address_of_str // r0 <- &address_of_str
	bl sprintf // Branch and link to sprintf
	ldr r0, address_of_str // r0 <- &address_of_str
	ldr r1, [sp] // r1 <- *sp
	bl fputs // Branch and link to fputs
	cmp r5, r4 // Compare r5 and r4
	beq end // If r5 = r4, branch to end
	add r5, r5, #1 // r5 <- r5 + #1
	b writeloop // branch to writeloop
end:
	adds sp, sp, #4 // sp <- sp + #4
	pop {r4, r5, r6, r8, r9, lr} // pop r4-r9, lr off the stack
	bx lr

address_of_sfile: .word sfile
address_of_rmode: .word readmode
address_of_str: .word str
address_of_array: .word array
address_of_ufile: .word ufile
address_of_wmode: .word writemode
address_of_format: .word format
