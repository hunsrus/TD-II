;
; TP N°9.asm
;
; Authors : Battaglia Carlo y Escobar Gabriel
;

.ifndef F_CPU
.set F_CPU = 16000000
.endif

.cseg
.org 0x00
rjmp start

.org PCI1addr			;memory location of Pin Change Interrupt Request 1
rjmp isr_PCI1_handler	;go here if a Pin Change Interrupt 1 occurs

.org OVF1addr			;memory location of Timer/Counter1 Overflow Interrupt
rjmp isr_OVF1_handler	;go here if a Timer/Counter1 Overflow Interrupt occurs

; Tabla de conversión decimal a 7 segmentos
BCDTo7Seg:
.db 0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x00

.def OVFCounterL = r20
.def OVFCounterH = r21

start:
ldi r16, 0x80			;Habilita interrupciones
out SREG, r16			;Reset status del sistema

ldi r16, LOW(RAMEND)	;Inicio del stack pointer
out SPL, r16
ldi r16, HIGH(RAMEND)
out SPH, r16

clr r16
ldi r16, (1<<PCINT8)
sts PCMSK1, r16			;Habilita pin pc0 para interrupciones
clr r16
ldi r16, (1<<PCIE1)
sts PCICR, r16			;Habilita interrupcion 1 de cambio en el pin

clr r16
ldi r16, (1<<CS10)|(0<<CS11)|(0<<CS12)	;Inicio del timer
sts TCCR1B, r16

clr r16
ldi r16, (1 << DDD7) | (1 << DDD6) | (1 << DDD5) | (1 << DDD4) | (1 << DDD3) | (1 << DDD2) | (1 << DDD1) | (1 << DDD0)
out DDRD, r16			;PortD como salida

clr r16
clr r17
clr OVFCounterL
clr OVFCounterH

mainloop:
	cpi OVFCounterH, 0x08
	brmi mainloop
	cpi OVFCounterL, 0x89
	brmi mainloop
	clr r16
	;ldi r16, (0<<TOIE1)
	sts TIMSK1, r16
	clr OVFCounterL
	clr OVFCounterH
	out PORTD, r16
    rjmp mainloop

dividir:
	cpi r16, 6
	brmi resto
	sbci r16, 6
	rjmp dividir
	resto:
	inc r16
	ret

isr_PCI1_handler:
	lds r16,TCNT1L
	call dividir
	call BCDTo7Segment
	out PORTD, r16
	clr r16
	ldi r16, (1<<TOIE1)		;Habilitamos interrupcion de OF
	sts TIMSK1, r16
	reti ; Pin Change Interrupt 0

BCDTo7Segment:
	push ZH
	push ZL
	ldi ZH,HIGH(2*BCDTo7Seg) ; Carga la tabla
	ldi ZL,LOW(2*BCDTo7Seg)
	add ZL, r16
	lpm
	mov r16,R0
	pop ZL
	pop ZH
	ret

isr_OVF1_handler:
	cpi OVFCounterL, 0xFF
	brpl countH
	inc OVFCounterL
	rjmp fin
	countH:
	inc OVFCounterH
	clr OVFCounterL
	fin:
	reti