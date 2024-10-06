/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_timer.c
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        functions to manage T0 and T1 interrupts
** Correlated files:    timer.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "lpc17xx.h"
#include "timer.h"
#include "../led/led.h"

/******************************************************************************
** Function name:		Timer0_IRQHandler
**
** Descriptions:		Timer/Counter 0 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
extern unsigned char led_value;					/* defined in funct_led								*/
extern int res;

int flag=0;
int counter=0;

void TIMER0_IRQHandler (void)
{
	NVIC_EnableIRQ(EINT0_IRQn);		//RIABILITO
	NVIC_EnableIRQ(EINT2_IRQn);		//RIABILITO
	LED_Out(0);
  LPC_TIM0->IR |= 1;			/* clear interrupt flag */
	reset_timer(0);
  return;
}


/******************************************************************************
** Function name:		Timer1_IRQHandler
**
** Descriptions:		Timer/Counter 1 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
void TIMER1_IRQHandler (void)
{
	if(flag==0){
		flag=1;
		LED_Out(255);
		counter++;
	}
	else{
		flag=0;
		LED_Out(0);
	}
		
	reset_timer(1);
	enable_timer(1);
	
	if(counter==res){
		disable_timer(1);
		NVIC_EnableIRQ(EINT0_IRQn);
		NVIC_EnableIRQ(EINT1_IRQn);
	}
  LPC_TIM1->IR = 1;			/* clear interrupt flag */
  return;
}

/******************************************************************************
**                            End Of File
******************************************************************************/
