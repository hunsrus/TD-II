
/* This file has been prepared for Doxygen automatic documentation generation.*/
/*! \file *********************************************************************
 *
 * \brief
 *      ATtiny x61/ATmegax8 based Frequency Counter:  Busy Wait version
 *
 *
 *
 *
 *  This file contains the drivers necessary to run the demo and are avaialble 
 *   for use in a user or customer's application.
 *
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









#include <avr/io.h>
#include <compat/ina90.h>	// where _NOP, _CLI and _SEI are defined
#include <avr/interrupt.h>
#include "freq_meter.h"


// Initialize FREQ_CNTR to 16 bit, counts incoming positive edges on pin  T0 for Tiny x61 and T1 for Megax8

void freq_cntr_init(void)
	{

	// Initialize  16 bit FREQ_CNTR counts incoming positive edges on T0 input pin

#if defined(__AVR_ATtiny261__) | defined(__AVR_ATtiny461__) | defined(__AVR_ATtiny861__)
 
	FREQ_CNTR_CTRLA = (1<<TC_COUNTMODE); // Tiny x61:Set Timer0 to 16 bit mode

#endif

#if defined(__AVR_ATmega48__) | defined(__AVR_ATmega88__) | defined(__AVR_ATmega168__)

	FREQ_CNTR_CTRLA = 0;	// Megax8:  16 bit mode is default mode,  OVF at 0xffff

#endif

	}


// Returns frequency of input signal divided by 10, in variable freq_div_by_10
unsigned int freq_cntr_get_frequency(void)
{
unsigned int freq_cntr_freq_divd_by_10;
		_CLI();
		FREQ_CNTR_COUNT_HIGH = 0x00; // clear counter lower 8 bits
		FREQ_CNTR_COUNT_LOW = 0x00; // clear counter upper 8 bits
//		connect FREQ_CNTR to external pin T0 and start counting
		FREQ_CNTR_CTRLB = (1<<CLOCK_SEL_2)|(1<<CLOCK_SEL_1);	// select FREQ_CNTR input clock
		
// Wait until Timer 0 gets its first clock...
		while (FREQ_CNTR_COUNT_LOW == 0) _NOP();	
// Now start a software timer that determins how long FREQ_CNTR runs
		delay100ms(1);
		FREQ_CNTR_CTRLB = 0;//(0<<CLOCK_SEL_00);  // stop counter

// Test TIFR for 16-bit overflow.  If overrange return  0xFFFF
	
		if ((FREQ_CNTR_INT_FLAG_REG & (1<<FREQ_CNTR_OVF_FLAG)) !=0) {
		// Test TIFR for 16-bit overflow =  0xFFFF

				FREQ_CNTR_INT_FLAG_REG = (1<<FREQ_CNTR_OVF_FLAG);// Clear the OVF flag
				freq_cntr_freq_divd_by_10 = 0xFFFF; // This is to return a OVF condition
			}
		else {
				freq_cntr_freq_divd_by_10 = FREQ_CNTR_COUNT_LOW+(FREQ_CNTR_COUNT_HIGH<<8);
			}

		return(freq_cntr_freq_divd_by_10);
}


