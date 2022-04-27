;********************************************************************
;Trabajo Práctico N°3 - Cronómetro con segundos
;Battaglia Carlo - Escobar Gabriel
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
	
cantRST55:		dB		0			;Contador de interrupciones RST 5.5
flags:			dB 		0			;Variable de flags donde el último bit representa si pasó o no 1 segundo
cron:			dB 	0,0,0,0,0,0		;H,H,M,M,S,S
pOnDisplay: 	dB 		F0h			;Parcial que se muestra
cantParciales:	dB		0			;Cantidad de tiempos parciales guardados
parcial0:		dB 	0,0,0,0,0,0		;H,H,M,M,S,S
parcial1:		dB 	0,0,0,0,0,0		;H,H,M,M,S,S
parcial2:		dB 	0,0,0,0,0,0		;H,H,M,M,S,S
parcial3:		dB 	0,0,0,0,0,0		;H,H,M,M,S,S
parcial4:		dB 	0,0,0,0,0,0		;H,H,M,M,S,S
parcial5:		dB 	0,0,0,0,0,0		;H,H,M,M,S,S
parcial6:		dB 	0,0,0,0,0,0		;H,H,M,M,S,S
parcial7:		dB 	0,0,0,0,0,0		;H,H,M,M,S,S
parcial8:		dB 	0,0,0,0,0,0		;H,H,M,M,S,S
parcial9:		dB 	0,0,0,0,0,0		;H,H,M,M,S,S

	
;********************************************************************
;	Definición de Datos en ROM (Constantes)
;********************************************************************

.data	IniDataROM
	
code0:	dB	77h
code1:	dB	44h
code2:	dB	3Eh
code3:	dB	6Eh
code4:	dB	4Dh
code5:	dB	6Bh
code6:	dB	7Bh
code7:	dB	46h
code8:	dB	7Fh
code9:	dB	4Fh
		
		
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
		;Interrupción cada 100[ms]
		PUSH PSW
		LDA cantRST55
		INR A
		CPI 0Ah
		JNC noCantRST55
		CALL SetFlagSeg
		MVI A, 00h
noCantRST55:
		STA cantRST55
		POP PSW
		EI
		RET
IntRST6:
		;Acá va el código de la Interrupción RST6
		
		RET
IntRST65:
		;Interrupción de teclado
		PUSH PSW
		IN 20h
		CPI 53h				;Compara con 53h ('S')
		CZ StartCron
		CPI 46h				;F
		CZ StopCron
		CPI 50h				;P
		CZ ParcialCron
		CPI 54h				;T
		CZ ShowParcial
		POP PSW
		EI
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
	MVI A, 09h			;Seteo solo MSE y M5.5 (M5.5 arranca enmascarada y M6.5 no)
	SIM
	CALL ShowCron
	MVI A, 1Fh
	OUT 56h
	CALL ShowParcial
	EI
Main:
	LDA flags
	ANI 01h				;Chequeo si el flag seg esta en 1
	CNZ IncCron			;Incrementa en una unidad el cronómetro

	JMP	Main
	
	HLT

IncCron:
	LXI H, cron+5
	MVI A, 08h
	CMP M
	JNC RetIncCron
	MVI M, 00h
	DCX H
	MVI A, 04h
	CMP M
	JNC RetIncCron
	MVI M, 00h
	DCX H
	MVI A, 08h
	CMP M
	JNC RetIncCron
	MVI M, 00h
	DCX H
	MVI A, 04h
	CMP M
	JNC RetIncCron
	MVI M, 00h
	DCX H
	MVI A, 08h
	CMP M
	JNC RetIncCron
	MVI M, 00h
	DCX H
	MVI A, 08h
	CMP M
	JNC RetIncCron
	CALL ResetCron
	LXI H, cron+5
RetIncCron:
	INR M
	CALL ShowCron
	CALL UnsetFlagSeg
	RET

;Inicia el cronómetro desenmascarando RST 5.5
StartCron:
	MVI A, 08h
	SIM
	CALL ResetParcial
	RET
;Detiene el cronómetro enmascarando RST 5.5
StopCron:
	MVI A, 09h
	SIM
	CALL ResetCron
	CALL ShowCron
	MVI A, F0h
	STA pOnDisplay
	CALL ShowParcial
	RET
ResetCron:
	MVI A, 00h
	STA cron
	STA cron+1
	STA cron+2
	STA cron+3
	STA cron+4
	STA cron+5
	RET
ShowCron:
	LDA cron
	CALL DecodeNum
	OUT 37h
	LDA cron+1
	CALL DecodeNum
	OUT 38h
	LDA cron+2
	CALL DecodeNum
	OUT 39h
	LDA cron+3
	CALL DecodeNum
	OUT 3Ah
	LDA cron+4
	CALL DecodeNum
	OUT 3Bh
	LDA cron+5
	CALL DecodeNum
	OUT 3Ch
	RET
ParcialCron:
	LDA cantParciales
	CPI 0Ah				;Chequea si ya se guardaron 10 tiempos parciales
	JNC RetParcialCron	;Si es así, retorna sin hacer nada
	LXI H, parcial0		;Apunto al primer tiempo parcial
	CPI 00h
	JZ JumpLoop
LoopParcialCron:
	CALL Avanzar5		;Me muevo 1 tiempo parcial
	DCR A				;Resto tantas veces como cantidad de tiempos parciales haya
	JNZ LoopParcialCron
JumpLoop:
	LDA cron
	MOV M, A
	INX H
	LDA cron+1
	MOV M, A
	INX H
	LDA cron+2
	MOV M, A
	INX H
	LDA cron+3
	MOV M, A
	INX H
	LDA cron+4
	MOV M, A
	INX H
	LDA cron+5
	MOV M, A
	LDA cantParciales
	INR A
	STA cantParciales
RetParcialCron:
	RET

ShowParcial:
	LXI H, parcial0

	LDA cantParciales
	MOV B, A
	LDA pOnDisplay
	INR A
	CMP B
	MOV C, A
	JC LoopDirec
	MVI A, 00h
	JMP DirecReady
LoopDirec:
	CALL Avanzar5
	DCR	C
	JNZ LoopDirec
DirecReady:
	STA pOnDisplay
	CALL DecodeNum
	OUT 58h

	MOV A, M
	CALL DecodeNum
	OUT 5Ah
	INX H
	MOV A, M
	CALL DecodeNum
	OUT 5Ch
	INX H
	MOV A, M
	CALL DecodeNum
	OUT 5Eh
	INX H
	MOV A, M
	CALL DecodeNum
	OUT 60h
	INX H
	MOV A, M
	CALL DecodeNum
	OUT 62h
	INX H
	MOV A, M
	CALL DecodeNum
	OUT 64h
ShowParcialRet:
	RET

ResetParcial:
	LXI H, parcial0
	MVI A, 60
LoopRstPar:
	MVI M, 00h
	INX H
	DCR A
	JNZ LoopRstPar
	MVI A, 00h
	STA cantParciales
	RET

DecodeNum:
	PUSH H
	MVI B, 09h
	LXI H, code9
LoopDecodeNum:
	CMP B
	JZ RetDecodeNum
	DCX H
	DCR B
	JMP LoopDecodeNum
RetDecodeNum:
	MOV A, M
	POP H
	RET

Avanzar5:
	PUSH PSW
	PUSH B
	MVI B, 06h
LoopAvanzar5:
	INX H
	DCR B
	JNZ LoopAvanzar5
	POP B
	POP PSW
	RET

;Setea el último bit de flag (pasó un segundo)
SetFlagSeg:
	PUSH PSW
	LDA flags
	ORI 01h
	STA flags
	POP PSW
	RET
;Pone en 0 el último bit de flag
UnsetFlagSeg:
	PUSH PSW
	LDA flags
	ANI FEh
	STA flags
	POP PSW
	RET