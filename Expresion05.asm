						TITLE	EXPRESION NUMERO CINCO
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
C						DWORD	0
D						DWORD	0
F						DWORD	0
MenEnt01				BYTE	"Proporcione el valor de la variable E: "
Long_ME01				EQU		$ - MenEnt01
MenEnt02				BYTE	"Proporcione el valor de la variable A: "
Long_ME02				EQU		$ - MenEnt02
MenEnt03				BYTE	"Proporcione el valor de la variable B: "
Long_ME03				EQU		$ - MenEnt03
MenEnt04				BYTE	"Proporcione el valor de la variable C: "
Long_ME04				EQU		$ - MenEnt04
MenEnt05				BYTE	"Proporcione el valor de la variable D: "
Long_ME05				EQU		$ - MenEnt05
MenEnt06				BYTE	"Proporcione el valor de la variable F: "
Long_ME06				EQU		$ - MenEnt06
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

						; Leer los valores de E,A,B,C,D,F
						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt01, Long_ME01, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, E

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt02, Long_ME02, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, A

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt03, Long_ME03, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, B

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt04, Long_ME04, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, C
						
						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt05, Long_ME05, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, D


						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt06, Long_ME06, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, F

						; Evaluar la expresión E = A – ( B + ( C – E ) ) + ( D – F )
						;(C-E)
						MOV		EAX, C			;EAX = C
						SUB		EAX,E			;EAX= EAX-E = (C-E)

						;( B + ( C – E ) )
						MOV		EBX,B			;EBX = B
						ADD		EBX,EAX			;EBX = EBX+EAX = ( B + ( C – E ))
						
						;A – ( B + ( C – E ) )
						MOV		EAX, A			;EAX = A
						SUB		EAX,EBX			;EAX = EAX - EBX = A – ( B + ( C – E ) )
						

						;( D – F )
						MOV 		EBX,D			;EBX=D
						SUB		EBX,F			;EBX-F = (D-F)

						;A – ( B + ( C – E ) ) + ( D – F )
						ADD		EAX,EBX			;EAX+EBX=A – ( B + ( C – E ) ) + ( D – F )
						
						;E = A – ( B + ( C – E ) ) + ( D – F )
						MOV		E,EAX			;E=EAX... E = A – ( B + ( C – E ) ) + ( D – F )


						; Mostrar el valor de E en pantalla
						INVOKE	WriteConsoleA, ManejadorS, ADDR MenSal01, Long_MS01, ADDR Caracteres, 0
						MacroEnteroACadena	E, Texto, Caracteres
						INVOKE	WriteConsoleA, ManejadorS, ADDR Texto, Caracteres, ADDR Caracteres, 0
						INVOKE	WriteConsoleA, ManejadorS, ADDR SaltoLinea, 2, ADDR Caracteres, 0

						; Salir al S. O.
						INVOKE	ExitProcess, 0
Principal				ENDP
						END		Principal























