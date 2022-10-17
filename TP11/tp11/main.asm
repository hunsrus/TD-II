;
;************************************
; Técnicas Digitales II 
; Autor: GM
; Fecha: 16-09-2020
; version: 0.1
; for AVR: atmega328p (Arduino UNO)
; clock frequency: 16MHz 
;************************************

;===========================================
; Función del programa
; Se deberá realizar un programa que  
; transmita, a una PC, las teclas
; presionadas en un teclado matricial.
;-------------------------------------------
.ifndef F_CPU
.set F_CPU = 16000000
.endif
;===========================================
; Declarations for register
.def temp 		= r16
.def aux		= r17

;===========================================
; Declarations for label
.set Flags0			= GPIOR0
.set PressKey		= $0

;===========================================
; Etiquetas
.equ	baud = 9600			;Baud Rate

;===========================================
; Data Segment
.dseg
DATA_KB:			.byte	1
BaseTime1ms:		.byte	1
BaseTime20ms:		.byte	1
BaseTime100ms:		.byte	1

;===========================================
; EEPROM Segment
.eseg
VAR_EEPROM:		.db		$AA

;===========================================
; Code Segment
.cseg
.org RWW_START_ADDR      	; memory (PC) location of reset handler
	rjmp Reset           	; jmp costs 2 cpu cycles and rjmp costs only 1
                         	; so unless you need to jump more than 8k bytes
                         	; you only need rjmp. Some microcontrollers therefore only 
                         	; have rjmp and not jmp

.org INT0addr				; memory location of External Interrupt Request 0
	rjmp isr_INT0_handler	; go here if a External Interrupt 0 occurs 

.org INT1addr				; memory location of External Interrupt Request 1
	rjmp isr_INT1_handler	; go here if a External Interrupt 1 occurs 

.org PCI0addr				; memory location of Pin Change Interrupt Request 0
	rjmp isr_PCI0_handler	; go here if a Pin Change Interrupt 0 occurs 

.org PCI1addr				; memory location of Pin Change Interrupt Request 1
	rjmp isr_PCI1_handler	; go here if a Pin Change Interrupt 1 occurs 

.org PCI2addr				; memory location of Pin Change Interrupt Request 2
	rjmp isr_PCI2_handler	; go here if a Pin Change Interrupt 2 occurs 

.org WDTaddr				; memory location of Watchdog Time-out Interrupt
	rjmp isr_WDT_handler	; go here if a Watchdog Time-out Interrupt occurs 

.org OC2Aaddr				; memory location of Timer/Counter2 Compare Match A Interrupt
	rjmp isr_OC2A_handler	; go here if a Timer/Counter2 Compare Match A Interrupt occurs 

.org OC2Baddr				; memory location of Timer/Counter2 Compare Match B Interrupt
	rjmp isr_OC2B_handler	; go here if a Timer/Counter2 Compare Match B Interrupt occurs 

.org OVF2addr				; memory location of Timer/Counter2 Overflow Interrupt
	rjmp isr_OVF2_handler	; go here if a Timer/Counter2 Overflow Interrupt occurs 

.org ICP1addr				; memory location of Timer/Counter1 Capture Event Interrupt
	rjmp isr_ICP1_handler	; go here if a Timer/Counter1 Capture Event Interrupt occurs 

.org OC1Aaddr				; memory location of Timer/Counter1 Compare Match A Interrupt
	rjmp isr_OC1A_handler	; go here if a Timer/Counter1 Compare Match A Interrupt occurs 

.org OC1Baddr				; memory location of Timer/Counter1 Compare Match B Interrupt
	rjmp isr_OC1B_handler	; go here if a Timer/Counter1 Compare Match B Interrupt occurs 

.org OVF1addr				; memory location of Timer/Counter1 Overflow Interrupt
	rjmp isr_OVF1_handler	; go here if a Timer/Counter1 Overflow Interrupt occurs 

.org OC0Aaddr				; memory location of Timer/Counter0 Compare Match A Interrupt
	rjmp isr_OC0A_handler	; go here if a Timer/Counter0 Compare Match A Interrupt occurs 

.org OC0Baddr				; memory location of Timer/Counter0 Compare Match B Interrupt
	rjmp isr_OC0B_handler	; go here if a Timer/Counter0 Compare Match B Interrupt occurs 

.org OVF0addr              	; memory location of Timer0 overflow handler
	rjmp isr_OVF0_handler	; go here if a timer0 overflow interrupt occurs 

.org SPIaddr              	; memory location of SPI Serial Transfer Complete handler
	rjmp isr_SPI_handler	; go here if a SPI Serial Transfer Complete interrupt occurs 

.org URXCaddr              	; memory location of USART Rx Complete handler
	rjmp isr_URXC_handler	; go here if a USART Rx Complete interrupt occurs 

.org UDREaddr              	; memory location of USART, Data Register Empty handler
	rjmp isr_UDRE_handler	; go here if a USART, Data Register Empty interrupt occurs 

.org UTXCaddr              	; memory location of USART Tx Complete handler
	rjmp isr_UTXC_handler	; go here if a USART Tx Complete interrupt occurs 

.org ADCCaddr              	; memory location of ADC Conversion Complete handler
	rjmp isr_ADCC_handler	; go here if a ADC Conversion Complete interrupt occurs 

.org ERDYaddr              	; memory location of EEPROM Ready handler
	rjmp isr_ERDY_handler	; go here if a EEPROM Ready interrupt occurs 

.org ACIaddr              	; memory location of Analog Comparator handler
	rjmp isr_ACI_handler	; go here if a Analog Comparator interrupt occurs 

.org TWIaddr              	; memory location of Two-wire Serial Interface handler
	rjmp isr_TWI_handler	; go here if a Two-wire Serial Interface interrupt occurs 

.org SPMRaddr              	; memory location of Store Program Memory Read handler
	rjmp isr_SPMR_handler	; go here if a Store Program Memory Read interrupt occurs 

; ==========================
; interrupt service routines  

isr_INT0_handler:
	reti					; External Interrupt 0

isr_INT1_handler:
	reti					; External Interrupt 1 

isr_PCI0_handler:
	reti					; Pin Change Interrupt 0 

isr_PCI1_handler:
	reti					; Pin Change Interrupt 1 

isr_PCI2_handler:
	reti					; Pin Change Interrupt 2 

isr_WDT_handler:
	reti					; Watchdog Time-out Interrupt  

isr_OC2A_handler:
	reti					; Timer/Counter2 Compare Match A Interrupt  

isr_OC2B_handler:
	reti					; Timer/Counter2 Compare Match B Interrupt  

isr_OVF2_handler:
	reti					; Timer/Counter2 Overflow Interrupt  

isr_ICP1_handler:
	reti					; Timer/Counter1 Capture Event Interrupt  

isr_OC1A_handler:
	reti					; Timer/Counter1 Compare Match A Interrupt  

isr_OC1B_handler:
	reti					; Timer/Counter1 Compare Match B Interrupt  

isr_OVF1_handler:
	reti					; Timer/Counter1 Overflow Interrupt  

isr_OC0A_handler:
	reti					; Timer/Counter0 Compare Match A Interrupt  

isr_OC0B_handler:
	reti					; Timer/Counter0 Compare Match B Interrupt  

isr_OVF0_handler:
	push temp
	ldi	temp,6
	out TCNT0,temp
	lds temp, BaseTime1ms
	inc temp
	cpi temp,200
	brne notime
	rcall Read_KEY			;Leo el teclado
	ldi temp, 0
notime:
	sts BaseTime1ms, temp
	pop temp
	reti					; Timer0 overflow interrupt  

isr_SPI_handler:
	reti					; SPI Serial Transfer Complete interrupt  

isr_URXC_handler:
	reti					; USART Rx Complete interrupt  

isr_UDRE_handler:
	reti					; USART, Data Register Empty interrupt  

isr_UTXC_handler:
	reti					; USART Tx Complete interrupt  

isr_ADCC_handler:
	reti					; ADC Conversion Complete interrupt  

isr_ERDY_handler:
	reti					; EEPROM Ready interrupt  

isr_ACI_handler:
	reti					; Analog Comparator interrupt  

isr_TWI_handler:
	reti					; Two-wire Serial Interface interrupt  

isr_SPMR_handler:
	reti					; Store Program Memory Read interrupt  

; Tabla de Key_SCAN
; Pin	D7	D6	D5	D4	C0	C1	C2	C3
; R/C	R1	R2	R3	R4	C1	C2	C3	C4
Key_Scan:
;	 C0	  C1   C2   C3
.db '1', '2', '3', 'A' ;R1
.db	'4', '5', '6', 'B' ;R2
.db '7', '8', '9', 'c' ;R3
.db '*', '0', '#', 'd' ;R4

;===========================================
; Read_KEY
; Lee un teclado matricial
; Parámetro: No 
; Retorno: R16 -> dato que se recibe
Read_KEY:
ROW_1:
	;ldi aux,0x70	;Activo R1		0111 0000
	;out PORTD,aux
	CBI	PORTD,7
	nop
	in	temp,PINC
	andi temp,0x0f
	cpi	temp,0x0b	;0000 1011
	breq IS_KEY_3
	cpi	temp,0x0d	;0000 1101
	breq IS_KEY_2
	cpi	temp,0x0e	;0000 1110
	breq IS_KEY_1
	rjmp ROW_2
IS_KEY_3:
	ldi	temp,'3'
	sts	DATA_KB,temp
	in temp, Flags0					; Tecla presionada
	sbr temp, (1 << PressKey)		; PressKey = 1 en Flags0
	out Flags0, temp
	rjmp out_read_key
IS_KEY_2:
	ldi	temp,'2'
	sts	DATA_KB,temp
	in temp, Flags0					; Tecla presionada
	sbr temp, (1 << PressKey)		; PressKey = 1 en Flags0
	out Flags0, temp
	rjmp out_read_key
IS_KEY_1:
	ldi	temp,'1'
	sts	DATA_KB,temp
	in temp, Flags0					; Tecla presionada
	sbr temp, (1 << PressKey)		; PressKey = 1 en Flags0
	out Flags0, temp
	rjmp out_read_key
ROW_2:
	;ldi aux,0xB0	;Activo R2		1011 0000
	;out PORTD,aux
	SBI	PORTD,7
	CBI	PORTD,6
	nop
	in	temp,PINC
	andi temp,0x0f
	cpi	temp,0x0b	;0000 1011
	breq IS_KEY_6
	cpi	temp,0x0d	;0000 1101
	breq IS_KEY_5
	cpi	temp,0x0e	;0000 1110
	breq IS_KEY_4
	rjmp ROW_3
IS_KEY_6:
	ldi	temp,'6'
	sts	DATA_KB,temp
	in temp, Flags0					; Tecla presionada
	sbr temp, (1 << PressKey)		; PressKey = 1 en Flags0
	out Flags0, temp
	rjmp out_read_key
IS_KEY_5:
	ldi	temp,'5'
	sts	DATA_KB,temp
	in temp, Flags0					; Tecla presionada
	sbr temp, (1 << PressKey)		; PressKey = 1 en Flags0
	out Flags0, temp
	rjmp out_read_key
IS_KEY_4:
	ldi	temp,'4'
	sts	DATA_KB,temp
	in temp, Flags0					; Tecla presionada
	sbr temp, (1 << PressKey)		; PressKey = 1 en Flags0
	out Flags0, temp
	rjmp out_read_key
ROW_3:
	;ldi aux,0xD0	;Activo R3		1101 0000
	;out PORTD,aux
	SBI	PORTD,6
	CBI	PORTD,5
	nop
	in	temp,PINC
	andi temp,0x0f
	cpi	temp,0x0b	;0000 1011
	breq IS_KEY_9
	cpi	temp,0x0d	;0000 1101
	breq IS_KEY_8
	cpi	temp,0x0e	;0000 1110
	breq IS_KEY_7
	rjmp out_read_key
IS_KEY_9:
	ldi	temp,'9'
	sts	DATA_KB,temp
	in temp, Flags0					; Tecla presionada
	sbr temp, (1 << PressKey)		; PressKey = 1 en Flags0
	out Flags0, temp
	rjmp out_read_key
IS_KEY_8:
	ldi	temp,'8'
	sts	DATA_KB,temp
	in temp, Flags0					; Tecla presionada
	sbr temp, (1 << PressKey)		; PressKey = 1 en Flags0
	out Flags0, temp
	rjmp out_read_key
IS_KEY_7:
	ldi	temp,'7'
	sts	DATA_KB,temp
	in temp, Flags0					; Tecla presionada
	sbr temp, (1 << PressKey)		; PressKey = 1 en Flags0
	out Flags0, temp
	;rjmp out_read_key
out_read_key:
	ldi aux,0xF0					;Desactivo los renglones
	out PORTD,aux
	ret  	
;======================
; Main body of program:
Reset:
	ldi R16, LOW(RAMEND)    	; Lower address byte RAM byte lo.
	out SPL, R16         		; Stack pointer initialise lo.
	ldi R16, HIGH(RAMEND)   	; Higher address of the RAM byte hi.
	out SPH, R16			 	; Stack pointer initialise hi. 
; write your code here
	call Init_USART0
	call Init_Timer0
	call Init_Port
			
	ldi r19,(1 << DDB5)
	out DDRB, r19

	clr r18
	sei
Loop:
	eor r18,r19					; invert output bit
	out PORTB,r18				; write to port
		   
	sbis Flags0,PressKey				 
	rjmp Loop

	lds	temp,DATA_KB
	rcall Tx_Byte_USART0		; Send Byte

	in temp, Flags0						; Tecla enviada
	cbr temp, (1 << PressKey)			; PressKey = 0 en Flags0
	out Flags0, temp

	rjmp Loop            ; loop back to the start

;===========================================
; Init_Timer0
; Inicia el Timer 0 para desborde cada 1 mseg
; Tovf = 2^n * Prescaler / Fio
; Mod = Tovf * Fio / Prescaler
Init_Timer0:
	;Set the Timer Mode to Normal
	;TCCR0A
	; COM0A1 | COM0A0 | COM0B1 | COM0B0 | - | - | WGM01 | WGM00
	;	0		 0		  0		   0				0		0
	in	temp,TCCR0A
	cbr	temp,1<<WGM00
	cbr	temp,1<<WGM01
	out TCCR0A,temp
	
	;TCCR0B
	; FOC0A	| FOC0B | - | - | WGM02 | CS02 | CS01 | CS00
	;	0		0				0		0	   1	  1
	in	temp,TCCR0B
	cbr	temp,1<<WGM02
	out TCCR0B,temp
	
	;Activate interrupt for Overflow
	;TIMSK0
	; -	| - | - | - | - | OCIE0B | OCIE0A | TOIE0
	;						0		 0		  1
	lds	temp,TIMSK0
	sbr	temp,1 << TOIE0
	sts TIMSK0,temp
	
	;Set TCNT0
	ldi	temp,6
	out TCNT0,temp
	
	;Start the Timer (prescaler %64)
	in	temp,TCCR0B
	sbr	temp,1<<CS00
	sbr	temp,1<<CS01
	cbr	temp,1<<CS02
	out TCCR0B,temp
	ret
 
;===========================================
; Init_Port
; Inicia el Puerto PD7-4 como salida
; Puerto C3-C0 como entrada
Init_Port:
	ldi temp, (1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4)
	out DDRD, temp			; PortD como salida
	;clr temp				; Borro el PortD
	ldi temp, (1<<PD7) | (1<<PD6) | (1<<PD5) | (1<<PD4)
	out PORTD, temp			;Puerto en ALTO
	
	ldi aux, (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0)
	out PORTC, aux			; Activo resistencias de Pull-Up
	out DDRC, temp			; PortC como entrada

	ldi temp,$20
	out DDRB,temp			;PortB.5 como salida (Pin 13 Arduino)
	ret
	  
;===========================================
; Init_USART0
; Inicializa la transmisión serie: 8N1 9600
; Parámetro: No
; Retorno: No
Init_USART0:
{
			;Set Baud Rate
			ldi	r17,high(F_CPU/(16*baud)-1)	
			ldi	r16,low(F_CPU/(16*baud)-1)	
			sts UBRR0H, r17
			sts UBRR0L, r16
			
			; Enable receiver and transmitter
			ldi r16, (1<<TXEN0)		
			sts UCSR0B,r16

			; Set frame format: 8data, 1stop bit
			ldi r16, (0<<USBS0)|(3<<UCSZ00)		
			sts UCSR0C,r16
			ret
}

;===========================================
; Tx_Byte_USART0
; Envía dato por USART0
; Parámetro: R16 -> dato que se envía
; Retorno: No
Tx_Byte_USART0:
{
		   ; Wait for empty transmit buffer
		   lds r17,UCSR0A			;Load into R17 from SRAM UCSR0A         
		   sbrs r17,UDRE0			;Skip next instruction If Bit Register is set
		   rjmp Tx_Byte_USART0
		   ; Put data (r16) into buffer, sends the data
		   sts UDR0,r16
		   ret
}

;===========================================
; Rx_Byte_USART0
; Recibe dato por USART0
; Parámetro: No 
; Retorno: R16 -> dato que se recibe
Rx_Byte_USART0:
{
		   ; Wait for data to be received
		   lds r17,UCSR0A
		   sbrs r17,RXC0
		   rjmp Rx_Byte_USART0
		   ; Get and return received data from buffer
		   lds r16, UDR0
		   ret
}
