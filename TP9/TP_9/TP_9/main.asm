;
; TP N°9.asm
;
; Authors : Battaglia Carlo y Escobar Gabriel
;
.cseg
.org 0x00
rjmp start

.org PCI1addr			;dirección de memoria de Pin Change Interrupt Request 1
rjmp isr_PCI1_handler	;ir a esta dirección si ocurre Pin Change Interrupt 1

.org OVF1addr			;dirección de memoria de Timer/Counter1 Overflow Interrupt
rjmp isr_OVF1_handler	;ir a esta dirección si ocurre Timer/Counter1 Overflow Interrupt

.def OVFCounterL = r20	;registros que usaremos para contar interrupciones
.def OVFCounterH = r21

start:
ldi r16, 0x80			;Habilita interrupciones
out SREG, r16			;Reset status del sistema

ldi r16, LOW(RAMEND)	;Inicio del stack pointer
out SPL, r16
ldi r16, HIGH(RAMEND)
out SPH, r16

clr r16					;inicialización del Timer/Counter 1
sts TCCR1A, r16
clr r16
sts TCCR1B, r16
clr r16
sts TIMSK1, r16

clr r16
sts TCNT1L, r16
clr r16
sts TCNT1H, r16

clr r16
ldi r16, (1<<PCINT8)
sts PCMSK1, r16			;Habilita pin pc0 para interrupciones
clr r16
ldi r16, (1<<PCIE1)
sts PCICR, r16			;Habilita interrupcion 1 de cambio en el pin

clr r16
ldi r16, (1<<CS10)		;Inicio del timer 1
sts TCCR1B, r16

clr r16
ldi r16, (1 << DDD7) | (1 << DDD6) | (1 << DDD5) | (1 << DDD4) | (1 << DDD3) | (1 << DDD2) | (1 << DDD1) | (1 << DDD0)
out DDRD, r16			;PortD como salida

clr r16
clr r17
clr OVFCounterL
clr OVFCounterH

mainloop:
	cpi OVFCounterH, 0x02	;corrobora si ocurrieron el equivalente a 10s en interrupciones
	brcs mainloop			;(teniendo en cuenta la frecuencia del clock)
	cpi OVFCounterL, 0x62
	brcs mainloop

	clr r17					;si pasaron 10 segundos resetea el contador y apaga el display
	sts TIMSK1, r17
	clr OVFCounterL
	clr OVFCounterH
	out PORTD, r17
    rjmp mainloop

;esta subrutina divide un número por 6 hasta obtener como resto un número entre 0 y 6
dividir:
	cpi r16, 6
	brcs resto
	sbci r16, 6
	rjmp dividir
	resto:
	inc r16
	ret

;si hubo un cambio en el PINC0 (donde está el pulsador) toma el valor actual de TCNT1L y lo divide con la subrutina "dividir" para asignar un número entre 0 y 6.
isr_PCI1_handler:
	push r17
	sbis PINC, PINC0		;chequea que el cambio en PORTD sea específicamente en PINC0
	rjmp noHacerNada
	lds r16,TCNT1L			;toma el valor actual de TCNT1L
	call dividir			;asigna un número entre 0 y 6
	call DecodeNum			;lo decodifica
	out PORTD, r16			;y lo expone en el display que se encuentra en el PORTD
	clr OVFCounterL
	clr OVFCounterH
	clr r17
	ldi r17, (1<<TOIE1)		;Habilitamos interrupcion de OF
	sts TIMSK1, r17
	noHacerNada:
	pop r17
	reti ; Pin Change Interrupt 0

;cada vez que ocurre una interrupción por overflow, incrementamos en 1 el valor del contador de 16 bits OVFCounter.
isr_OVF1_handler:
	mov r24, OVFCounterL
	mov r25, OVFCounterH
	adiw r24, 0x01
	mov OVFCounterL, r24
	mov OVFCounterH, r25
	reti

;decodificamos el número para mostrarlo en un display de 7 segmentos. Esta vez no utilizamos la tabla de conversión.
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
