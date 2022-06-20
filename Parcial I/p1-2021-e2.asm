;********************************************************************
;Técnicas Digitales II
;Práctica de parcial I - 2021 - Ejercicio 2
;RUP que ordene, de mayor a menor, 100 datos almacenados a partir de
;la dirección 400h
;********************************************************************

;********************************************************************
;	Definición de Etiquetas
;********************************************************************

.define
	BootAddr		0000h

	STACK_ADDR		FFFFh

	IniDataROM		4000h		;Comienzo de Constantes en ROM
	IniDataRAM		8000h		;Comienzo de Variables en RAM

	

;********************************************************************
;	Definición de Datos en RAM (Variables)
;********************************************************************

.data	IniDataRAM

	
;********************************************************************
;	Definición de Datos en ROM (Constantes)
;********************************************************************

.data	IniDataROM
	
n0:             dB      0
n1:             dB      1
n2:             dB      2
n3:             dB      3
n4:             dB      4
n5:             dB      5
n6:             dB      6
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
	
Main:
    MVI C, 00h
	LXI H, 4000h
Loop:
    MOV A, M
    INX H
    CMP M
    JC Swap
    MOV A, H
    CPI 41h
    JNZ Loop
    MOV A, L
    CPI 2Ch
    JNZ Loop
    MOV A, C
    CPI 01h
    JZ Main
    HLT

Swap:
    MOV B, M
    MOV M, A
    DCX H
    MOV M, B
    MVI C, 01h
	JMP	Loop
	