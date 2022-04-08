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
p3:		dB		3
p4:		dB		2
p5:		dB		1
p6:		dB		10
p7:		dB		6
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
	
Main:
	CALL MayMen

	HLT

MayMen:
	LXI H, p1
Loop1:
	MOV A, L
	CPI 0Ah
	JNC Return1
	MOV A, M
	INR L
	CMP M
	JNC Loop1
	MOV B, M
	MOV M, A
	DCR L
	MOV M, B
	MOV A, L
	CPI 00h
	JZ Loop1
	DCR L
	JMP Loop1
Return1:
	RET

MenMay:
	LXI H, p1
Loop2:
	MOV A, L
	CPI 0Ah
	JNC Return2
	MOV A, M
	INR L
	CMP M
	JC Loop2
	MOV B, M
	MOV M, A
	DCR L
	MOV M, B
	MOV A, L
	CPI 00h
	JZ Loop2
	DCR L
	JMP Loop2
Return2:
	RET