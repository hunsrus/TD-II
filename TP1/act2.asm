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
	IniDataRAM		2000h		;Comienzo de Variables en RAM

	

;********************************************************************
;	Definición de Datos en RAM (Variables)
;********************************************************************

.data	IniDataRAM
	
Variable1:		dB		00h		;Inicializo la variable en 16
Variable2:		dB		0
Variable3:		dB		0
Variable4:		dB		0

	
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
		;Acá va el código de la Interrupción RST1
		
		RET
IntRST2:
		;Acá va el código de la Interrupción RST2
		
		RET
IntRST3:
		;Acá va el código de la Interrupción RST3
		
		RET
IntRST4:
		;Acá va el código de la Interrupción RST4
		
		RET
IntTRAP:
		;Acá va el código de la Interrupción TRAP
		
		RET
IntRST5:
		;Acá va el código de la Interrupción RST5
		
		RET
IntRST55:
		;Acá va el código de la Interrupción RST5.5
		
		RET
IntRST6:
		;Acá va el código de la Interrupción RST6
		
		RET
IntRST65:
		;Acá va el código de la Interrupción RST6.5
		
		RET
IntRST7:
		;Acá va el código de la Interrupción RST7
		
		RET
IntRST75:
		;Acá va el código de la Interrupción RST7.5
		
		RET


;********************************************************************
;	Sector del Programa Principal
;********************************************************************
Boot:
	LXI	SP,STACK_ADDR	;Inicializo el Puntero de Pila
	MVI B, 00h			;Inicializo B como contador en 0

Main:
	IN 20h
	CMP D
	JZ Main
	MOV D, A
	CPI 00h
	JZ Main
	CPI 30h
	JNC May30			;Si A>=30h (0) salto. Si no, no es un número
NoNum:
	MVI A, 3Bh
	OUT 17h
	JMP Main


May30:
	JZ num0 			;Si Z=1 -> A=30h
	CPI 39h
	JNC NoNum			;Si es mayor a 30h y mayor a 39h, no es un número
	JZ num9 			;Si era igual a 39h, muestra 9
	CPI 38h
	JZ num8
	CPI 37h
	JZ num7
	CPI 36h
	JZ num6
	CPI 35h
	JZ num5
	CPI 34h
	JZ num4
	CPI 33h
	JZ num3
	CPI 32h
	JZ num2
	CPI 31h
	JZ num1
OutNum:
	OUT 17h
	MVI A, 08h
	LXI H, 2000h
DigitLoop:
	CMP M
	JNC Incrementa
	MVI M, 00h
	INR L
	JMP DigitLoop
Incrementa:
	INR M
	JMP Main

num0:
	MVI A, 77h
	JMP OutNum
num1:
	MVI A, 44h
	JMP OutNum
num2:
	MVI A, 3Eh
	JMP OutNum
num3:
	MVI A, 6Eh
	JMP OutNum
num4:
	MVI A, 4Dh
	JMP OutNum
num5:
	MVI A, 6Bh
	JMP OutNum
num6:
	MVI A, 7Bh
	JMP OutNum
num7:
	MVI A, 46h
	JMP OutNum
num8:
	MVI A, 7Fh
	JMP OutNum
num9:
	MVI A, 4Fh
	JMP OutNum


	MOV A, B
	
	
	HLT