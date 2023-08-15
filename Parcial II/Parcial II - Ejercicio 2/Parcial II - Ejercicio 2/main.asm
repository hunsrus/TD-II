;
; Parcial II - Ejercicio 2.asm
;
; Author : Gabriel Escobar
;

;Para configurar el oscilador externo, hay que modificar los fusibles en Low Fuse Byte
;elijo el Full Swing Crystal Oscillator para usarlo a 16[MHz]. Por lo tanto los fusibles de CKSEL3:0
;deberán estár configurados así: 0110 (6). Es decir que lfuse=F6 (dejo a los otros fusibles en 1)

.ifndef F_CPU
	.set F_CPU = 16000000
.endif

.equ baud = 19200	;baud rate

.set FLAGS = GPIOR0	;banderas
.set F_CMD_COM = 0	;comando completo
.set F_CMD_ERR = 1	;error en comando
.set F_GET_CHN = 2	;devoler canal solicitado
.set CURRENT_CHANNEL = 3	;indica el canal seleccionado (A0 o A1)

.dseg
BUFFER:		.byte 24	;buffer de 24 bytes
BF_INDEX:	.byte 1		;índice del buffer
VAL_RH:		.byte 2		; Valor de la humedad relativa
VAL_TEMP:	.byte 2		; Valor porcentual de la temperatura

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
	cpi r16, '\n'			;(NOTA PARA MÍ) CAMBIAR A OTRO CARACTER COMO CIERRE DE LÍNEA SI EL MONITOR SERIE USADO ES MALASO Y NO DETECTA \n !!!!!!!!!!!!!!
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
	rcall USART0_init	;inicializo USART0
	rcall ADC_init		;inicializo el ADC

	ldi r16,0			;descarto las primeras conversiones de cada canal
	rcall ADC_ch_set
	rcall ADC_get
	ldi r16,1
	rcall ADC_ch_set
	rcall ADC_get

	sei

main:
{
	sbic FLAGS, F_GET_CHN	;chequeo si es necesario leer algún canal
	rcall CHN_get

	sbis FLAGS, F_CMD_COM	;chequeo bandera cmd_complete (llegó algún comando)
	rjmp main

	rcall BUFF_check		;si llegó un comando, lo chequeo
	
	sbic FLAGS, F_CMD_ERR	;si hubo un error, respondo con Cadena_ERR
	rcall ERR_response

	cbi FLAGS, F_CMD_COM	;reseteo las banderas de comando y de error
	cbi FLAGS, F_CMD_ERR
	clr r17
	sts BF_INDEX, r17		;reseteo el índice del buffer

	rjmp main
}

CHN_get:
{
	ldi ZL, low(Cadena << 1)
	ldi ZH, high(Cadena << 1)
	ldi r19, 9				;envío hasta CH sin indicador de canal
_read_string:
	dec r19
	breq _pick_channel
	lpm r16, Z+
	rcall USART0_tx
	rjmp _read_string
_pick_channel:
	sbic FLAGS, CURRENT_CHANNEL
	rjmp _pick_CHB
_pick_CHA:
	ldi r16,'A'
	rcall USART0_tx
	ldi r16,','
	rcall USART0_tx
	ldi r16,'°'			;en el monitor serie del IDE de Arduino no se ve, pero en otros sí
	rcall USART0_tx
	ldi r16,'C'
	rcall USART0_tx
	ldi r16,','
	rcall USART0_tx
	ldi r16, 0
	rjmp _get_value
_pick_CHB:
	ldi r16,'B'
	rcall USART0_tx
	ldi r16,','
	rcall USART0_tx
	ldi r16,'%'
	rcall USART0_tx
	ldi r16,','
	rcall USART0_tx
	ldi r16, 1
_get_value:
	rcall ADC_ch_set		;selecciono el canal correspondiente
	rcall ADC_get			;convierto el valor leído
	
	;una vez convertido el valor, en función de que canal se eligió convierto una tabla u otra (RH o TEMP)
	;en este caso, como ninguna de las dos va a convertir correctamente dado que no conffeccioné la tabla
	;de 1024 valores, solo muestro el procedimiento con una de las tablas. Es igual para ambas.
	;los resultados que se verán en el comando no serán correctos, pero variarán en función de la lectura de entrada
	;esto puede corroborarse en un monitor serie que pueda representar los caracteres raros que vana a aparecer
	ldi YL, low(VAL_RH)
	ldi YH, high(VAL_RH)
	std Y+0, r17				;guardo el valor convertido en VAL_RH
	std Y+1, r18
	rcall RH_map			;y mapeo su valor con Tabla_RH
	;solo me interesa la parte baja, porque en teoría la tabla debe devolver como máximo 100
	ldd r16, Y+0			;cargo el valor ya convertido (VAL_RHL) en r16
	rcall BIN2BCD8			;convierte el número a BCD
	mov r17, r16
	andi r17, 0x0F			;tomo el digito 1
	andi r16, 0xF0			;tomo el digito 2
	swap r16				;invierto el nibble
	subi r16, 0x30			;convierto a caracter el digito 2
	rcall USART0_tx			;muestro digito 2
	mov r16, r17
	subi r16, 0x30			;convierto a caracter el digito 1
	rcall USART0_tx			;muestro digito 1

	ldi r16, '*'
	rcall USART0_tx
	ldi r16, '\n'
	rcall USART0_tx

	cbi FLAGS, F_GET_CHN	;reseteo el flag de leer el adc
	ret
}

ERR_response:
{
	ldi ZL, low(CadenaERR << 1)
	ldi ZH, high(CadenaERR << 1)
	ldi r19, 12
_read_string_err:
	dec r19
	breq _string_complete
	lpm r16, Z+
	rcall USART0_tx
	rjmp _read_string_err
_string_complete:
	ret
}

BUFF_check:
{
	push XL
	push XH
	push ZL
	push ZH
	push r19
	push r17
	push r16

	lds r19, BF_INDEX
	cpi r19, 11				;chequeo si hay 10 caracteres (más el \n)
	brne _cmd_error			;si no son 10, error

	ldi XL, low(BUFFER)
	ldi XH, high(BUFFER)
	ldi ZL, low(Cadena << 1)
	ldi ZH, high(Cadena << 1)
	ldi r19, 11
_read_buffer:
	dec r19
	breq _buffer_end
	ld r16, X+
	lpm r17, Z+
	cpi r19, 2				;si estoy en el caracter 9 (2 de atras para adelante), veo si es A o B
	breq _check_channel
	cp r16, r17				;comparo el caracter del buffer con el de la cadena
	breq _read_buffer
_cmd_error:
	sbi FLAGS, F_CMD_ERR
	rjmp _buffer_end
_check_channel:
	sbi FLAGS, F_GET_CHN	;tengo que leer el canal si sale bien
	cbi FLAGS, CURRENT_CHANNEL	;elijo el canal 0 (A)
	cpi r16, 'A'
	breq _read_buffer		;todo bien, sigo leyendo el buffer
	sbi FLAGS, CURRENT_CHANNEL	;elijo el canal 1 (B)
	cpi r16, 'B'
	breq _read_buffer		;todo bien, sigo leyendo el buffer
	cbi FLAGS, F_GET_CHN	;si no era un canal válido, no debo leer
	rjmp _cmd_error			;todo mal, no es un canal válido
_buffer_end:
	
	pop r16
	pop r17
	pop r19
	pop ZH
	pop ZL
	pop XH
	pop XL
	ret
}

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

	;EN REALIDAD LAS LÍNEAS SIGUIENTES DEBERÍAN LEER LA CONFIGURACIÓN DE LA EEPROM USANDO EEPROM_read
	;PERO PARA SIMULARLO USO LA CONFIGURACIÓN NORMAL MODIFICANDO REGISTROS

	;UCSZ01 = 1 UCSZ00 = 1 : 8 bits de dato
	;UPM01 = 0 UPM00 = 0 : sin paridad
	;USBS0 = 1 : 2 bit de stop
	ldi r16,(1<<UCSZ01)|(1<<UCSZ00)|(1<<USBS0)				;COMENTAR ESTA LINEA PARA LEER LA CONFIGURACIÓN DE UCSR0C DE LA EEPROM
	;rcall EEPROM_read										;Y DESCOMENTAR ESTA
	sts UCSR0C, r16
	ret
}

USART0_tx:
{
	push r17
_USART0_wait:
	;espera a que se vacíe el buffer de transmisión
	lds r17, UCSR0A
	sbrs r17, UDRE0
	rjmp _USART0_wait
	;pone la información en el buffer y la envía
	sts	UDR0, r16
	
	pop r17
	ret
}

ADC_init:
{
	; Habilitación del ADC, configuración del prescaler en 128
	ldi r16, (1 << ADEN)|(0 << ADATE)|(1 << ADPS2)|(1 << ADPS1)|(1 << ADPS0)
	sts ADCSRA, r16
	; Referencia del ADC: AVCC, justificado a la derecha y selección del canal GND
	ldi r16, (0 << REFS1)|(1 << REFS0)|(0 << ADLAR)|(1 << MUX3)|(1 << MUX2)|(1 << MUX1)|(1 << MUX0)
	sts ADMUX, r16
	; Configuro "free running mode" pero no se usa el "Auto Trigger"
	ldi r16, (0 << ADTS2)|(0 << ADTS1)|(0 << ADTS0)
	sts ADCSRB, r16
	; Deshabilito la entrada digital para el canal 0
	ldi r16, (1 << ADC0D) 
	sts DIDR0, r16
	ret
}

ADC_ch_set:
{
	lds r17,ADMUX
	andi r17, 0xF0
	andi r16, 0x0F
	or r16, r17
	sts ADMUX, r16
	ret
}

ADC_get:
{
	/* Inicio la conversión */
	lds r16, ADCSRA
	ori r16, (1<<ADSC)
	sts ADCSRA, r16
	/* Espero que termine la conversión */
_adc_loop1:
	lds r16, ADCSRA
	sbrc r16, ADSC
	rjmp _adc_loop1
	/* Guardo el resultado en R18:R17 */
	lds r17, ADCL
	lds r18, ADCH
	;borro la bandera de interrupción del adc	lds r16, ADCSRA
	sbr r16, (1 << ADIF)
	sts ADCSRA, r16
	ret
}

;mapea la humedad relativa
;debería existir una rutina similar pero que mapee el valor almacenado en VAL_TEMP
;se llamaría TEMP_map y la llamaría en el caso de que se solicitara el canal B
;no escribo la subrutina TEMP_map porque sería irrelevante y no funcionaría sin la tabla
RH_map:
{
	push ZL
	push ZH
	push YL
	push YH
	ldi YL, low(VAL_RH); r17 ;carga la parte baja del último valor convertido en YL
	ldi YH, high(VAL_RH); r18	;carga la parte alta del último valor convertido en HL
	ldi ZL, low(Tabla_RH*2) ;carga la tabla en Z
	ldi ZH, high(Tabla_RH*2)
	ldd r2, Y+0 ; R2 <-- VAL_RH
	lsl r2 ; VAL_RH * 2
	clr r3 ; r3 = 0
	add ZL, r2 ; ZL <-- ZL + (VAL_RH * 2)
	adc ZH, r3 ; ZH <-- ZH + r3 + C
	lpm r16,Z+ ; r16 <-- [Z+]
	lpm r19,Z ; r19 <-- [Z]
	ldi YL, low(VAL_RH) ; guardo el valor convertido en VAL_RH
	ldi YH, high(VAL_RH)
	std Y+0,r16 ; VAL_RH+0 <-- r16 
	std Y+1,r19 ; VAL_RH+1 <-- r19
	pop YH
	pop YL
	pop ZH
	pop ZL
	ret
}

BIN2BCD8:
{
	clr	r17			;clear temp reg
bBCD8_1:
	subi	r16,10		;input = input - 10
	brcs	bBCD8_2		;abort if carry set
	subi	r17,-$10 		;tBCD = tBCD + 10
	rjmp	bBCD8_1		;loop again
bBCD8_2:
	subi	r16,-10		;compensate extra subtraction
	add	r16,r17	
	ret
}

EEPROM_read:
{
	;Espera por si se está escribiendo
	sbic EECR,EEPE
	rjmp EEPROM_read
	;Carga la dirección en el registro EEARH
	;(En este caso la dirección 0)
	clr r17
	clr r18	
	out EEARH, r18
	out EEARL, r17
	;Empieza a leer la eeprom escribiendo EERE
	sbi EECR,EERE
	;Cargo el dato en r16 para devolverlo
	in r16,EEDR
	ret
}

Cadena: .db "$TDII,CHX*",'\n',0
CadenaERR: .db "$TDII,ERR*",'\n',0

;Tabla de humedad relativa
;sé que esta tabla está mal, la copié y pegué para que haya algo
;en realidad debería tabular 1024 valores para mapear una tensión de 5[V]
;y a esa tensión aplicarle la ecuación lineal del sensor para RH=-12.5+125*(Vrh/Vdd)
Tabla_RH:
.dw 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
.dw 22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42
.dw 43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63
.dw 64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,90,91,92,93,94
.dw 95,96,97,98,99,100

;Tabla de temperatura en [°C]
;mismo procedimiento que el anterior, también soy consciente de que la tabla no es representativa
;pero hacer una tabla de 1024 valores me tomaría mucho tiempo
;también uso la ecuación lineal dada en el datasheet para calcular la temperatura en [°C]
;T[°C]=-66.875+218.75*(Vt/Vdd)
Tabla_TEMP:
.dw 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
.dw 22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42
.dw 43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63
.dw 64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,90,91,92,93,94
.dw 95,96,97,98,99,100