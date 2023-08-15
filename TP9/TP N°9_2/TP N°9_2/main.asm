;
; TP N°9.asm
;
; Authors : Battaglia Carlo y Escobar Gabriel
;

; Tabla de conversión decimal a 7 segmentos
;.dseg
;BCDTo7Seg:
;.db 0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x00

.def ovfcounter = r20

.cseg
.org 0x00
rjmp start

.org PCI1addr			;memory location of Pin Change Interrupt Request 1
rjmp isr_PCI1_handler	;go here if a Pin Change Interrupt 1 occurs

.org OVF2addr			;memory location of Timer/Counter1 Overflow Interrupt
rjmp isr_OVF2_handler	;go here if a Timer/Counter1 Overflow Interrupt occurs

isr_PCI1_handler:
	push r17
	sbis PINC, PINC0
	rjmp noHacerNada
	lds r16,TCNT2
	call dividir
	call DecodeNum
	out PORTD, r16
	ldi ovfcounter, 0x00
	ldi r17, 0x00
	ldi r17, (1<<TOIE2)		;Habilitamos interrupcion de OF
	sts TIMSK2, r17
	noHacerNada:
	pop r17
	reti ; Pin Change Interrupt 0

isr_OVF2_handler:
	;mov r24, OVFCounterL
	;mov r25, OVFCounterH
	;adiw r24, 0x01
	;mov OVFCounterL, r24
	;mov OVFCounterH, r25
	inc ovfcounter
	reti

start:
ldi r16, LOW(RAMEND)	;Inicio del stack pointer
out SPL, r16
ldi r16, HIGH(RAMEND)
out SPH, r16

ldi r16, 0x80			;Habilita interrupciones
out SREG, r16			;Reset status del sistema
sei

clr r16
sts TCCR2A, r16
clr r16
sts TCCR2B, r16
clr r16
sts TIMSK2, r16

clr r16
sts TCNT2, r16

clr r16
ldi r16, (1<<PCINT8)
sts PCMSK1, r16			;Habilita pin pc0 para interrupciones
clr r16
ldi r16, (1<<PCIE1)
sts PCICR, r16			;Habilita interrupcion 1 de cambio en el pin

clr r16
ldi r16, (1<<CS21)		;Inicio del timer 1
sts TCCR2B, r16

clr r16
ldi r16, (1 << DDD7) | (1 << DDD6) | (1 << DDD5) | (1 << DDD4) | (1 << DDD3) | (1 << DDD2) | (1 << DDD1) | (1 << DDD0)
out DDRD, r16			;PortD como salida

ldi r16, 0x00
ldi r17, 0x00
ldi ovfcounter, 0x00

mainloop:
	cpi ovfcounter, 0x89
	brmi mainloop
	ldi r17, 0x00
	sts TIMSK2, r17
	ldi ovfcounter, 0x00
	;out PORTD, r17
    rjmp mainloop

dividir:
	cpi r16, 6
	brmi resto
	sbci r16, 6
	rjmp dividir
	resto:
	inc r16
	ret

DecodeNum:
	cpi r16, 6
	breq num6
	cpi r16, 5
	breq num5
	cpi r16, 4
	breq num4
	cpi r16, 3
	breq num3
	cpi r16, 2
	breq num2
num1:	
	ldi r16, 0x06
	RET
num2:
	ldi r16, 0x5B
	RET
num3:
	ldi r16, 0x4F
	RET
num4:
	ldi r16, 0x66
	RET
num5:
	ldi r16, 0x6D
	RET
num6:
	ldi r16, 0x7D
	RET