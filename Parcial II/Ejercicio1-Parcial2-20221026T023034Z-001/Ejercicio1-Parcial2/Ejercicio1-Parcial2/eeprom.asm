/*
 * eeprom.asm
 *
 *  Created: 24/10/2022 5:40:56
 *   Author: Lautaro Ezequiel Ubiedo
 */ 
.ifndef F_CPU
.set F_CPU = 16000000
.endif

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

ldi R16, LOW(RAMEND)     ; Lower address byte RAM byte lo.
out SPL, R16         ; Stack pointer initialise lo.
ldi R16, HIGH(RAMEND)   ; Higher address of the RAM byte hi.
out SPH, R16 ; Stack pointer initialise hi. 
rjmp Setup

; write your code here

Setup:
	cli
	ldi r16,0x58 //010-11-00-0b
	ldi r17,0x00
	ldi r18,0x00
	rcall EEPROM_write
	rcall EEPROM_read
	ldi r20,0xff
	out DDRD,r20
	cpi r16,0x58
	brne loop
	sbi PORTD,6
	loop:
	nop
	rjmp loop

EEPROM_write:
	; Wait for completion of previous write
	sbic EECR,EEPE
	rjmp EEPROM_write 
	; Set up address (r18:r17) in address register
	out EEARH, r18
	out EEARL, r17
	; Write data (r16) to Data Register
	out EEDR,r16
	; Write logical one to EEMPE
	sbi EECR,EEMPE
	; Start eeprom write by setting EEPE
	sbi EECR,EEPE
	ret

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