						TITLE	EXPRESION NUMERO DOS
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
N						DWORD	0
M						DWORD	0
R						DWORD	0
MenEnt01				BYTE	"Proporcione el valor de la variable N: "
Long_ME01				EQU		$ - MenEnt01
MenEnt02				BYTE	"Proporcione el valor de la variable M: "
Long_ME02				EQU		$ - MenEnt02
MenEnt03				BYTE	"Proporcione el valor de la variable R: "
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
						MacroCadenaAEntero	Texto, N

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt02, Long_ME02, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, M

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt03, Long_ME03, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, R
						

						;E = ( N2/ N ) * ( 4 – M ) + ( R * 2 )
						; Evaluar la expresión E = ( N2/ N ) * ( 4 – M ) + ( R * 2 )
						;( N2/ N )
						MOV		EAX, N			;EAX = N
						IMUL	N				;EAX = N2 = N*N
						IDIV	N				;EAX = (N2/N)
						MOV		EBX, EAX		;EBX = EAX = (N2/N)

						;(4-M)
						MOV		EAX, 4			;EAX=4
						SUB		EAX, M			;EAX = (4-M)
						IMUL	EBX				;EAX = EAX*EBX = (N2/N)*(4-M)
						MOV		EBX, EAX		;EBX = EAX = (N2/N)*(4-M)
						
						;(R*2)
						MOV		EAX,2			;EAX = 2
						IMUL	R				;EAX = (R*2)
						ADD		EBX,EAX			;EBX= EBX+EAX = (N2/N)*(4-M)+( R*2 )
						
						;E = ( N2/ N ) * ( 4 – M ) + ( R * 2 )
						MOV		E, EBX			;E = ( N2/ N ) * ( 4 – M ) + ( R * 2 )

						; Mostrar el valor de E en pantalla
						INVOKE	WriteConsoleA, ManejadorS, ADDR MenSal01, Long_MS01, ADDR Caracteres, 0
						MacroEnteroACadena	E, Texto, Caracteres
						INVOKE	WriteConsoleA, ManejadorS, ADDR Texto, Caracteres, ADDR Caracteres, 0
						INVOKE	WriteConsoleA, ManejadorS, ADDR SaltoLinea, 2, ADDR Caracteres, 0

						; Salir al S. O.
						INVOKE	ExitProcess, 0
Principal				ENDP
						END		Principal























