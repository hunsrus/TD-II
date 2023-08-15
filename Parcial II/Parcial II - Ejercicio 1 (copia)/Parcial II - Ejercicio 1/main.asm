;
; Parcial II - Ejercicio 1.asm
;
; Author : Gabriel
;

;para configurar el Brown-out en 4.3[V] hay que programar (poner en 0) los fusibles correspondientes
;en el Extended Fuse Byte. En este caso los últimos 3 bits deben ser 100 para una tensión tipica de 4.3[V]
;El resto de los fusibles debe permanecer sin programar (1) entonces el valor del byte será efuse=0xFC

.ifndef F_CPU
	.set F_CPU = 16000000
.endif

.equ baud = 9600	;baud rate

.set FLAGS = GPIOR0
.set F_CMD_COM = 0	;comando completo
.set F_CMD_ERR = 1	;error en comando
.set F_UPD_PWM = 2	;actualizar pwm

;===========================================
; Data Segment
.dseg
VAL_PARAM:	.byte 3		;Digitos del parametro recibido
VAL_PWM_DIG:.byte 3		;Valor del PWM, digitos separados
VAL_PWM:	.byte 1		;Valor del PWM, en %
BUFFER:		.byte 24	;buffer de 16? bytes
BF_INDEX:	.byte 1		;índice del buffer

.cseg	;code segment
.org 0x00
	rjmp start

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
	in r5, SREG
	push r5
	push r16

	sbis FLAGS, F_UPD_PWM
	rjmp _dont_update_pwm
	lds r16, VAL_PWM
	out OCR0A, r16
	cbi FLAGS, F_UPD_PWM
_dont_update_pwm:

	pop r16
	pop r5
	out SREG, r5
	reti					; Timer/Counter0 Compare Match A Interrupt  

isr_OC0B_handler:
	reti					; Timer/Counter0 Compare Match B Interrupt  

isr_OVF0_handler:
	
	reti					; Timer0 overflow interrupt  

isr_SPI_handler:
	reti					; SPI Serial Transfer Complete interrupt  

isr_URXC_handler:
	in r5, SREG
	push r5
	push r16
	push r17
	push XL
	push XH	

	ldi XL, low(BUFFER)
	ldi XH, high(BUFFER)

	lds r16, UDR0
	cpi r16, '$'
	brne _no_start_cmd
	clr r17
	sts BF_INDEX, r17
_no_start_cmd:
	lds r17, BF_INDEX
	add XL, r17
	st X, r16
	inc r17
	sts BF_INDEX, r17
	cpi r16, '\n'		;CAMBIAR A \n !!!!!!!!!!!!!!
	brne _no_end_cmd
	sbi FLAGS, F_CMD_COM	;seteo el flag cmd_complete
_no_end_cmd:
	pop XH
	pop XL
	pop r17
	pop r16
	pop r5
	out SREG, r5
	reti

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

start:
	;reseteo el registro de estado para deshabilitar I: Global Interrupt Enable (Bit 7)
	;porque no debe estar seteada durante la inicialización de la USART para trabajar con interrupciones
	clr r16
	out SREG, r16

	ldi r16, low(RAMEND)
	out SPL, r16
	ldi r16, high(RAMEND)
	out SPH, r16

	clr r16
	sts BF_INDEX, r16	;índice del buffer = 0
	sts FLAGS, r16		;resetea banderas
	rcall USART0_init
	rcall PWM_init

	ldi r16,0x40
	out DDRD,r16
	cbi PORTD,6

	sei

main:
{
	sbis FLAGS, F_CMD_COM	;chequeo bandera cmd_complete
	rjmp main
	rcall CMD_check
	;sbic FLAGS, F_CMD_ERR	;chequeo bandera cmd_error
	ldi ZL, low(Response<<1)
	ldi ZH, high(Response<<1)
	ldi r18, 11
_send_response:
	dec r18
	breq _response_done
	lpm r16, Z+
	rcall USART0_tx
	rjmp _send_response
_response_done:
	ldi XL, low(VAL_PWM_DIG)
	ldi XH, high(VAL_PWM_DIG)
	ld r16, X+
	rcall USART0_tx
	ld r16, X+
	rcall USART0_tx
	ld r16, X
	rcall USART0_tx
	ldi r16, '*'
	rcall USART0_tx
	ldi r16, '\n'
	rcall USART0_tx
	cbi FLAGS, F_CMD_COM	;reseteo flag cmd_complete
	cbi FLAGS, F_CMD_ERR	;reseteo flag cmd_err
	clr r17
	sts BF_INDEX, r17		;reseteo el índice del buffer

	rjmp main
}

CMD_check:
	push r16
	push r17
	push r18
	push r19

	ldi YL, low(VAL_PARAM)
	ldi YH, high(VAL_PARAM)
	ldi r16, '0'
	st Y+, r16
	st Y+, r16
	st Y+, r16

	ldi XL, low(BUFFER)
	ldi XH, high(BUFFER)
	ldi ZL, low(Response << 1)
	ldi ZH, high(Response << 1)
	lds r19, BF_INDEX
	subi r19, 12		;cantidad de digitos
	cpi r19, 4		;chequeo si hay demasiados digitos
	brsh _cmd_error
	cpi r19, 1
	brlo _cmd_error	;chequeo si no hay ningún dígito
	ldi r18, 11
_read_first:
	dec r18
	breq _read_last
	ld r16, X+
	lpm r17, Z+
	cp r16, r17
	breq _read_first
_cmd_error:
	sbi FLAGS, F_CMD_ERR	;seteo flag cmd_error
	rjmp _buffer_ok
_read_last:
	add XL, r19
	inc XL			;voy al último caracter
	ld r16, -X
	cpi r16, '*'	;chequeo si es un asterisco
	brne _cmd_error
_read_last_loop:	;si el resto del comando está bien, copio los dígitos recibidos en VAL_PARAM
	ld r16, -X
	st -Y, r16
	dec r19
	brne _read_last_loop

	clr r18				;limpio r18 (almacenará el número final)
	ldi r19, 0x3A		;limite de comparación superior (caracter siguiente al 9)
	ldi YL, low(VAL_PARAM)
	ldi YH, high(VAL_PARAM)
	ldd r16, Y+0
	cpi r16, '0'
	breq _digit_1_ok
	cpi r16, '1'
	brne _cmd_error		;si no es 0 o 1, error
	ldi r18, 100		;si es 1, cargo 100 en r18
	ldi r19, '1'		;y defino el límite inferior de la decena y unidad como 0
_digit_1_ok:
	ldd r16, Y+1
	cp r16, r19			;comparo al límite superior
	brsh _cmd_error
	cpi r16, '0'		;limite de comparación inferior (caracter 0)
	brlo _cmd_error
	subi r16, 0x30		;si está en el rango, lo convierto de caracter a número
	ldi r17, 10
	mul r16, r17
	add r18, r0			;sumo la decena a r18
_digit_2_ok:
	ldd r16, Y+2
	cp r16, r19		;limite de comparación superior (caracter siguiente al 9)
	brsh _cmd_error
	cpi r16, '0'		;limite de comparación inferior (caracter 0)
	brlo _cmd_error
	subi r16, 0x30		;si está en el rango, lo convierto de caracter a número
	add r18, r16		;sumo la unidad a r18
	sts VAL_PWM, r18	;y guardo el resultado en VAL_PWM
	rcall PWM_map		;mapeo el valor en % con la tabla
	lds r16, VAL_PWM
	;rcall USART0_tx

	;hasta acá todo cumple las condiciones, entonces sobreescribo el dato en VAL_PWM_DIG para mostrarlo
	ldi XL, low(VAL_PWM_DIG)
	ldi XH, high(VAL_PWM_DIG)
	ld r16, Y+
	st X+, r16
	ld r16, Y+
	st X+, r16
	ld r16, Y
	st X, r16
	;y finalmente levanto la bandera para actualizar el valor del PWM
	sbi FLAGS, F_UPD_PWM
_buffer_ok:
	pop r19
	pop r18
	pop r17
	pop r16
	ret

USART0_init:
{
	;baud rate equation fot asynchronous normal mode (U2Xn=0)
	;BAUD=F_CPU/(16*UBRRn-1)
	ldi r17, high(F_CPU/(16*baud)-1)
	ldi r16, low(F_CPU/(16*baud)-1)
	sts UBRR0H, r17
	sts UBRR0L, r16
	;enable receiver, transmitter and rxc interrupt
	ldi r16, (1<<TXEN0) | (1<<RXEN0) | (1<<RXCIE0)
	sts UCSR0B, r16
	;UCSZ01 = 1 UCSZ00 = 1 : 8 bits de dato
	;UPM01 = 0 UPM00 = 0 : sin paridad
	;USBS0 = 0 : 1 bit de stop
	ldi r16,(1<<UCSZ01)|(1<<UCSZ00)
	sts UCSR0C, r16
	ret
}

USART0_tx:
{
	push r17
_USART0_wait:
	;wait for empty transmit buffer
	lds r17, UCSR0A
	sbrs r17, UDRE0
	rjmp _USART0_wait
	;put data into buffer and sends
	sts	UDR0, r16
	
	pop r17
	ret
}

PWM_init:
{
	//el pin OC0A esta en modo pwm phase correct, no invertido.
	ldi r16,(1<<COM0A1)|(0<<COM0A0)|(0<<COM0B1)|(0<<COM0B0)|(0<<WGM01)|(1<<WGM00)
	out TCCR0A,r16
	//pongo en 0 el contador del timer 0
	clr r16
	out TCNT0,r16
	//inicializo con 0 de pwm, led apagado
	out OCR0A,r16
	//habilito la interrupción por compare match con OCR0A, para cambiar el duty
	ldi r16,(1<<OCIE0A)
	sts TIMSK0,r16
	//el timer 0 tiene un prescaler de 256
	ldi r16,(0<<WGM02)|(1<<CS02)|(0<<CS01)|(0<<CS00)
	out TCCR0B,r16

	ret
}

PWM_map:
{
	push ZL
	push ZH
	push r16
	push r17

	ldi ZL, low(Tabla_PWM<<1)
	ldi ZH, high(Tabla_PWM<<1)
	lpm r17, Z
	lds r16, VAL_PWM
	inc r16
_pwm_mapping:
	dec r16
	breq _pwm_mapped
	lpm r17, Z+
	rjmp _pwm_mapping
_pwm_mapped:
	sts VAL_PWM, r17

	pop r17
	pop r16
	pop ZH
	pop ZL
	ret
}

EEPROM_read:
	; Wait for completion of previous write
	sbic EECR,EEPE
	rjmp EEPROM_read
	; Set up address (r18:r17) in address register
	out EEARH, r18
	out EEARL, r17
	; Start eeprom read by writing EERE
	sbi EECR,EERE
	; Read data from Data Register
	in r16,EEDR
	ret

Response: .db "$TDII,CHA,   *",'\n',0
Tabla_PWM: .db 0,2,5,7,10,12,15,17,20,22,25,27,30,32,35,37,40,42,45,47,50,52,55,57,60,62,65,67,70,72,75,77,80,82,85,87,90,92,95,97,100,102,105,107,110,112,115,117,120,122,125,127,130,132,135,137,140,142,145,147,150,152,155,157,160,162,165,167,170,172,175,177,180,182,185,187,190,192,195,197,200,202,205,207,210,212,215,217,220,222,225,227,230,232,235,237,240,242,245,255
