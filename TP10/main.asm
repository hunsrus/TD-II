;
; TP N°10.asm
; Authors : Battaglia Carlo y Escobar Gabriel
;

.cseg
.org 0x00
rjmp start

start:
clr r16
out SREG, r16			;Reset status del sistema

ldi r16, LOW(RAMEND)		;Inicio del stack pointer
out SPL, r16
ldi r16, HIGH(RAMEND)
out SPH, r16

clr r16
ldi r16, ( 1 << PB1 )
out DDRB, r16				;Configuramos el PB1 como salida.

clr r16
sts TCNT1L, r16
sts TCNT1H, r16				;Reseteamos el contador 1

clr r16
sts ICR1H, r16
ldi r16,15
sts ICR1L, r16				;Seteamos el TOP del PWM (Resolución=16)

clr r16
ldi r16, (1 << COM1A1) | (1 << COM1A0) | (1 << WGM11) | (0 << WGM10) ;Ponemos a BOTTOM el OCR1A cuando coincida el Compare Match y el TOP de Fast PWM dado por ICR1
sts TCCR1A, r16

clr r16
ldi r16, (1 << WGM13) | (1 << WGM12) | (0 << CS12) | (0 << CS11) | ( 1 << CS10 ) ;Fast PWM: TOP: ICR1
sts TCCR1B, r16

clr r16
sts OCR1AH,r16
ldi r16, 15                 ;Inicio PWM en 0
sts OCR1AL,r16

ldi r16, (1 << DDD7) | (1 << DDD6) | (1 << DDD5) | (1 << DDD4) | (1 << DDD3) | (1 << DDD2) | (1 << DDD1) | (1 << DDD0)
out DDRD, r16				;PortD como salida
clr r16						;Borro el PortD
out PORTD, r16

mainloop:
in r16, PINC
andi r16, 0x0F
ldi r17, 0x0F
eor r17, r16
sts OCR1AL, r17
call HEXTo7Segment
out PORTD, r16
rjmp mainloop				;loop infinito

;
; HEXTo7Segment
;
; Convierte el valor, pasado en el registro r16, a una representación en display de 7 segmentos
;

HEXTo7Segment:
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

HEXTo7Seg:
.db 0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F,0x77,0x7C,0x39,0x5E,0x79,0x71