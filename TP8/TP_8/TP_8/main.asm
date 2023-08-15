;
; TP N°8.asm
; Authors : Battaglia Carlo y Escobar Gabriel
;

.def FLAGS = r17
.def COUNTER = r18
.def LIMIT = r20
ldi r16, 0x80
out SREG, r16						;Reset status del sistema
ldi r16, LOW(RAMEND)		;Inicio del stack pointer
out SPL, r16
ldi r16, HIGH(RAMEND)
out SPH, r16
ldi r16, (1 << DDD7) | (1 << DDD6) | (1 << DDD5) | (1 << DDD4) | (1 << DDD3) | (1 << DDD2) | (1 << DDD1) | (1 << DDD0)
out DDRD, r16						;PortD como salida
clr r16									;Borro el PortD
out PORTD, r16
clr FLAGS
clr COUNTER
ldi r19, 0x3F
ldi LIMIT, 0x09

mainloop:
in r16, PINC
sbrs r16, 0
rjmp copyPasteBit
sbrs FLAGS, 0
call Count
copyPasteBit:
bst r16, 0
bld FLAGS, 0
sbrc r16, 3
ldi COUNTER, 0x00
call BCDTo7Segment
sbrs r16, 2
rjmp setFlagsBCD2BIN
sbrs FLAGS, 2
call ChangeLimits
setFlagsBCD2BIN:
bst r16, 2
bld FLAGS, 2
out PORTD, r19
rjmp mainloop				;loop infinito

Count:
sbrc r16, 1					;el cero incrementa, el uno decrementa
sbci COUNTER, 2
inc COUNTER
brpl checkUpperLimit
mov COUNTER, LIMIT
checkUpperLimit:		;si no se paso del limite que sigue, si se paso que resetee el contador
cp LIMIT, COUNTER
brpl fin
ldi COUNTER, 0x00
fin:
ret

ChangeLimits:				;cambiar limite de BCD a Hexadecimal
ldi r21, 0x06
eor LIMIT, r21
ret

;
; BCDTo7Segment
;
; Convierte el valor, pasado en el registro r16, a una representación en 
; display de 7 segmentos, de manera que:
; Dp g f e d c b a
; B7 B6 B5 B4 B3 B2 B1 B0
;

BCDTo7Segment:
push ZH
push ZL
ldi ZH,HIGH(2*BCDTo7Seg)	;Carga la tabla
ldi ZL,LOW(2*BCDTo7Seg)
add ZL, COUNTER
lpm
mov r19,R0
pop ZL
pop ZH
ret

;Tabla de conversión decimal y hexadecimal a 7 segmentos

BCDTo7Seg:
.db 0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F,0x77,0x7C,0x39,0x5E,0x79,0x71
