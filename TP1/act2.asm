;********************************************************************
;Trabajo Práctico N°1 - Lectura de teclado y display
;Actividad II - Lectura de teclado/Escritura de displays
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
	
Digito1:		dB		30h		;Inicializo las variables en 30h (0 en el display)
Digito2:		dB		30h
Digito3:		dB		30h
Digito4:		dB		30h
Digito5:		dB		30h
Digito6:		dB		30h
Digito7:		dB		30h
Digito8:		dB		30h

	
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
	IN 20h			;Lee el dato en el puerto 20h
	CMP D			;El registro D guarda el último dato leído
	JZ Main			;Si lee lo mismo nuevamente, vuelve a Main (para no actualizar el display)
	MOV D, A		;Si lee algo distinto, lo guarda en D para la próxima iteración
	CPI 00h			;Comparo para ver si lo que leyó es 00h (ninguna tecla presionada)
	JZ Main			;En ese caso, tampoco actualiza el display (vuelve a Main)
	CALL CheckNum	;Si lo que lee es un dato relevante, chequea si es un número u otro símbolo
	OUT 17h			;Muestra en el último dígito del display de 7 segmentos el dato ya codificado al retornar CheckNum
	CALL ShowCount	;Decodifica y muestra la cantidad de veces que se presionó un número (esta información está en memoria)
	JMP Main		;Bucle

CheckNum:
	CPI 3Ah			;Comparo el dato leído con 3Ah (10)
	JNC NoNum		;Si CY=0 el dato es mayor a 39h, por lo tanto no es un número (30h-39h)
	CPI 30h			;Comparo el límite inferior del rango que determina los números
	JNC Num			;Si además de ser A<3Ah, se cumple que A>=30h, se trata de un número
NoNum:
	MVI A, 3Bh		;Si no es un número, pongo la codificación en 7 segmentos de la letra E en el acumulador
	RET
Num:
	CALL DecodeNum	;Si se trata de un número, lo decodifico para mostrarlo en el display
	CALL ContarNum	;E incremento la cuenta de veces en que se presionó un número
	RET

;**********************************************************
;Esta función compara contra cada dígito de 0 a 9 (30h-39h)
;y convierte el dato a su codificación en 7 segmentos
;**********************************************************
DecodeNum:
	CPI 39h
	JZ num9
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

;****************************************************************************
;Esta función incrementa un número almacenado en memoria, donde cada dígito
;ocupa una dirección distinta. Es un desperdicio de memoria pero hace facilmente
;escalable la representación de los números
;****************************************************************************
ContarNum:
	PUSH PSW		;Empila el acumulador para no perder el dato antes de mostrarlo
	MVI A, 38h		;Guardo 38h (8) para chequear que los digitos lleguen solo a 9
	LXI H, Digito1	;Comienzo a recorrer la memoria en el primer dígito
DigitLoop:
	CMP M			;Comparo el dígito con A (8)
	JNC Incrementa	;Si el valor en M es menor 0 igual a 8, lo incrementa
	MVI M, 30h		;Si es mayor a 8, reseteo el dígito poniendolo en 30h (0)
	INR L			;Incremento L, la parte baja de la dirección almacenada en el par HL
	JMP DigitLoop	;Repito las operaciones para el siguiente dígito hasta que pueda incrementar uno
Incrementa:
	INR M			;Incrementa el valor almacenado en la dirección que apunta el par HL después de haber modificado o no L
	POP PSW
	RET

;*********************************************************************
;Decodifica cada 8 dígitos almacenados de forma contigua en la memoria
;y los muestra en su respectivo digito
;*********************************************************************
ShowCount:
	LXI H, Digito1	;Pone la dirección del primer dígito en HL
	MOV A, M		;Pasa el valor al acumulador
	CALL DecodeNum	;Decodifica el dígito
	OUT 2Fh			;Lo muestra en el primer dígito de derecha a izquierda
	LXI H, Digito2  ;Repite lo anterior para el segundo dígito, etc.
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