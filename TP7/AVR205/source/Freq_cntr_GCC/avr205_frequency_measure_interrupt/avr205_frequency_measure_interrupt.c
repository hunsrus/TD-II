/* This file has been prepared for Doxygen automatic documentation generation.*/
/*! \file *********************************************************************
 *
 * \brief
 *      Tiny 8x61/Megax8 Frequency Counter
 *
 *
 *
 *     Frequency Counter using two timers and two sources of interrupts:  FREQ_CNTR counts rising inptus on
 *		PB6.  PB6 Pin Change Interrupts start the counting of rising-edge input trassitions
 *     GATE_CNTR generates the 0.1 second time base which determines the length of time that the input signal is counted.
 *		GATE_CNTR is preloaded with a value such that when it overflows, a OVF interrupt is generated and the counter is stopped.
 *     This is followed by the results of 16-bit FREQ_CNTR being written into the SRAM location labeled .freq_cntr_freq_divd_by_10.
 *
 *		Output pin PB5 has been programmed to go high at the beginning of the 0.1 second counting period, and low afterward.
 *		Instructions related to PB5 may be removed if desired with no change in code performance.
 *
 *		The accuracy of this frequency measuring algorithm is 99% or better, and is a function of the accuracy of the AVR 8 Mhz clock.
 *		Each application can be tuned for greater precision by measuring the PB5 high an dthen PB5 low interval via this instruction:
 *
 *     		#define DELAY_VAL_100_MS  0xFFFF - (5560 * AVR_Clk_freq) // Adjust the number 5560 for more or less time of the 0.1 second gate.
 *
 * \par Documentation
 *      For comprehensive code documentation, supported compilers, compiler
 *      settings and supported devices see readme.html
 *
 * \author
 *      Atmel Corporation.
 *      Support email: avr@atmel.com
 *
 *
 * Copyright (c) 2010, Atmel Corporation All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * 3. The name of ATMEL may not be used to endorse or promote products derived
 * from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY ATMEL "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE EXPRESSLY AND
 * SPECIFICALLY DISCLAIMED. IN NO EVENT SHALL ATMEL BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *****************************************************************************/

/*! \page doc_page1 How to Connect a signal source to the AVR and Observe Results\n
 * If a tiny x61 is the preferred AVR, after this Studio project is opened.
 *	- Click on Project >> Configuration Options >> Device attiny 261, tiny461 attiny861.
 *  - Connect the digital signal to be measured to the AVR PB6.
 *  - The amplitude of the signal should confrom to the avr" Vih and Vil voltages.
 *  - It is suggested that the JTAGICEmkII Debugger be used and breakpoints be set after 
 *  the respective results have been determined in this .c code.\n
 *
 * If a MEGA is the preferred AVR, after this Studio project is opened.
 *	- Click on Project >> Configuration Options >> Device mega48, mega88 or mega168
 *  - Connect the digital signal to be measured to the AVR pin PD7
 *  - The amplitude of the signal should confrom to the avr" Vih and Vil voltages.
 *  - It is suggested that the JTAGICEmkII Debugger be used and breakpoints be set after 
 *  the respective results have been determined in this .c code.\n.
*/

#include <avr/io.h>
#include <compat/ina90.h>	// where _NOP, _CLI and _SEI are defined
#include <avr/interrupt.h>
#include "freq_meter.h"

unsigned int	freq_cntr_result;
//unsigned int	freq_cntr_freq_divd_by_10;
//Prototype
void users_init(void);

int main() {

	freq_cntr_init();
//! // User to insert their own code in this function, defined below.
	users_init();
	_SEI();						//! User to decide when to enable interrupts

	freq_cntr_start_measurement(); // to measure frequency simply execute  measure_frequency_via_interrupts();
	while (1)
    {		

				//User's code to be inserted here

	if(freq_cntr_get_result() !=0) {

		freq_cntr_result = freq_cntr_get_result();
		freq_cntr_clear_result();

		_NOP();//User's code to be inserted here

		freq_cntr_start_measurement(); // start another measurement

		}
		_NOP();//User's code to be inserted here
	}


}	//end of main


/*! \brief  User's initialization function
 *
 *  This function sends a command byte to the connected
 *  peripheral and waits for a returned status code.
 *
 *  \note  The peripheral must be initialized in advance.
 *
 */
void users_init(void)
	{
	_NOP();		// User to insert initialization code here
	}









