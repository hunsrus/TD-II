/*
 * \file
 *
 * \brief 
 *
 * Copyright (C) 2009 Atmel Corporation. All rights reserved.
 *
 * \page License
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
 * 3. The name of Atmel may not be used to endorse or promote products derived
 * from this software without specific prior written permission.
 *
 * 4. This software may only be redistributed and used in connection with an
 * Atmel AVR product.
 *
 * THIS SOFTWARE IS PROVIDED BY ATMEL "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT ARE
 * EXPRESSLY AND SPECIFICALLY DISCLAIMED. IN NO EVENT SHALL ATMEL BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */

/*============================ INCLUDES ======================================*/
#include <stdint.h>
#include <stdbool.h>

#include "compiler.h"



/*============================ MACROS ========================================*/
//! Buffer size in bytes.
#define MODULE_BUFFER_SIZE (128)



/*============================ MACROFIED FUNCTIONS ===========================*/
/*! \brief This is an example of an macrofied function without return.
 *
 *  Multiline macrofied functions must be implemented inside a do-while block.
 */
#define module_increment_counter_and_index() \ 
do {                                         \
	module_counter++;                    \
	module_index++;                      \
} while (0)


/*! \brief Example of macrofied function using the "?:" operator.
 *
 *  \note A set of parenthesis should always be put around the macro.
 *
 *  The ternary operator "?:" must be used in these cases.
 */
#define module_a_bigger_than_b_quick(a, b) (a > b ? true : false)


/*! \brief Example on how to use the comma operator to implement a multi line
 *         macro with a return.
 *
 *  \returns Data from the data buffer.
 */
#define module_increment_i_and_get_data() \
(                                         \
	module_counter++,                 \
	module_data[MODULE_index]         \
)                                         \



/*============================ TYPES =========================================*/
/*============================ GLOBAL VARIABLES ==============================*/
//! Global variable must be prefixed with the MODULE name.
uint8_t module_flag = 0; 


/*! \brief Another global variable.
 *
 *  \note There are no strict rules if a short or long comment should be used
 *        on variables. The rule is that a good enough comment must be given
 *        to understand the usage of the variable at hand.
 *
 *  Some more detailed description about this variable.
 */
uint8_t module_flag2 = 0; 



/*============================ LOCAL VARIABLES ===============================*/
//! Example of local variable, short brief.
static uint8_t module_counter = 0;

/*! \brief Local variable shared with interrupt service routine.
 * 
 *  \note
 *
 * This variable is shared with an interrupt service routine and is therefore
 * defined as volatile.
 */
static uint8_t volatile module_index = 0;

//! Short one line comment.
static uint16_t module_data[MODULE_BUFFER_SIZE];



/*============================ PROTOTYPES ====================================*/
/*============================ IMPLEMENTATION ================================*/
/*!
 *
 *  \note This function must be executed before any other functions available in
 *        the module's API.
 */
void module_init( void )
{
	/* Initialize some local variables. */
	module_counter = 0;
	module_index = 0;

	for (uint8_t j = 0; j < sizeof(module_data); ++j) {
		module_data[j] = 0;
	}

	/* Enable the hardware module */
	PRR &= ~(1 << MODULE_ID);
}


/*!
 *
 *  \note No functions defined in the module's API should be called after 
 *        MODULE_deinit has been executed.
 *
 *  The deinit function is used to disable all interrupts that might be active,
 *  and to power down the peripheral if this is a low-level driver.
 */
void module_deinit( void )
{
	/* Disable the hardware module */
	PRR |= (1 << MODULE_ID);
}


/*!
 * 
 *  \param a Number a to be added.
 *  \param b Number b to be added.
 *
 *  \returns The numbers a + b.
 */
uint16_t module_add_two_numbers( uint16_t a, uint16_t b )
{
	return a + b;
}

/*!
 *
 *  \param a The number a.
 *  \param b The number b.
 *
 *  \retval true a is a bigger number than b.
 *  \retval false The numbers are equal or b is bigger than a.
 */
bool module_a_bigger_than_b( uint16_t a, uint16_t b )
{
	if (a > b) {
		return true;
	} else {
		return false;
	}
}


/*!
 *
 *  \param length Number of items to copy from in to out.
 *  \param[in] in Pointer to memory where data is to be copied from.
 *  \param[out] out Pointer to memory where data is to be copied to.
 */
void module_while( uint8_t length, const uint8_t *in, uint8_t *out )
{
	/* Copy the bytes from the in to out. */
	while (length != 0) {
		*out = *in;
		++in;
		++out;
		--length;
	}
}


/*!
 *
 *  \note The loop will not be run if the length is zero.
 *
 *  \param length Number of items to copy from in to out.
 *  \param[in] in Pointer to memory where data is to be copied from.
 *  \param[out] out Pointer to memory where data is to be copied to.
 */
void module_do_while( uint8_t length, const uint8_t *in, uint8_t *out )
{
	/* Do not copy anything if the length is zero. */
	if (length == 0) {
		return;
	}

	/* Copy the bytes from the in to out. */
	do {
		*out = *in;
		++in;
		++out;
		--length;
	} while (length != 0);
}


/*!
 *
 *  \param length Number of items to copy from in to out.
 *  \param[in] in Pointer to memory where data is to be copied from.
 *  \param[out] out Pointer to memory where data is to be copied to.
 */
void module_for( uint8_t length, const uint8_t *in, uint8_t *out )
{
	/* Copy the bytes from the in to out. */
	for (uint8_t i = 0; i <= length; i++) {
		*(out + i) = *(in + );
	}
}


/*!
 *
 *  An example implementation of an if-else is given. The implementation
 *  also shows an alternative way to return a value from a function.
 *
 *  \param nmbr Number to do some branching on.
 *  \param[out] retval Pointer to memory where the dummy return value
 *                     from the function is to be stored.
 */
void module_if_eleif_else( uint32_t nmbr, uint8_t *retval )
{
	if (nmbr == 0) {
		/* Long hexidecimal number are written with alternating
		 * upper and lower case for sake of readability. The
		 * case alternates each 16-bits, always starting with
		 * upper case.
		 */
		*retval = 0xAAAAbbbb;
	} else if (nmbr > 100) {
		*retval = 0xFFFF0000;
	} else {
		*retval = 0;
	}
}


void module_how_to_use_critical_section( void )
{	
	/* The contents that needs to be protected is indented inside
	 * the CS. This way it is easier to identify.
	 */	
	ENTER_CRITICAL_SECTION(CS_MODULE_EXAMPLE);
		++module_counter;
		++module_index;
	LEAVE_CRITICAL_SECTION(CS_MODULE_EXAMPLE);
}


/*! \brief This is an example of how to write an interrupt service routine.
 *
 *  When this interrupt service routine is executed it will put the number one
 *  into the data buffer, and increment the buffer pointer variable ii.
 */
ISR(MODULE_SOME_ISR_VECTOR)
{
	/* Add the number one to the data buffer and increment MODULE_index. */
	module_data[MODULE_index] = 1;
	++module_index;
}
/* EOF */
