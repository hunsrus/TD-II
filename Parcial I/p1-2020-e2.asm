;********************************************************************
;Técnicas Digitales II
;Práctica de parcial I - 2021 - Ejercicio 2
;RUP que sobre un banco de 200 datos ubicados a partir de 2000H
;cuente en 1FFEh cuantos son pares y mayores de A0H.
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

.data	IniDataROM

	
;********************************************************************
;	Definición de Datos en RAM (Constantes)
;********************************************************************

.data	IniDataRAM
	
n0:             dB      0
n1:             dB      A0h
n2:             dB      B2h
n3:             dB      3
n4:             dB      4
n5:             dB      FEh
n6:             dB      EFh
n7:             dB      7
n8:             dB      8
n9:             dB      9
n10:            dB      10

	

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
	
PYM:
    MVI C, C8h
    MVI B, 00h
	LXI H, 2000h
Loop:
    MOV A, M
    CPI A1h
    JC Next
    ANI 01h
    JNZ Next
    INR B

Next:
    INX H
    DCR C
    JNZ Loop
    MOV A, B
    STA 1FFEh
    HLT