;

; TPNro13.2.asm

;

;************************************

; Técnicas Digitales II 

; Autor: GM

; Fecha: 16-09-2016

; version: 0.1

; for AVR: atmega328p (Arduino UNO)

; clock frequency: 16MHz 

;************************************



;===========================================

; Función del programa

; Configurar el Timer 0 para que interrumpa 

; cada 1 mseg (por desborde) y hacer

; titilar un LED en PB.5 cada 700 mseg (es

; decir, 700 mseg OFF y 700 mseg ON) sólo 

; si esta presionado un pulsador en PB.2

;-------------------------------------------

.ifndef F_CPU

.set F_CPU = 16000000

.endif

;===========================================

; Declarations for register

.def temp = r16

.def blink = r17



;===========================================

; Declarations for label

.set Flags0 = GPIOR0

.set BlinkLED = $0



;===========================================

; Data Segment

.dseg

BaseTime1ms: .byte 1

BaseTime100ms: .byte 1



;===========================================

; EEPROM Segment

.eseg

VAR_EEPROM: .db $AA



;===========================================

; Code Segment

.cseg

.org RWW_START_ADDR       ; memory (PC) location of reset handler

rjmp Reset           ; jmp costs 2 cpu cycles and rjmp costs only 1

                          ; so unless you need to jump more than 8k bytes

                          ; you only need rjmp. Some microcontrollers therefore only 

                          ; have rjmp and not jmp



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

reti ; Timer/Counter0 Compare Match A Interrupt  



isr_OC0B_handler:

reti ; Timer/Counter0 Compare Match B Interrupt  



isr_OVF0_handler:

push temp

ldi temp,6

out TCNT0,temp

lds temp, BaseTime1ms

inc temp

cpi temp,100

brne notime

lds r18,BaseTime100ms

inc r18

sts BaseTime100ms,r18

ldi temp, 0

notime:

sts BaseTime1ms, temp

pop temp

reti ; Timer0 overflow interrupt  



isr_SPI_handler:

reti ; SPI Serial Transfer Complete interrupt  



isr_URXC_handler:

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

; write your code here



call Init_Port ; Modificado respecto al punto 13.1a

call Init_Timer0

clr temp

out Flags0,temp

sei



Loop:

call CheckTimers ; Proceso el Timers



sbic Flags0,BlinkLED  

call ProcessAPP ; Proceso la aplicación --> Modificado respecto al punto 13.1a



rjmp Loop ; Volver al inicio

 

;===========================================

; CheckStatus

; Controla que haya transcurrido el tiempo

; de 700 mseg

CheckTimers:

lds temp,BaseTime100ms

cpi temp,0x07 ; Comparo si llego a 7 BaseTime100ms

brne NoAccion

in temp, Flags0 ; Si llegó!

sbr temp, (1 << BlinkLED) ; BlinkLED = 1 en Flags0

out Flags0, temp

ldi temp,0

sts BaseTime100ms,temp ; Borro BaseTime100ms

NoAccion:

ret



;===========================================

; ProcessAPP

; Realiza la acción de la aplicación

; conmutar el puerto PB.5 sólo si esta

; presionado el pulsador en PB.2

ProcessAPP:

sbic PINB,2 ; PINB.2 == 0?

rjmp noApp



in temp,PORTB

ldi blink,0x20

eor temp,blink ; Conmuto el valor del puerto

out PORTB,temp

in temp, Flags0

cbr temp, (1 << BlinkLED) ; Borro BlinkLED in Flags0

out Flags0, temp



noApp:

ret

  

;===========================================

; Init_Timer0

; Inicia el Timer 0 para que desborde cada

; 1 mseg

Init_Timer0:

;Establecer Modo NORMAL del Timer (Sin PWM)

in temp, TCCR0A

cbr temp, (1 << COM0A1)|(1 << COM0A0)|(1 << COM0B1)|(1 << COM0B0)|(1 << WGM01)|(1 << WGM00)

out TCCR0A, temp

in temp, TCCR0B

cbr temp, (1 << WGM02)

out TCCR0B, temp

; Activar la interrupción por OVERFLOW

lds temp, TIMSK0

sbr temp, (1 << TOIE0)

sts TIMSK0, temp



; Establecer el valor inicial del Timer TCNT0

ldi temp,6

out TCNT0,temp



; Iniciar el Timer (prescaler %64)

in temp, TCCR0B

sbr temp, (1 << CS01)|(1 << CS00)

cbr temp, (1 << CS02)

out TCCR0B, temp



ret



;===========================================

; Init_Port

; Inicia el Puerto PB.5 como salida

; Inicia el Puerto PB.2 como entrada

Init_Port:

in temp, DDRB

sbr temp, (1 << DDB5) ; PB.5 como Salida

cbr temp, (1 << DDB2) ; PB.2 como entrada

out DDRB, temp



in temp, PORTB

sbr temp, (1 << PORTB5)

out PORTB, temp

ret