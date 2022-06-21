;********************************************************************
;Técnicas Digitales II
;Ejercitación de escritorio 2 - Ejercicio 5
;Realice un programa que encuentre el menor elemento en un bloque de
;datos cuya longitud se encuentra en la posición de memoria 2001h y que
;empieza en la posición 200Ah. Los números en el bloque son binarios
;de 8 bit sin signo. Almacene el elemento en la posición 2000h.
;********************************************************************

;********************************************************************
;	Definición de Etiquetas
;********************************************************************

.define
	BootAddr		0000h

	STACK_ADDR		FFFFh

	IniDataROM		1000h		;Comienzo de Constantes en ROM
	IniDataRAM		2000h		;Comienzo de Variables en RAM

	

;********************************************************************
;	Definición de Datos en ROM (Variables)
;********************************************************************

.data	IniDataRAM

DatoMenor:      dB  00h
LargoBloque:    dB  04h
.data   200Ah
d0:             dB  03h
d1:             dB  FFh
d2:             dB  01h
d3:             dB  0Ah

	
;********************************************************************
;	Definición de Datos en RAM (Constantes)
;********************************************************************

.data	IniDataROM
	

;********************************************************************
;	Sector de Arranque del 8085
;********************************************************************

	.org	BootAddr
		JMP	Boot

;********************************************************************
;	Sector del Programa Principal
;********************************************************************
Boot:
	LXI	SP,STACK_ADDR	;Inicializo el Puntero de Pila

    LDA 2001h
    MOV B, A            ;B almacenará el largo del bloque de datos
    LXI H, 200Ah
GetData:
    MOV A, M
CMPNext:
    DCR B
    JZ Stop
    INX H
    CMP M
    JC  CMPNext
    JMP GetData
Stop:
    STA DatoMenor
    HLT
