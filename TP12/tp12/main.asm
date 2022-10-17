;
; TPNro14.1.asm
;
;************************************
; Técnicas Digitales II 
; Autor: GM
; Fecha: 3-07-2017
; version: 0.1
; for AVR: atmega328p (Arduino UNO)
; clock frequency: 16MHz 
;************************************

;===========================================
; Función del programa
; Debe convertir el canal analógico AN0 y 
; mostrar, en un display de 7 segmentos,
; el rango de la señal analógica. El display
; mostrara 1, 2, 3 o 4 y los rangos son:
; [0,255), [255, 511), [511,767) y [767,1023].
;-------------------------------------------

.ifndef F_CPU
.set F_CPU = 16000000
.endif

;===========================================
; Declarations for register
.def temp = r16
.def temp1 = r17

;===========================================

; Declarations for label
.set Flags0 = GPIOR0
.set BlinkLED = $0
.set Blink_LefRig = $1 ; LEFT = 0

;===========================================
; Data Segment
.dseg
;BaseTime1ms: .byte 1
;BaseTime100ms: .byte 1
;Blink: .byte 1
VAL_ADC: .byte 2

;===========================================
; EEPROM Segment
.eseg

VAR_EEPROM: .db $AA


;===========================================
; Code Segment
.cseg
.org RWW_START_ADDR      ; memory (PC) location of reset handler
rjmp Reset            ; jmp costs 2 cpu cycles and rjmp costs only 1
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

.org OVF0addr              ; memory location of Timer0 overflow handler
rjmp isr_OVF0_handler ; go here if a timer0 overflow interrupt occurs 

.org SPIaddr              ; memory location of SPI Serial Transfer Complete handler
rjmp isr_SPI_handler ; go here if a SPI Serial Transfer Complete interrupt occurs 

.org URXCaddr              ; memory location of USART Rx Complete handler
rjmp isr_URXC_handler ; go here if a USART Rx Complete interrupt occurs 

.org UDREaddr              ; memory location of USART, Data Register Empty handler
rjmp isr_UDRE_handler ; go here if a USART, Data Register Empty interrupt occurs 

.org UTXCaddr              ; memory location of USART Tx Complete handler
rjmp isr_UTXC_handler ; go here if a USART Tx Complete interrupt occurs 

.org ADCCaddr              ; memory location of ADC Conversion Complete handler
rjmp isr_ADCC_handler ; go here if a ADC Conversion Complete interrupt occurs 

.org ERDYaddr              ; memory location of EEPROM Ready handler
rjmp isr_ERDY_handler ; go here if a EEPROM Ready interrupt occurs 

.org ACIaddr              ; memory location of Analog Comparator handler
rjmp isr_ACI_handler ; go here if a Analog Comparator interrupt occurs 

.org TWIaddr              ; memory location of Two-wire Serial Interface handler
rjmp isr_TWI_handler ; go here if a Two-wire Serial Interface interrupt occurs 

.org SPMRaddr              ; memory location of Store Program Memory Read handler
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
ldi R16, LOW(RAMEND)    ; Lower address byte RAM byte lo.
    out SPL, R16          ; Stack pointer initialise lo.
ldi R16, HIGH(RAMEND)    ; Higher address of the RAM byte hi.
    out SPH, R16 ; Stack pointer initialise hi. 

; write your code here
call init_ADC
call init_port
ldi r16,0
rcall Set_Channel
call wait

; Realizo la primera conversión (el resultado es descartado)
rcall Go_Convert
cli

Loop:
rcall get_ADC
;ldi r17, low(400)
;ldi r18, high(400)
rcall get_range
rcall BCD_to_7_segment
out PORTD, r16
;call wait

rjmp Loop ; Volver al inicio

;===========================================
; Get_Range
; Obtiene el rango de la señal analogica
; Parámetro: R16 -> Valor
; Retorno: R16 -> Rango
get_range:
clr r16
cpi r18, 1
brsh loop_range
cpi r17, 102
brsh loop_range
ret
loop_range:
inc r16
subi r17,low(102)
sbci r18,high(102) ;SE PUEDE PONER 0
cpi r18, 1
brsh loop_range
cpi r17, 102
brsh loop_range
ret

;===========================================
; Set_Channel
; Selecciona el canal del conversor ADC
; Parámetro: R16 -> canal ha convertir
; Retorno: nada
Set_Channel:
lds r17,ADMUX
andi r17, 0xF0
andi r16, 0x0F
or r16, r17
sts ADMUX, r16
ret

;============================================
; Get_ADC
; Convierte el canal seleccionado previamente
; Parámetro: Nada
; Retorno: R18:R17 -> valor del canal
get_ADC:
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
/* Borro la bandera de Interrupción del conversor */                         
lds r16, ADCSRA
sbr r16, (1 << ADIF)
sts ADCSRA, r16

ret
}

;===========================================
; Go_Convert
; Convierte el canal seleccionado
; Parámetro: none
; Retorno: R18:R17 -> valor del canal
Go_Convert:
{
/* Inicio la conversión */
lds r16, ADCSRA
ori r16, (1<<ADSC)
sts ADCSRA, r16

/* Espero que termine la conversión */
_adc_loop:
lds r16, ADCSRA
sbrs r16, ADIF
rjmp _adc_loop
/* Leo y guardo el resultado */
lds r17, ADCL
lds r18, ADCH
/* Borro la bandera de Interrupción del conversor */                         
lds r16, ADCSRA
sbr r16, (1 << ADIF)
sts ADCSRA, r16
ret
}
  
;===========================================
; init_ADC
; Inicia el ADC
; Habilita ADC, CLK_ADC = 125KHz, V ref = AVCC
; Justificado a derecha, Canal Selec: GND
init_ADC:
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

;===========================================
; init_port
; Inicia el Puerto PD como salida
init_port:
in r16, DDRD
sbr r16, (1 << DDD7)|(1 << DDD6)|(1 << DDD5)|(1 << DDD4)|(1 << DDD3)|(1 << DDD2)|(1 << DDD1)|(1 << DDD0)
out DDRD, r16
ldi r16, 0
out PORTD, r16
ret

;===========================================
; BCDTo7Segment
;
; Convierte el valor, pasado en el registro r16, a una representación en 
; display de 7 segmentos, de manera que:
; Dp g f e d c b a
; B7 B6 B5 B4 B3 B2 B1 B0
;
BCD_to_7_segment:
push ZH
push ZL
ldi ZH,HIGH(2*BCDTo7Seg) ; Carga la tabla
ldi ZL,LOW(2*BCDTo7Seg)
add ZL,r16
lpm
mov r16,R0
pop ZL
pop ZH
ret

; Tabla de conversión decimal a 7 segmentos
BCDTo7Seg:
.db 0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F

;
; wait
;
; Demora aprox. 394 mseg
;
wait:
push r16
push r17
push r18

ldi r16,0x20 
ldi r17,0x00 
ldi r18,0x00 
_w0:
dec r18
brne _w0
dec r17
brne _w0
dec r16
brne _w0

pop r18
pop r17
pop r16
ret