#include "button.h"
#include "lpc17xx.h"
//#include "stdio.h"

/*
Per disattivare:
LPC_PINCON->PINSEL4    &= ~(1 << XX)
Per attivare
LPC_PINCON->PINSEL4    |= (1 << 20);
XX = 20 per int0, 22 per key1 e 24 per key2
*/


#include "../led/led.h"
#include "../timer/timer.h"

char vettore[] = {0,0,0,0,2,1,1,1,2,0,1,0,0,2,0,1,3,1,1,2,0,0,1,2,1,0,2,1,0,0,2,1,1,1,3,0,1,1,1,1,2,0,0,1,1,1,4};
//char vettore[]="00002111201002013112001210210021113011112001114";
char vet_output[20];
int len;
//int len_out:
volatile int res=0;

char change_symbol=2;
char space=3;
char sentence_end=4;
void leggi_vettore(char *vettore);
extern int function1(char *vettore,int vet_input_lenght, char* vett_output, int vet_output_lenght, char change_symbol, char space, char sentence_end);

void EINT0_IRQHandler (void)	  	/* INT0					P2.10									 */
{
	disable_timer(1);
	NVIC_EnableIRQ(EINT1_IRQn);
	LPC_PINCON->PINSEL4    |= (1 << 22);
	LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}



void EINT1_IRQHandler (void)	  	/* KEY1					P2.11									 */
{
  LED_Out(0);
	leggi_vettore(vettore);
	LPC_PINCON->PINSEL4    &= ~(1 << 20);
	LPC_PINCON->PINSEL4    &= ~(1 << 24);
	NVIC_DisableIRQ(EINT0_IRQn);
	NVIC_DisableIRQ(EINT2_IRQn);

	LED_Out(255);
	reset_timer(0);
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
	enable_timer(0);
	//gestisco nel timer
}

void EINT2_IRQHandler (void)	  	/* KEY2				P2.12									 */
{ LPC_PINCON->PINSEL4    &= ~(1 << 20);
	LPC_PINCON->PINSEL4    &= ~(1 << 22);
	NVIC_DisableIRQ(EINT0_IRQn);
	NVIC_DisableIRQ(EINT1_IRQn);
	res=function1(vettore, len, vet_output, 0, change_symbol, space, sentence_end);

	enable_timer(1);
	//gestisco nel timer
	LPC_PINCON->PINSEL4    |= (1 << 20);
	NVIC_EnableIRQ(EINT0_IRQn);		//RIABILITO

  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */  
	
}

void leggi_vettore(char *vettore){
	len=0;
	//lenOut=0;
	while (vettore[len] != 4){
		/*if(vettore[len]==2) 
			lenOut++;
		if(vettore[len]==3)
			lenOut+=2;*/
		len++;
	}
	len++;
}

