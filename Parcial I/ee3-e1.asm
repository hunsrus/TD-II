;********************************************************************
;Técnicas Digitales II
;Ejercitación de escritorio 1 - Ejercicio 4
;Escribir un programa que compare los bits del registro A con los del
;registro B y cuente cuantos son diferentes.
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
D4D3:       dB      41h
D2D1:       dB      90h
	
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

    LDA D4D3
    ORI F0h
    RLC
    RLC
    RLC
    RLC
    MOV B, A
    LDA D4D3
    ORI 0Fh
    MOV C, A
    MVI A, 00h
Prod1:
    ADD C               ;Sumo C una cantidad B de veces (producto)
    DCR B
    JNZ Prod1
    LDA 
    LDA D2D1
    ORI F0h
    RLC
    RLC
    RLC
    RLC
    LDA D4D3
    ORI 0Fh