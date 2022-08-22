; TPNro12.6.asm

;

; Created: 06/06/2017 08:46:50 p.m.

; Author : Gustavo

;

ldi r16, 0

out SREG, r16 ; Reset status del sistema

ldi r16, LOW(RAMEND) ; Inicio del stack pointer

out SPL, r16

ldi r16, HIGH(RAMEND)

out SPH, r16

ldi r16, (1 << DDD7) | (1 << DDD6) | (1 << DDD5) | (1 << DDD4) | (1 << DDD3) | (1 << DDD2) | (1 << DDD1) | (1 << DDD0)

out DDRD, r16 ; PortD como salida

clr r16 ; Borro el PortD

out PORTD, r16



mainloop:

rcall EjecApp ; ejecuta la aplicación

rcall wait ; espera un tiempo

rjmp mainloop ; loop infinito



;

; EjecApp

;

; Ejecuta la aplicación específica pedida en el enunciado 

;

EjecApp:

push r16

in r16, PINC

andi r16, 0x0F

call BCDTo7Segment

out PORTD, r16

pop r16

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

.db 0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F,0x77,0x7C,0x39,0x5E,0x79,0x71



;

; wait

;

; Demora aprox. 24 mseg

;

wait:

push r16

push r17

push r18



ldi r16,0x02 

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
