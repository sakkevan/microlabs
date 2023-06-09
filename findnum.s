	
	.global findnum
	.p2align 1 //there is one input, which is the hash
	.type findnum, %function
	
	//the hash is stored in r0
findnum:
	.fnstart
	PUSH {r4,lr}
	MOV r3, #0 //the result will be stored in r3
	MOV r4, #10 // r4 contains the number 10 which will be used for operations
	
	//we turn the number to positive if it's negative
	//this is for two reasons
	//when we check the number of digits it's easier to do a single comparison with 9 instead of also checking if it's less than -9
	//for the second part we would need a positive number anyway, since we can't calculate the factorial of a negative
	CMP r0, #0
	BGT digitsum
	RSB r0, r0, #0 //reverse sign if negative
	
	
	digitsum:
	SDIV r1, r0, r4  // r1 is the number divided by 10
	MUL r1, r1, r4 // r1x10, since the previous r1 is an int, it equals r0 without the last digit
	SUB r2, r0, r1 //r2 is the difference, which is the last digit
	ADD r3, r2
	SDIV r0, r0, r4 //move to the next digit
	CMP r0, #9
	BGT digitsum	//if the number is still 2digits or more, keep repeating the loop
	ADD r3, r0 //add the last digit
	
	CMP r3, #9	//check if the result still has 2 or more digits
	BLT skip
	MOV r0, r3	//if it does, repeat the loop with the sum as the new input
	MOV r3, #0
	BGT digitsum
	
	
	skip:
	
		
	
	//second part, factorial
	//r3 contains the number we want the factorial of
	//the result will be calculated in r0
	MOV r0, #1 

	CMP r3, #0
	//BNE fact
	IT EQ
	MOVEQ r3, #1 // 0! = 1


	fact:
	MUL r0, r3, r0
	SUB r3, r3, #1
	CMP r3, #1
	BGT fact
	
	POP {r4,lr} //restore register
	BX lr	//return
		