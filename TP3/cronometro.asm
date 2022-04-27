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
		RET
IntRST2:
		RET
IntRST3:
		RET
IntRST4:
		RET
IntTRAP:
		RET
IntRST5:
		RET
IntRST55:
		;Interrupción cada 100[ms]
		PUSH PSW
		LDA cantRST55
		INR A				;Cuenta la interrupcion
		CPI 0Ah				;Comparo para ver si lleguó a 10 interrupciones (1 segundo)
		JNC noCantRST55		;Si no llegó, no hace nada
		CALL SetFlagSeg		;Si pasó un segundo, activo el flag de segundo
		MVI A, 00h			;Preparo A para resetar cantRST55
noCantRST55:
		STA cantRST55		;Actualizo la cantidad de interrupciones que ocurrieron
		POP PSW
		EI
		RET

IntRST6:
		RET

IntRST65:
		;Interrupción de teclado
		PUSH PSW
		IN 20h
		CPI 53h				;Compara con 53h ('S')
		CZ StartCron		;Si se presionó S, arranca el cronómetro
		CPI 46h				;F
		CZ StopCron			;Si se presionó F, detiene el cronómetro
		CPI 50h				;P
		CZ ParcialCron		;Si se presionó P, toma un tiempo parcial
		CPI 54h				;T
		CZ ShowParcial		;Si se presionó T, recorre y muestra los tiempos parciales
		POP PSW
		EI
		RET

IntRST7:
		RET
IntRST75:		
		RET


;********************************************************************
;	Sector del Programa Principal
;********************************************************************
Boot:
	LXI	SP,STACK_ADDR	;Inicializo el Puntero de Pila
	MVI A, 09h			;Setea solo MSE y M5.5 (M5.5 arranca enmascarada y M6.5 no)
	SIM					;Setea máscaras
	CALL ShowCron		;Muestra el cronómetro (en cero)
	MVI A, 1Fh			;Código de la letra P para el display de 15 segmentos
	OUT 56h				;Deja la letra P en el primer dígito del display constantemente
	CALL ShowParcial	;Muestra el tiempo parcial0 (que es cero)
	EI					;Habilita las interrupciones
Main:
	LDA flags
	ANI 01h				;Chequeo si el flag seg esta en 1
	CNZ IncCron			;Incrementa en una unidad el cronómetro si el flag de segundos estaba en 1

	JMP	Main
	
	HLT

;Incrementa el cronómetro
IncCron:
	LXI H, cron+5		;Comienza por el dígito de la unidad de segundos
	MVI A, 08h			;Compara con su máximo
	CMP M				;Compara el dígito con su máximo
	JNC RetIncCron		;Si no llego al máximo, salta a incrementar
	MVI M, 00h			;Si en cambio llegó al máximo, repite lo mismo pero para el siguiente dígito
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
	CALL ResetCron		;Si se excedió el limite de 99:59:59, se reseta el cronometro
	LXI H, cron+5		;Y se vuelve a la unidad de segundo
RetIncCron:				
	INR M				;Incrementa el dígito que se eligió anteriormente
	CALL ShowCron		;Muestra el cronómetro actualizado
	CALL UnsetFlagSeg	;Desactiva el flag de segundo para que RST5.5 vuelva a contar interrupciones
	RET

;Inicia el cronómetro desenmascarando RST 5.5
StartCron:
	MVI A, 08h
	SIM					;Desenmascara RST 5.5
	CALL ResetParcial	;Cada vez que arranca el cronómetro borra también los tiempos parciales
	RET

;Detiene el cronómetro enmascarando RST 5.5
StopCron:
	MVI A, 09h
	SIM					;Enmascara RST 5.5
	CALL ResetCron		;Resetea el cronometro
	CALL ShowCron		;Muestra los valores actualizados en el display
	MVI A, F0h			;Pone un valor mayor al límite maximo de cantidad de tiempos parciales (10) por la naturaleza del funcionamiento de la función ShowParcial
	STA pOnDisplay		;Setea el valor a mostrar fuera del rango, con el número anterior
	CALL ShowParcial	;Muestra los valores parciales. Comenzará por el parcial0 por estar fuera de rango
	RET

;Resetea el cronómetro poniendo un 0 en cada espacio de memoria
ResetCron:
	MVI A, 00h
	STA cron
	STA cron+1
	STA cron+2
	STA cron+3
	STA cron+4
	STA cron+5
	RET
;Muestra los valores almacenados en el cronómetro
ShowCron:
	LDA cron			;Comienza por la decena de la hora
	CALL DecodeNum		;Decodifica el número almacenado
	OUT 37h				;Lo muestra en la posición correspondiente
	LDA cron+1			;Repite para los dígitos sucesivos
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

;Guarda el valor actual del cronómetro en un tiempo parcial
ParcialCron:
	LDA cantParciales
	CPI 0Ah				;Chequea si ya se guardaron 10 tiempos parciales
	JNC RetParcialCron	;Si es así, retorna sin hacer nada
	LXI H, parcial0		;Apunta al primer tiempo parcial
	CPI 00h				;Si solo hay 1 tiempo parcial (cantParciales = 0)
	JZ JumpLoop			;En ese caso, salteo el loop que avanza en la memoria
LoopParcialCron:
	CALL Avanzar5		;Me muevo 1 tiempo parcial (5 dígitos o 5 espacios de memoria)
	DCR A				;Resto tantas veces como cantidad de tiempos parciales haya
	JNZ LoopParcialCron ;Al finalizar este loop, la memoria apuntará a la decena de la hora del tiempo parcial a guardar
JumpLoop:
	LDA cron			;En las siguientes líneas se copia la memoria desde cron hasta la dirección que apuntamos
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

	LDA cantParciales	;Se cuenta el nuevo tiempo parcial
	INR A
	STA cantParciales
RetParcialCron:
	RET

;Muestra el tiempo parcial SIGUIENTE en el display de 15 segmentos
ShowParcial:
	LXI H, parcial0		;Comienza apuntando al primer tiempo parcial
	LDA cantParciales
	MOV B, A
	LDA pOnDisplay
	INR A
	CMP B				;Chequea que el tiempo a mostrar exista (tiempo mostrado menor a cantidad de tiempos guardados)
	MOV C, A			
	JC LoopDirec		;Avanza en la memoria hasta el tiempo parcial buscado
	MVI A, 00h			;Si se pasó del último tiempo parcial, vuelve al primero
	JMP DirecReady		;Y no se mueve en la memoria, muestra "parcial0"
LoopDirec:
	CALL Avanzar5
	DCR	C				;C es la cantidad de tiempos parciales que hay que recorrer
	JNZ LoopDirec
DirecReady:				;Ya se llegó a la dirección deseada
	STA pOnDisplay		;Actualiza el identificador del tiempo mostrado
	CALL DecodeNum		;Lo de codifica
	OUT 58h				;Y lo muestra al lado de la letra P, indicando de qué tiempo parcial se trata

	MOV A, M			;En las siguientes lineas se decodifica el tiempo parcial guardado y se muestra en el display
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

;Resetea todos los tiempos parciales
ResetParcial:			
	LXI H, parcial0		;Arranca desde el primer tiempo parcial
	MVI A, 60			;Setea A para contar 60 veces
LoopRstPar:
	MVI M, 00h			;Pone en 0 el dígito apuntado por HL
	INX H				;Se mueve al dígito siguiente
	DCR A
	JNZ LoopRstPar		;Si A llegó a 0, ya se borraron 60 dígitos
	MVI A, 00h
	STA cantParciales	;Resetea la cantidad de tiempos parciales (0)
	RET

;Decodifica un número a 7 o 15 segmentos
DecodeNum:
	PUSH H				;Empila el par HL
	MVI B, 09h			;B=9 para comparar 10 dígitos (0-9)
	LXI H, code9		;Comienza a comparar desde el número 9
LoopDecodeNum:
	CMP B
	JZ RetDecodeNum		;Cuando encuentra el número correspondiente, salta a RetDecodeNum
	DCX H				;Quedando en HL la dirección del número codificado
	DCR B
	JMP LoopDecodeNum	;Mientras no se haya encontrado el número correspondiente, compara contra el siguiente
RetDecodeNum:
	MOV A, M			;Guarda en A el valor del número ya codificado
	POP H				;Desempila HL
	RET

;Esta función se mueve 5 lugares en la memoria (con el fin de moverse de un tiempo parcial al siguiente)
Avanzar5:
	PUSH PSW
	PUSH B
	MVI B, 06h
LoopAvanzar5:
	INX H				;Avanza el puntero HL 5 veces
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