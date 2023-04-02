#include <stdio.h>
#include <uart.h>

extern int hash(char *a);
extern int findnum(int b);


int main()
{
	//initialize uart
	uart_init(19200);
	uart_enable();

	//char* a;
	while(1)
		{
			//sAr, PE 2!
		char a[20];
		printf("Enter a string: \n");
		scanf("%s",&a);
		//gets(a);
		int n = hash(&a);
		int f = findnum(n);
		char msgout[100];
		sprintf(msgout,"the hash of %s is %d and the sum of its digits has a factorial of %d \n",a,n,f);
		//printf(msgout);
		uart_print(msgout); 
		}
	
		
	
	return(0);
}
