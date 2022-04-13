;********************************************************************
;Técnicas Digitales II
;Archivo Template para trabajar con el microprocesador 8085
;Ing. Maggiolo Gustavo
;********************************************************************

;********************************************************************
;	Definición de Etiquetas
;********************************************************************

.define
	BootAddr		0000h
	AddrIntRST1		0008h
	AddrIntRST2		0010h
	AddrIntRST3		0018h
	AddrIntRST4		0020h
	AddrIntTRAP		0024h
	AddrIntRST5		0028h
	AddrIntRST55	002Ch
	AddrIntRST6		0030h
	AddrIntRST65	0034h
	AddrIntRST7		0038h
	AddrIntRST75	003Ch

	STACK_ADDR		FFFFh

	IniDataROM		0540h		;Comienzo de Constantes en ROM
	IniDataRAM		4100h		;Comienzo de Variables en RAM

	

;********************************************************************
;	Definición de Datos en RAM (Variables)
;********************************************************************

.data	IniDataRAM
	
p1:		dB		5
p2:		dB		4
p3:		dB		6
p4:		dB		3
p5:		dB		2
p6:		dB		1
p7:		dB		0
p8:		dB		7
p9:		dB		8
p10:	dB		9

	
;********************************************************************
;	Definición de Datos en ROM (Constantes)
;********************************************************************

.data	IniDataROM
	
CteWord:		dW	03E8h
CteByte:		dB	64h
		
		
Texto:		dB	'C','a','d','e','n','a',0

	

;********************************************************************
;	Sector de Arranque del 8085
;********************************************************************

	.org	BootAddr
		JMP	Boot

;********************************************************************
;	Sector del Vector de Interrupciones
;********************************************************************
	.org	AddrIntRST1
		JMP	IntRST1
	.org	AddrIntRST2
		JMP	IntRST2
	.org	AddrIntRST3
		JMP	IntRST3
	.org	AddrIntRST4
		JMP	IntRST4
	.org	AddrIntTRAP
		JMP	IntTRAP
	.org	AddrIntRST5
		JMP	IntRST5
	.org	AddrIntRST55
		JMP	IntRST55
	.org	AddrIntRST6
		JMP	IntRST6
	.org	AddrIntRST65
		JMP	IntRST65
	.org	AddrIntRST7
		JMP	IntRST7
	.org	AddrIntRST75
		JMP	IntRST75

;********************************************************************
;	Sector de las Interrupciones
;********************************************************************
IntRST1:
		;Ac� va el c�digo de la Interrupci�n RST1
		
		RET
IntRST2:
		;Ac� va el c�digo de la Interrupci�n RST2
		
		RET
IntRST3:
		;Ac� va el c�digo de la Interrupci�n RST3
		
		RET
IntRST4:
		;Ac� va el c�digo de la Interrupci�n RST4
		
		RET
IntTRAP:
		;Ac� va el c�digo de la Interrupci�n TRAP
		
		RET
IntRST5:
		;Ac� va el c�digo de la Interrupci�n RST5
		
		RET
IntRST55:
		;Ac� va el c�digo de la Interrupci�n RST5.5
		
		RET
IntRST6:
		;Ac� va el c�digo de la Interrupci�n RST6
		
		RET
IntRST65:
		;Ac� va el c�digo de la Interrupci�n RST6.5
		
		RET
IntRST7:
		;Ac� va el c�digo de la Interrupci�n RST7
		
		RET
IntRST75:
		;Ac� va el c�digo de la Interrupci�n RST7.5
		
		RET


;********************************************************************
;	Sector del Programa Principal
;********************************************************************
Boot:
	LXI	SP,STACK_ADDR	;Inicializo el Puntero de Pila
	MVI C, 03h
Main:
	CALL Ordenar

	HLT

Ordenar:
	LXI H, p1		;Empiezo con la primera posición
Loop1:
	MOV A, L		;Muevo el byte menos significativo
	CPI 09h			;Corroboro que no haya pasado la última posición
	JNC Return1		;Si pasa la última posición significa que recorrí toda la lista sin invertir nada, entonces termina
	MOV A, M		;De lo contrario, lee la memoria y pasa el dato al acumulador
	INR L			;Incrementa L, avanzando la dirección de memoria una posición
	CALL CheckCriterio
	JNC Loop1		;Si CY=0, M(x) y M(x-1) cumplen la condición de ordenamiento, entonces los dejo en su posición y paso a comparar el siguiente par
	MOV B, M		;Si no, los invierto en las siguientes instrucciones
	MOV M, A
	DCR L
	MOV M, B
	MOV A, L		;Después de invertirlos, termino con L en el acumulador indicando la posición anterior
	CPI 00h
	JZ Loop1		;Si la posición actual es la primera, sigo comparando como si empezara de nuevo
	DCR L			;Si no, decremento una vez más
	JMP Loop1		;y vuelvo a comparar con el siguiente
Return1:
	RET

CheckCriterio:
	MOV D, A		;Guardo uno de los datos a comparar en el registro D para usar A en otras operaciones
	MOV A, C		;C guarda la opción de ordenamiento
	CPI 00h
	JZ Crit0
	CPI 01h
	JZ Crit1
	CPI 02h
	JZ Crit2
	CPI 03h
	JZ Crit3
	RET
Crit0:				;Mayor a menor
	MOV A, D
	CMP M
	JMP RetCrit
Crit1:				;Menor a mayor
	MOV A, D
	CMP M
	CMC
	JMP RetCrit
Crit2:				;Par a impar
	MOV A, M
	RAR
	MOV A, D
	JNC MPar
	CMC
	JMP RetCrit
MPar:
	RAR				;No hay salto porque el estado de CY se condice con lo que debe retornar
	MOV A, D		;Vuelvo a poner el dato en A antes de continuar
	JMP RetCrit
Crit3:				;Par a impar
	MOV A, M
	RAR
	MOV A, D
	JC MImpar
	JMP RetCrit
MImpar:
	RAR				;No hay salto porque el estado de CY se condice con lo que debe retornar
	CMC
	MOV A, D		;Vuelvo a poner el dato en A antes de continuar
	JMP RetCrit
RetCrit:			;El criterio es: 0=Cumple / 1=NoCumple
	RET