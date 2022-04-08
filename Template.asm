;********************************************************************
;T�cnicas Digitales II
;Archivo Template para trabajar con el microprocesador 8085
;Ing. Maggiolo Gustavo
;********************************************************************

;********************************************************************
;	Definici�n de Etiquetas
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
	IniDataRAM		2000h		;Comienzo de Variables en RAM

	

;********************************************************************
;	Definici�n de Datos en RAM (Variables)
;********************************************************************

.data	IniDataRAM
	
Variable1:		dB		16		;Inicializo la variable en 16
Variable2:		dB		0
Variable3:		dB		0
Variable4:		dB		0

	
;********************************************************************
;	Definici�n de Datos en ROM (Constantes)
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
	
Main:
	
	NOP
	NOP

	JMP	Main
	
	HLT