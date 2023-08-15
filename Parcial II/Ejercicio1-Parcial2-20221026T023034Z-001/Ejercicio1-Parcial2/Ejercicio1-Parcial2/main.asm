;
; Ejercicio1-Parcial2.asm
;
; Created: 24/10/2022 4:54:32
; Author : Lautaro Ezequiel Ubiedo
;


; Replace with your application code
.ifndef F_CPU
.set F_CPU = 16000000
.endif

;===========================================
; Declarations for register
.def temp = r16
.def overflows = r17

;===========================================
; Declarations for label
.set FLAGS0 = GPIOR0
.set COMM_PC = 0
.set COMM_Rsp = 1
.set UpdateOCR0A = 2

;===========================================
; Data Segment
.dseg
CadenaRp: .db "$TDII,CHA,%" 
//Dejando 3 lugares para el número, en total son 16bytes
pwm_table: .db 0,2,5,7,10,12,15,17,20,22,25,27,30,32,35,37,40,42,45,47,50,52,55,57,60,62,65,67,70,72,75,77,80,82,85,87,90,92,95,97,100,102,105,107,110,112,115,117,120,122,125,127,130,132,135,137,140,142,145,147,150,152,155,157,160,162,165,167,170,172,175,177,180,182,185,187,190,192,195,197,200,202,205,207,210,212,215,217,220,222,225,227,230,232,235,237,240,242,245,255
VAL_PWM: .byte 1 //valor del PWM en %
Temp_OCR0A: .byte 1 //Valor temporal del registro OCR0A
BCDR0: .byte 1
BCDR1: .byte 1
BCDR2: .byte 1
BCDdigit: .byte 1
indexRx: .byte 1 //índice dentro del buffer de recepción
BUFFER: .byte 35 //buffer de datos de tx/rx a/desde la PC

;===========================================
; Code Segment
.cseg
.org RWW_START_ADDR       ; memory (PC) location of reset handler
rjmp Reset           

.org INT0addr ; memory location of External Interrupt Request 0
rjmp isr_INT0_handler ; go here if a External Interrupt 0 occurs 

.org INT1addr ; memory location of External Interrupt Request 1
rjmp isr_INT1_handler ; go here if a External Interrupt 1 occurs 

.org PCI0addr ; memory location of Pin Change Interrupt Request 0
rjmp isr_PCI0_handler ; go here if a Pin Change Interrupt 0 occurs 

.org PCI1addr ; memory location of Pin Change Interrupt Request 1
rjmp isr_PCI1_handler ; go here if a Pin Change Interrupt 1 occurs 

.org PCI2addr ; memory location of Pin Change Interrupt Request 2
rjmp isr_PCI2_handler ; go here if a Pin Change Interrupt 2 occurs 

.org WDTaddr ; memory location of Watchdog Time-out Interrupt
rjmp isr_WDT_handler ; go here if a Watchdog Time-out Interrupt occurs 

.org OC2Aaddr ; memory location of Timer/Counter2 Compare Match A Interrupt
rjmp isr_OC2A_handler ; go here if a Timer/Counter2 Compare Match A Interrupt occurs 

.org OC2Baddr ; memory location of Timer/Counter2 Compare Match B Interrupt
rjmp isr_OC2B_handler ; go here if a Timer/Counter2 Compare Match B Interrupt occurs 

.org OVF2addr ; memory location of Timer/Counter2 Overflow Interrupt
rjmp isr_OVF2_handler ; go here if a Timer/Counter2 Overflow Interrupt occurs 

.org ICP1addr ; memory location of Timer/Counter1 Capture Event Interrupt
rjmp isr_ICP1_handler ; go here if a Timer/Counter1 Capture Event Interrupt occurs 

.org OC1Aaddr ; memory location of Timer/Counter1 Compare Match A Interrupt
rjmp isr_OC1A_handler ; go here if a Timer/Counter1 Compare Match A Interrupt occurs 

.org OC1Baddr ; memory location of Timer/Counter1 Compare Match B Interrupt
rjmp isr_OC1B_handler ; go here if a Timer/Counter1 Compare Match B Interrupt occurs 

.org OVF1addr ; memory location of Timer/Counter1 Overflow Interrupt
rjmp isr_OVF1_handler ; go here if a Timer/Counter1 Overflow Interrupt occurs 

.org OC0Aaddr ; memory location of Timer/Counter0 Compare Match A Interrupt
rjmp isr_OC0A_handler ; go here if a Timer/Counter0 Compare Match A Interrupt occurs 

.org OC0Baddr ; memory location of Timer/Counter0 Compare Match B Interrupt
rjmp isr_OC0B_handler ; go here if a Timer/Counter0 Compare Match B Interrupt occurs 

.org OVF0addr               ; memory location of Timer0 overflow handler
rjmp isr_OVF0_handler ; go here if a timer0 overflow interrupt occurs 

.org SPIaddr               ; memory location of SPI Serial Transfer Complete handler
rjmp isr_SPI_handler ; go here if a SPI Serial Transfer Complete interrupt occurs 

.org URXCaddr               ; memory location of USART Rx Complete handler
rjmp isr_URXC_handler ; go here if a USART Rx Complete interrupt occurs 

.org UDREaddr               ; memory location of USART, Data Register Empty handler
rjmp isr_UDRE_handler ; go here if a USART, Data Register Empty interrupt occurs 

.org UTXCaddr               ; memory location of USART Tx Complete handler
rjmp isr_UTXC_handler ; go here if a USART Tx Complete interrupt occurs 

.org ADCCaddr               ; memory location of ADC Conversion Complete handler
rjmp isr_ADCC_handler ; go here if a ADC Conversion Complete interrupt occurs 

.org ERDYaddr               ; memory location of EEPROM Ready handler
rjmp isr_ERDY_handler ; go here if a EEPROM Ready interrupt occurs 

.org ACIaddr               ; memory location of Analog Comparator handler
rjmp isr_ACI_handler ; go here if a Analog Comparator interrupt occurs 

.org TWIaddr               ; memory location of Two-wire Serial Interface handler
rjmp isr_TWI_handler ; go here if a Two-wire Serial Interface interrupt occurs 

.org SPMRaddr               ; memory location of Store Program Memory Read handler
rjmp isr_SPMR_handler ; go here if a Store Program Memory Read interrupt occurs 

;===========================================
; interrupt service routines  
isr_INT0_handler:
reti ; External Interrupt 0

isr_INT1_handler:
reti ; External Interrupt 1 

isr_PCI0_handler:
reti ; Pin Change Interrupt 0 

isr_PCI1_handler:
reti ; Pin Change Interrupt 1 

isr_PCI2_handler:
reti ; Pin Change Interrupt 2 

isr_WDT_handler:
reti ; Watchdog Time-out Interrupt  

isr_OC2A_handler:
reti ; Timer/Counter2 Compare Match A Interrupt  

isr_OC2B_handler:
reti ; Timer/Counter2 Compare Match B Interrupt  

isr_OVF2_handler:
reti ; Timer/Counter2 Overflow Interrupt  

isr_ICP1_handler:
reti ; Timer/Counter1 Capture Event Interrupt  

isr_OC1A_handler:
reti ; Timer/Counter1 Compare Match A Interrupt  

isr_OC1B_handler:
reti ; Timer/Counter1 Compare Match B Interrupt  

isr_OVF1_handler:
reti ; Timer/Counter1 Overflow Interrupt  

isr_OC0A_handler:
in r5,SREG
push r5
push r16
push YL
push YH

sbis FLAGS0,UpdateOCR0A //veo si hay que modificar el duty
rjmp salir
ldi YL,low(Temp_OCR0A)
ldi YH,high(Temp_OCR0A)
ldd r16,Y+0
//lds r16, Temp_OCR0A
out OCR0A, r16
cbi FLAGS0, UpdateOCR0A //como ya actualice el registro reseteo el flag
sbi FLAGS0, COMM_Rsp //Debo informar el cambio

salir:
pop YH
pop YL
pop r16
pop r5
out SREG,r5
reti ; Timer/Counter0 Compare Match A Interrupt  

isr_OC0B_handler:
reti ; Timer/Counter0 Compare Match B Interrupt  

isr_OVF0_handler:
reti ; Timer0 overflow interrupt  

isr_SPI_handler:
reti ; SPI Serial Transfer Complete interrupt  

isr_URXC_handler:
in r5,SREG
push r5
push r16
push r25
push XH
push XL

ldi XL, low(BUFFER)
ldi XH, high(BUFFER)

lds r16, UDR0
cpi r16, '$'
brne _noini
_ini:
clr r25
sts indexRx, r25
_noini:
lds r25, indexRx
add XL, r25
st X,r16
inc r25
sts indexRx, r25

pop XL
pop XH
pop r25
pop r16
; Restore global interrupt flag
pop r5
out SREG,r5
reti ; USART Rx Complete interrupt  

isr_UDRE_handler:
reti ; USART, Data Register Empty interrupt  

isr_UTXC_handler:
reti ; USART Tx Complete interrupt  

isr_ADCC_handler:
reti ; ADC Conversion Complete interrupt  

isr_ERDY_handler:
reti ; EEPROM Ready interrupt  

isr_ACI_handler:
reti ; Analog Comparator interrupt  

isr_TWI_handler:
reti ; Two-wire Serial Interface interrupt  

isr_SPMR_handler:
reti ; Store Program Memory Read interrupt  

;===========================================
; Main body of program:

Reset:

ldi R16, LOW(RAMEND)     ; Lower address byte RAM byte lo.
out SPL, R16         ; Stack pointer initialise lo.
ldi R16, HIGH(RAMEND)   ; Higher address of the RAM byte hi.
out SPH, R16 ; Stack pointer initialise hi. 
rjmp Setup

; write your code here

Setup:
	cli
	ldi r18,0x00
	ldi r17,0x00
	rcall EEPROM_read
	rcall USART_Init
	rcall init_PWM
	//declaro el pin D6 (6) como salida
	ldi r16,0x40
	out DDRD,r16
	cbi PORTD,6
	sei
	rjmp Loop


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

USART_Init:
		//	b7	b6	b5	b4	b3	b2	b1	b0
		//	BR2	BR1	BR0	D1	D0	P1	P0	SB
		//BR2:0 me dicen el baudrate
		//D1:0 me dicen los bits de dato
		//P1:P0 me dicen la paridad
		//SB me dice el bit de stop
		ldi r17, 0xE0
		and r17,r16  //enmascaro los tres bits mas significativos que tienen la información del baudrate
		rcall set_baudrate
		//habilito la transmisión y la recepción, habilito la interrupción por recepción RXC0
		ldi r18, (1<<TXEN0)|(1<<RXEN0)|(1<<RXCIE0)
		sts UCSR0B, r18
		ldi r17,0x18  //enmascaro los bits 4 y 3 que me dicen los bits de dato a usar
		and r17,r16
		clr r18
		rcall set_databits
		ldi r17,0x06 //enmascaro los bits 2 y 1 que me dicen la paridad
		and r17,r16
		rcall set_parity
		ldi r17,0x01 //enmascaro el bits 0 que me dicen el bit de stop
		and r17,r16
		rcall set_stopbit
		//en el registro r18 tengo la configuración de los bits de dato, la paridad y el bit de stop
		sts UCSR0C, r18
		ret

set_baudrate:
		cpi r17,0x00  //baudrate=2400-000
		brne baudrate1
		//seteo el baudrate 2400
		ldi r18, 0x00
		sts UBRR0H, r18
		ldi r18, 0xCF
		sts UBRR0L, r18
		ret
		//------------------------------
		baudrate1:
		cpi r17,0x20  //baudrate=4800-001
		brne baudrate2
		//seteo el baudrate 4800
		ldi r18, 0x00
		sts UBRR0H, r18
		ldi r18, 0x67
		sts UBRR0L, r18
		ret
		//------------------------------
		baudrate2:
		cpi r17,0x40  //baudrate=9600-010
		brne baudrate3
		//seteo el baudrate 9600
		ldi r18, 0x00
		sts UBRR0H, r18
		ldi r18, 0x67//0x33
		sts UBRR0L, r18
		ret
		//------------------------------
		baudrate3:
		cpi r17,0x60  //baudrate=14400-011
		brne baudrate4
		//seteo el baudrate 14400
		ldi r18, 0x00
		sts UBRR0H, r18
		ldi r18, 0x22
		sts UBRR0L, r18
		ret
		//------------------------------
		baudrate4:
		cpi r17,0x80 //baudrate=19200-100
		brne baudrate5
		//seteo el baudrate 19200
		ldi r18, 0x00
		sts UBRR0H, r18
		ldi r18, 0x19
		sts UBRR0L, r18
		ret
		//------------------------------
		baudrate5:
		cpi r17,0xA0  //baudrate=28800-101
		brne baudrate6
		//seteo el baudrate 28800
		ldi r18, 0x00
		sts UBRR0H, r18
		ldi r18, 0x10
		sts UBRR0L, r18
		ret
		//------------------------------
		baudrate6:
		cpi r17,0xC0	//baudrate=38400-110
		brne baudrate7
		//seteo el baudrate 38400
		ldi r18, 0x00
		sts UBRR0H, r18
		ldi r18, 0x0C
		sts UBRR0L, r18
		ret
		//------------------------------
		baudrate7:
		//seteo el baudrate 57600-111
		ldi r18, 0x00
		sts UBRR0H, r18
		ldi r18, 0x08
		sts UBRR0L, r18
		ret

set_databits:
		cpi r17,0x00
		brne databits6
		//uso 5 bits de dato
		ldi r18,(0<<UCSZ01)|(0<<UCSZ00)
		ret
		//-------------------------------
		databits6:
		cpi r17,0x08
		brne databits7
		//uso 6 bits de dato
		ldi r18,(0<<UCSZ01)|(1<<UCSZ00)
		ret
		//-------------------------------
		databits7:
		cpi r17,0x10
		brne databits8
		//uso 7 bits de dato
		ldi r18,(1<<UCSZ01)|(0<<UCSZ00)
		ret
		//-------------------------------
		databits8:
		//uso 8 bits de dato
		ldi r18,(1<<UCSZ01)|(1<<UCSZ00)
		ret

set_parity:
		cpi r17,0x00
		brne odd
		//sin paridad
		ori r18,(0<<UPM01)|(0<<UPM00)
		ret
		//-----------------------------
		odd:
		cpi r17,0x02
		brne even
		//paridad impar
		ori r18,(1<<UPM01)|(1<<UPM00)
		ret
		//-----------------------------
		even:
		//paridad par
		ori r18,(1<<UPM01)|(0<<UPM00)
		ret

set_stopbit:
		cpi r17,0x00
		brne two
		//1 bit de stop
		ori r18,(0<<USBS0)
		ret
		//------------------
		two:
		//2 bits de stop
		ori r18,(1<<USBS0)
		ret

init_PWM:
		//el pin OC0A esta en modo pwm phase correct, no invertido.
		ldi r16,(1<<COM0A1)|(0<<COM0A0)|(0<<COM0B1)|(0<<COM0B0)|(0<<WGM01)|(1<<WGM00)
		out TCCR0A,r16
		//pongo en 0 el contador del timer 0
		clr r16
		out TCNT0,r16
		//inicializo con 0 de pwm, led apagado
		ldi r16, 127
		out OCR0A,r16
		//habilito la interrupción por compare match con OCR0A, para cambiar el duty
		ldi r16,(1<<OCIE0A)
		sts TIMSK0,r16
		//el timer 0 tiene un prescaler de 256
		ldi r16,(0<<WGM02)|(1<<CS02)|(0<<CS01)|(0<<CS00)
		out TCCR0B,r16
		ret

Loop:
	rcall Get_COMM_PC	//Veo si llegó un comando
	sbic FLAGS0,COMM_PC	//Si no llegó no hago nada
	rcall Procesamiento //Si llegó lo proceso
	rjmp Loop

Procesamiento:
	call PWM_bcd_to_bin
	call Escalar_PWM
	sbic FLAGS0,COMM_Rsp
	call Send_Rsp
	ret

Get_COMM_PC: //detecta si llego un comando por la USART
	lds r16, indexRx
	//cargo el índice y me fijo si llegaron 13, 14 o 15 caracteres
	//de ser así, tengo un comando, sino no.
	cpi r16,13
	breq dato1
	cpi r16,0x0E
	breq dato2
	cpi r16,15
	breq dato3
	rjmp nodata
	dato1://tenemos 1 numero
		//el puntero Y apunta al buffer de datos
		rcall Verify
		cpi r24,0xFF
		breq errores
		ldi r19,0x01 //guardo la cantidad de numeros
		ldd r16,Y+11 //guardo el numero
		andi r16,0x0F //con esto paso de un ascii a bcd
		sts BCDR0,r16 //el bcd lo guardo en BCDR0
		ldd r16,Y+12
		cpi r16,'*'
		brne errores
		rjmp no_hay_error
	dato2: //tenemos 2 numeros
	ldi r20,0xff
	out DDRD,r20
	sbi PORTD,7
		rcall Verify
		cpi r24,0xFF
		breq errores
		ldi r19,0x02 //guardo la cantidad de numeros
		ldd r16,Y+11 //guardo el primer numero
		andi r16,0x0F //con esto paso de un ascii a bcd
		sts BCDR1,r16 //el bcd lo guardo en BCDR1
		ldd r16,Y+12
		andi r16,0x0F
		sts BCDR0,r16//guardo el segundo numero en BCDR0
		ldd r16,Y+13
		cpi r16,'*'
		brne errores
		rjmp no_hay_error
	dato3:
		rcall Verify
		cpi r24,0xFF
		breq errores
		ldi r19,0x02 //guardo la cantidad de numeros
		ldd r16,Y+11 //guardo el primer numero
		andi r16,0x0F //con esto paso de un ascii a bcd
		sts BCDR2,r16 //el bcd lo guardo en BCDR2
		ldd r16,Y+12
		andi r16,0x0F
		sts BCDR1,r16 //guardo el segundo numero en BCDR1
		ldd r16,Y+13
		andi r16,0x0F
		sts BCDR0,r16 //guardo el tercer numero en BCDR0
		ldd r16,Y+14
		cpi r16,'*'
		brne errores
		rjmp no_hay_error
	errores:
		ldi r16,0
		sts indexRx,r16
		sts BCDR0,r16
		sts BCDR1,r16
		sts BCDR2,r16
		cbi FLAGS0, COMM_Rsp
		cbi FLAGS0, COMM_PC
		cbi FLAGS0,UpdateOCR0A	
		ret
	no_hay_error:
		sts BCDdigit,r19
		ldi r16,0
		sts indexRx,r16
		sbi FLAGS0, COMM_Rsp
		sbi FLAGS0, COMM_PC
		sbi FLAGS0,UpdateOCR0A
		nodata:
		ret

Verify:
		ldi YL,low(BUFFER)
		ldi YH,high(BUFFER)
		ld r16,Y //cargo el primer caracter del buffer
		cpi r16,'$' //veo si llego $
		brne error
		ldd r16,Y+1
		cpi r16,'T'
		brne error
		ldd r16,Y+2
		cpi r16,'D'
		brne error
		ldd r16,Y+3
		cpi r16,'I'
		brne error
		ldd r16,Y+4
		cpi r16,'I'
		brne error
		ldd r16,Y+5
		cpi r16,','
		brne error
		ldd r16,Y+6
		cpi r16,'C'
		brne error
		ldd r16,Y+7
		cpi r16,'H'
		brne error
		ldd r16,Y+8
		cpi r16,'A'
		brne error
		ldd r16,Y+9
		cpi r16,','
		brne error
		ldd r16,Y+10
		cpi r16,'%'
		brne error
		clr r24
		ret
		error:
			ldi r24,0xFF
			ret


Send_Rsp: //Envia la CadenaRp al buffer
		ldi r21,0x00
		enviar_dato:
		rcall Tx_Byte_USART0
		cpi r21,0x11
		brne enviar_dato
		cbi FLAGS0,COMM_Rsp
		ret


Tx_Byte_USART0:
		lds r17,UCSR0A
		sbrs r17,UDRE0
		rjmp Tx_Byte_USART0
		cpi r21,0x00
		brne symbol1
		ldi r22,'$'
		sts UDR0,r22
		ldi r21,0x01
		ret
		symbol1:
			cpi r21,0x01
			brne symbol2
			ldi r22,'T'
			sts UDR0,r22
			ldi r21,0x02
			ret
		symbol2:
			cpi r21,0x02
			brne symbol4
			ldi r22,'D'
			sts UDR0,r22
			ldi r21,0x04
			ret
		symbol4:
			cpi r21,0x04
			brne symbol5
			ldi r22,'I'
			sts UDR0,r22
			ldi r21,0x05
			ret
		symbol5:
			cpi r21,0x05
			brne symbol6
			ldi r22,'I'
			sts UDR0,r22
			ldi r21,0x06
			ret
		symbol6:
			cpi r21,0x06
			brne symbol7
			ldi r22,','
			sts UDR0,r22
			ldi r21,0x07
			ret
		symbol7:
			cpi r21,0x07
			brne symbol8
			ldi r22,'C'
			sts UDR0,r22
			ldi r21,0x08
			ret
		symbol8:
			cpi r21,0x08
			brne symbol9
			ldi r22,'H'
			sts UDR0,r22
			ldi r21,0x09
			ret
		symbol9:
			cpi r21,0x09
			brne symbol10
			ldi r22,'A'
			sts UDR0,r22
			ldi r21,0x0A
			ret
		symbol10:
			cpi r21,0x0A
			brne symbol11
			ldi r22,','
			sts UDR0,r22
			ldi r21,0x0B
			ret
		symbol11:
			cpi r21,0x0B
			brne symbol12
			ldi r22,'%'
			sts UDR0,r22
			ldi r21,0x0C
			ret
		symbol12:
			cpi r21,0x0C
			brne symbol13
			ldi YL,low(BCDdigit)
			ldi YH,high(BCDdigit)
			ld r22,Y
			cpi r22,0x03
			brne son_dos
			ldi YL,low(BCDR2)
			ldi YH,high(BCDR2)
			ld r22,Y
			ori r22,0x30
			sts UDR0,r22
			ldi r21,0x0D
			ret
			son_dos:
				cpi r22,0x02
				brne es_uno
				ldi YL,low(BCDR1)
				ldi YH,high(BCDR1)
				ld r22,Y
				ori r22,0x30
				sts UDR0,r22
				ldi r21,0x0D
				ret
				es_uno:
					ldi YL,low(BCDR0)
					ldi YH,high(BCDR0)
					ld r22,Y
					ori r22,0x30
					sts UDR0,r22
					ldi r21,0x0F
					ret
		symbol13:
			cpi r21,0x0D
			brne symbol14
			ldi YL,low(BCDdigit)
			ldi YH,high(BCDdigit)
			ld r22,Y
			cpi r22,0x02
			brne queda_uno
			ldi YL,low(BCDR0)
			ldi YH,high(BCDR0)
			ld r22,Y
			ori r22,0x30
			sts UDR0,r22
			ldi r21,0x0F
			ret
			queda_uno:
				ldi YL,low(BCDR1)
				ldi YH,high(BCDR1)
				ld r22,Y
				ori r22,0x30
				sts UDR0,r22
				ldi r21,0x0E
				ret
		symbol14:
			cpi r21,0x0E
			brne symbol15
			ldi YL,low(BCDR0)
			ldi YH,high(BCDR0)
			ld r22,Y
			ori r22,0x30
			sts UDR0,r22
			ldi r21,0x0F
			ret
		symbol15:
			cpi r21,0x0F
			brne symbol16
			ldi r22,'*'
			sts UDR0,r22
			ldi r21,0x10
			ret
		symbol16:
			ldi r22,'\n'
			sts UDR0,r22
			ldi r21,0x11
		ret

PWM_bcd_to_bin: //Conviernte el valor de pwm bcd en binario
		push ZL
		push ZH
		push YL
		push YH

		ldi YL,low(BCDdigit)
		ldi YH,high(BCDdigit)
		ldi ZL,low(VAL_PWM)
		ldi ZH,high(VAL_PWM)
		ld r16,Y
		cpi r16,3
		breq convert3
		cpi r16,2
		breq convert2
			ldi YL,low(BCDR0)
			ldi YH,high(BCDR0)
			ld r16,Y
			st Z,r16
			rjmp exit
		convert2:
			ldi YL,low(BCDR1)
			ldi YH,high(BCDR1)
			ld r16,Y
			ldi r17,0x0A
			mul r16,r17
			mov r17,r0  //tengo la decena en r17
			ldi YL,low(BCDR0)
			ldi YH,high(BCDR0)
			ld r16,Y  //tengo la unidad en r16
			add r16,r17 //sumo r16+r17 para tener el numero completo
			st Z,r16
			rjmp exit
		convert3:
			ldi YL,low(BCDR2)
			ldi YH,high(BCDR2)
			ld r16,Y
			ldi r17,0x64
			mul r16,r17
			mov r18,r0  //tengo la centena en r18
			ldi YL,low(BCDR1)
			ldi YH,high(BCDR1)
			ld r16,Y
			ldi r17,0x0A
			mul r16,r17
			mov r17,r0  //tengo la decena en r17
			ldi YL,low(BCDR0)
			ldi YH,high(BCDR0)
			ld r16,Y  //tengo la unidad en r16
			add r16,r17 //sumo r16+r17+r18 para tener el numero completo
			add r16,r18
			st Z,r16
			exit:
			pop YH
			pop YL
			pop ZH
			pop ZL
			ret

Escalar_PWM:
		push ZL
		push ZH
		push YL
		push YH

		ldi YL,low(VAL_PWM)
		ldi YH,high(VAL_PWM)
		ldi ZL,low(pwm_table)
		ldi ZH,high(pwm_table)
		ldd r2,Y+0
		clr r3
		add ZL, r2
		adc ZH, r3
		ldi YL,low(Temp_OCR0A)
		ldi YH,high(Temp_OCR0A)
		ldd r16,Z+0
		std Y+0,r16

		pop YH
		pop YL
		pop ZH
		pop ZL
		ret	