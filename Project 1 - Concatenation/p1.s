/* -- project1.s */
.data

/* Frist string message */
.balign 4
message1: .asciz "Enter a string less than 10 characters: "

/* Second string message */
.balign 4
message2: .asciz "Enter another string less than 10 characters: "

/* Fail message */
.balign 4
failmessage: .asciz "That was not less than 10 characters.\n"

/* Format pattern for scanf */
.balign 4
scanpattern: .asciz "%s"

/* Output message */
.balign 4
printpattern: .asciz "Concatenated: %s\n"

/* How much space to allocate for first string */
.balign 4
first_string: .skip 16

/* How much space to allocate for second string */
.balign 4
second_string: .skip 16

/* How much space to allocate for output string */
.balign 4
output_string: .skip 24

/* Ensures value of r4 will not change throughout program */
.balign 4
r4value: .word 0

/* Ensures value of r5 will not change throughout program */
.balign 4
r5value: .word 0

/* Address of return */
.balign 4
return: .word 0

.text

.global main
main:
	ldr r1, address_of_return // r1 <- &address_of_return
	str lr, [r1] // *r1 <- lr
	ldr r1, address_of_r4 // r1 <- &address_of_r4
	str r4, [r1] // *r1 <- r4
	ldr r1, address_of_r5 // r1 <- &address_of_r5
	str r5, [r1] // *r1 <- r5

	ldr r0, address_of_message1 // r0 <- &address_of_message1
	bl printf // Call to printf

	ldr r0, address_of_scanpattern // r0 <- &address_of_scanpattern
	ldr r1, address_of_firststring // r1 <- &address_of_firststring
	bl scanf // Call to scanf

	mov r3, #21 // r3 <- #21
	ldr r1, address_of_firststring // r1 <- &address_of_firststring
	b check_length // Branch to check_length

get_second_string:
	ldr r0, address_of_message2 // r0 <- &address_of_message2
	bl printf // Call to printf

	ldr r0, address_of_scanpattern // r0 <- &address_of_scanpatter
	ldr r1, address_of_secondstring // r1 <- &address_of_secondstring
	bl scanf // Call to scanf

	mov r3, #22 // r3 <- #22
	ldr r1, address_of_secondstring // r1 <- &address_of_secondstring

check_length:
	ldr r1, [r1, #10] // r1 <- *r1 + 10
	cmp r1, #0 // Compares r1 and #0
	bne error // If element 11 is not null then branch to error
	cmp r3, #21 // Compare r3 and #21
	beq get_second_string // If r3 is #21, branch to get_second_string

straddition1:
	ldr r0, address_of_outputstring // r0 <- &address_of_outputstring
	ldr r1, address_of_firststring // r1 <- &address_of_firststring
	mov r4, #0 // r4 <- #0
	mov r3, #0 // r3 <- #0
	b loop // Branch to loop

straddition2:
	ldr r1, address_of_secondstring // r1 <- &address_of_secondstring
	mov r3, #0 // r3 <- #0

loop:
	ldr  r2, [r1, +r3] // r2 <- *r1 + r3
	str r2, [r0, +r3] // *r0 + r3 <- r2
	add r3, r3, #1 // r3 = r3 + 1
	cmp r2, #0 // Compares r2 and #0
	beq addition_check // If r2 reached null, branch to addition_check
	b loop // Branch to loop if string was not copied to r0 properly

addition_check:
	sub r3, r3, #1 // r3 = r3 - 1
	add r4, r4, r3 // r5 = r5 + r3
	ldr r2, address_of_secondstring // r2 <- &address_of_secondstring
	cmp r1, r2 // Compares r1 and r2
	beq end // If r1 is equal to r2, branch to end
	add r0, r0, r3 // r0 = r0 + r3
	b straddition2 // Branch to straddition2

error:
	mov r5, r3 // r4 <- r3
	ldr r0, address_of_failmessage // r0 <- &address_of_failmessage
	bl printf // Call to printf

	mov r0, r5 // r0 <- r4
	ldr lr, address_of_return // lr <- &address_of_return
	ldr lr, [lr] // lr <- *lr
	ldr r4, address_of_return // r4 <- &address_of_return
	ldr r4, [r4] // r4 <- *r4
	ldr r5, address_of_return // r5 <- &address_-f_return
	ldr r5, [r5] // r5 <- *r5
	bx lr // End program

end:
	ldr r0, address_of_printpattern // r0 <- &address_of_printpattern
	ldr r1, address_of_outputstring // r1 <- &address_of_outputstring
	bl printf // Call to printf

	mov r0, r4 // r0 <- r5
	ldr lr, address_of_return // lr <- &address_of_return
	ldr lr, [lr] // lr <- *lr
	ldr r4, address_of_return // r4 <- &address_of_return
	ldr r4, [r4] // r4 <- *r4
	ldr r5, address_of_return // r5 <- &address_of_return
	ldr r5, [r5] // r5 <- *r5
	bx lr // End program

address_of_message1: .word message1
address_of_message2: .word message2
address_of_failmessage: .word failmessage
address_of_outputstring: .word output_string
address_of_scanpattern: .word scanpattern
address_of_printpattern: .word printpattern
address_of_firststring: .word first_string
address_of_secondstring: .word second_string
address_of_return: .word return
address_of_r4: .word r4value
address_of_r5: .word r5value

.global printf
.global scanf
