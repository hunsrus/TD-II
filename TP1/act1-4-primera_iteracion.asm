;********************************************************************
;Técnicas Digitales II

;Escobar Gabriel y Battaglia Carlo
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
	
Variable1:		dB		16		;Inicializo la variable en 16
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
	
Main:
	
    IN 0Ah
	CALL Revertir
    OUT A0h
	IN 0Bh
	CALL Revertir
    OUT A1h
    IN 0Ch
	CALL Revertir
    OUT A2h
	IN 0Dh
	CALL Revertir
    OUT A3h
    IN 0Eh
	CALL Revertir
    OUT A4h
    IN 0Fh
	CALL Revertir
    OUT A5h
    IN 10h
	CALL Revertir
    OUT A6h
    IN 11h
	CALL Revertir
    OUT A7h
	
	JMP Main

Revertir:
	MVI C, 00h		;Inicializo C en cero, donde voy a almacenar el dato de salida
	MVI D, 08h		;Inicializo para contar 8 veces
Loop:
	RRC				;Desplazo a la deracha, dejando el bit menos significativo del dato en CY
	MOV B, A		;Guardo el estado del dato en B
	MOV A, C		;Paso C al acumulador para realizar operaciones
	JNC Cero		;Si el bit en D0 era cero, salto el paso siguiente (Las instrucciones MOV anteriores no afectan ningún flag seteado durante RRC)
	ADI 01h			;Si D0 era 1, pongo en 1 el bms del dato a devolver
Cero:
	DCR D			;Decremento D
	JZ Return		;Si resté 8 veces, termina el algoritmo con el dato a devolver (C) en el acumulador
	RLC				;Si no, desplazo los datos a la izquierda y continúo
	MOV C, A		;Guardo el dato parcialmente revertido en C nuevamente
	MOV A, B		;Vuelvo a poner la entrada en el acumulador para repetir las operaciones
	JMP Loop
Return:
	RET

	HLT
