	
	.global hash
	.p2align 1 //there is one input, which is the array a
	.type hash, %function
		
	//the address of a is initially stored in r0
hash: 
	.fnstart
	PUSH {r4,lr}
	MOV r3, #0 //r3 will be where the hash is stored
	
	start:
	LDRB r1, [r0] //r1 contains the character
	
	//check for capital letters
	caps:
	CMP r1, #'Z' //compare it with character for Z
	BHI num //if it is after Z, check for numbers
	
	CMP r1, #'A'-1 //compare with character before A
	BLS num //if before A, go to num
	SUB r2, r1, #'A' //r2 contains the position of the letter (A->0, B->1 etc)
		
		LSL r2, r2, #2 //multiply offset by 4
	LDR r4, =Arr	//r4 points to the start of the array
	ADD r4, r2 //r4 points to the corresponding position of the array (arr + offset)
	LDR r2, [r4] //load the content from the address to r2
	ADD r3, r2 //add the number to hash value
	
	//check for digits 0-9
	num:
	CMP r1, #'9' //compare it with character for 0
	BHI skip //if it is after 9, skip
	
	CMP r1, #'0'-1 //compare with character before 0
	BLS skip //if before 0, skip
	SUB r2, r1, #'0' //r2 contains the actual number
	SUB r3, r2 //remove the number from hash value
	
	skip:
	ADD r0, #1 //get the next character
	CMP r1, #0 //was the byte 0?
	
	BNE start //if there is more characters, go back to start
	
	MOV r0, r3 //move the hash to r0 so that it is returned
	POP {r4,lr} //restore registers
	BX lr //if no more characters, return
	
	
	Arr: .word 10,42,12,21,7,5,67,48,69,2,36,3,19,1,14,51,71,8,26,54,75,15,6,59,13,25

