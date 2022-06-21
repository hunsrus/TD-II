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

    MVI A, A0h
    MVI B, 0Ah          ;La comparación entre A y B debería dar 4 bits iguales en este caso (10100000 vs 00001010)
    MVI C, 08h          ;Contador de RLC
    XRA B               ;Los bits distintos van a quedar en 1
    MVI B, 00h
Loop:
    RLC
    JNC Is0             ;Eran iguales (CY=0)
    INR B               ;Eran distintos (CY=1) entonces cuento
Is0:
    DCR C
    JNZ Loop
    HLT                 ;El resultado queda guardado en el registro B