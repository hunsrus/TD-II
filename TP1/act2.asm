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
	
Digito1:		dB		30h		;Inicializo las variables en 30h (0 en el display)
Digito2:		dB		30h
Digito3:		dB		30h
Digito4:		dB		30h
Digito5:		dB		30h
Digito6:		dB		30h
Digito7:		dB		30h
Digito8:		dB		30h

	
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
	IN 20h
	CMP D
	JZ Main
	MOV D, A
	CPI 00h
	JZ Main
	CALL CheckNum
	OUT 17h
	CALL ShowCount
	JMP Main

CheckNum:
	CPI 3Ah
	JNC NoNum
	CPI 30h
	JNC Num			;Si es mayor a 30h y mayor a 39h, no es un n�mero
NoNum:
	MVI A, 3Bh
	RET
Num:
	CALL DecodeNum
	CALL ContarNum
	RET

DecodeNum:
	CPI 39h
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
num0:
	MVI A, 77h
	RET
num1:
	MVI A, 44h
	RET
num2:
	MVI A, 3Eh
	RET
num3:
	MVI A, 6Eh
	RET
num4:
	MVI A, 4Dh
	RET
num5:
	MVI A, 6Bh
	RET
num6:
	MVI A, 7Bh
	RET
num7:
	MVI A, 46h
	RET
num8:
	MVI A, 7Fh
	RET
num9:
	MVI A, 4Fh
	RET
	
ContarNum:
	PUSH PSW
	MVI A, 38h
	LXI H, Digito1
DigitLoop:
	CMP M
	JNC Incrementa
	MVI M, 30h
	INR L
	JMP DigitLoop
Incrementa:
	INR M
	POP PSW
	RET

ShowCount:
	LXI H, Digito1
	MOV A, M
	CALL DecodeNum
	OUT 2Fh
	LXI H, Digito2
	MOV A, M
	CALL DecodeNum
	OUT 2Dh
	LXI H, Digito3
	MOV A, M
	CALL DecodeNum
	OUT 2Bh
	LXI H, Digito4
	MOV A, M
	CALL DecodeNum
	OUT 29h
	LXI H, Digito5
	MOV A, M
	CALL DecodeNum
	OUT 27h
	LXI H, Digito6
	MOV A, M
	CALL DecodeNum
	OUT 25h
	LXI H, Digito7
	MOV A, M
	CALL DecodeNum
	OUT 23h
	LXI H, Digito8
	MOV A, M
	CALL DecodeNum
	OUT 21h
	RET
	
	HLT