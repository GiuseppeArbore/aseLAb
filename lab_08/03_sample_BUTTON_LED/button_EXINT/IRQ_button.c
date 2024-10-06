#include "button.h"
#include "lpc17xx.h"

#include "../led/led.h"
extern char led_value;		//tolto unsigned

void EINT0_IRQHandler (void)	  //int0
{
	led_value=0;
	//LED_On(0); accende led 0
	LED_Out(led_value); //sputa value fuori
  LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  //KEY1
{
	led_value ++;									//sommo
  //LED_On(1);		accende il led inposizione 1
	LED_Out(led_value);
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  //KEY2
{
	led_value--;								//sottraggo
	//LED_Off(0);	spegne led 0
	//LED_Off(1); spegne led 1
	LED_Out(led_value); //sputa out
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}


