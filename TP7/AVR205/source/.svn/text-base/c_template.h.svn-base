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

#ifndef C_TEMPLATE_H_INCLUDED
#define C_TEMPLATE_H_INCLUDED
/*============================ INCLUDES ======================================*/
#include <stdint.h>
#include <stdbool.h>
/*============================ MACROS ========================================*/
//! Constant defining the end of file for this module.
#define MODULE_EOF (0xFF)



/*============================ MACROFIED FUNCTIONS ===========================*/
//! Get global flag.
#define module_get_flag() module_flag

/*! \brief Set global flag. 
 *  
 *  Some description of how to use this macrofied function.
 *
 *  \param value Value to set the module_flag to.
 */
#define module_set_flag(value) module_flag = value



/*============================ TYPES =========================================*/
//! Example definition of function pointer.
typedef void (*mdoule_callback_t)( void );

//! Enumeration example.
typedef enum mdoule_enum_example_enum {
	MODULE_ZEOR = 0,
	MODULE_ONE,
	MODULE_TWO
} mdoule_enum_example_t;

/*! \brief Example of custom data type.
 *
 *  This structure needs some more explantation, and hence a longer comment
 *  is necessary.
 */
typedef struct module_data_struct {
	uint8_t counter; //!< Member comment1.
	uint8_t *buffer; //!< Member comment2.
} module_data_t;



/*============================ GLOBAL VARIABLES ==============================*/
/*! \brief Limit usage of global variables, and when necessary limit direct acess.
 *
 *  Make some macrofied access functions for the global variable. This the user
 *  does not rely on a certain variable name, but rather a function call.
 */
extern uint8_t module_flag;



/*============================ LOCAL VARIABLES ===============================*/
/*============================ PROTOTYPES ====================================*/

#ifdef __cplusplus
extern "C" {
#endif



//! \brief Initialize the module.
void module_init( void );

//! \brief This function tears the module down.
void module_deinit( void );

//! \brief Add two numbers a and b.
uint16_t module_add_two_numbers( uint16_t a, uint16_t b );

//! \brief Check if a is bigger than b.
bool module_a_bigger_than_b( uint16_t a, uint16_t b );

//! \brief This function gives an example on how to write a while-loop.
void module_while( uint8_t length, const uint8_t *in, uint8_t *out );

//! \brief This function gives an example on how to write a do-while-loop.
void module_do_while( uint8_t length, const uint8_t *in, uint8_t *out );

//! \brief This function gives an example on how to write a for-loop.
void module_for( uint8_t length, const uint8_t *in, uint8_t *out );

//! \brief This is an example if-elseif - else.
void module_if_eleif_else( uint32_t nmbr, uint8_t *retval );

//! \brief Quick example of how to use critical sections.
void module_how_to_use_critical_section( void );



#ifdef __cplusplus
} /* extern "C" */
#endif

#endif
/* EOF */
