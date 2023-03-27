						TITLE	Programa para evaluar una expresión
						PAGE	60, 132

						.586
						.MODEL	FLAT, STDCALL

Include Macros.inc

; Prototipos de funciones del sistema
GetStdHandle	PROTO	:DWORD
ReadConsoleA	PROTO	:DWORD,	:DWORD,	:DWORD,	:DWORD,	:DWORD
WriteConsoleA	PROTO	:DWORD,	:DWORD,	:DWORD,	:DWORD,	:DWORD
ExitProcess		PROTO	nCodigoSalida:DWORD

						.STACK
						.DATA
E						DWORD	0
A						DWORD	0
B						DWORD	0
C1						DWORD	0
MenEnt01				BYTE	"Proporcione el valor de la variable A: "
Long_ME01				EQU		$ - MenEnt01
MenEnt02				BYTE	"Proporcione el valor de la variable B: "
Long_ME02				EQU		$ - MenEnt02
MenEnt03				BYTE	"Proporcione el valor de la variable C: "
Long_ME03				EQU		$ - MenEnt03
MenSal01				BYTE	"El valor de la variable E es: "
Long_MS01				EQU		$ - MenSal01

; Variables requeridas por las llamadas al sistema
ManejadorE				DWORD	?
ManejadorS				DWORD	?
Caracteres				DWORD	?
STD_INPUT				EQU		-10
STD_OUTPUT				EQU		-11
SaltoLinea				BYTE	13, 10
Texto					BYTE	13 DUP ( ? )

						.CODE
Principal				PROC
						; Obtener manejador de la entrada y salida estándar
						INVOKE	GetStdHandle, STD_INPUT
						MOV		ManejadorE, EAX
						INVOKE	GetStdHandle, STD_OUTPUT
						MOV		ManejadorS, EAX

						; Leer los valores de A, B y C
						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt01, Long_ME01, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, A

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt02, Long_ME02, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, B

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt03, Long_ME03, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, C1

						; Evaluar la expresión E = ( 4 * A * B ) - ( C * C )
						MOV		EAX, 4
						IMUL	A				; 4 * A
						IMUL	B				; 4 * A * B
						MOV		EBX, EAX		; EBX = 4 * A * B

						MOV		EAX, C1
						IMUL	C1				; EAX = C * C

						SUB		EBX, EAX
						MOV		E, EBX			; E = ( 4 * A * B ) - ( C * C )

						; Mostrar el valor de E en pantalla
						INVOKE	WriteConsoleA, ManejadorS, ADDR MenSal01, Long_MS01, ADDR Caracteres, 0
						MacroEnteroACadena	E, Texto, Caracteres
						INVOKE	WriteConsoleA, ManejadorS, ADDR Texto, Caracteres, ADDR Caracteres, 0
						INVOKE	WriteConsoleA, ManejadorS, ADDR SaltoLinea, 2, ADDR Caracteres, 0

						; Salir al S. O.
						INVOKE	ExitProcess, 0
Principal				ENDP
						END		Principal























