						TITLE	EXPRESION NUMERO TRES
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
Y						DWORD	0
Z						DWORD	0
MenEnt01				BYTE	"Proporcione el valor de la variable N: "
Long_ME01				EQU		$ - MenEnt01
MenEnt02				BYTE	"Proporcione el valor de la variable M: "
Long_ME02				EQU		$ - MenEnt02
MenEnt03				BYTE	"Proporcione el valor de la variable Y: "
Long_ME03				EQU		$ - MenEnt03
MenEnt04				BYTE	"Proporcione el valor de la variable Z: "
Long_ME04				EQU		$ - MenEnt04
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

						; Leer los valores de N,M,Y,Z
						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt01, Long_ME01, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, N

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt02, Long_ME02, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, M

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt03, Long_ME03, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, Y

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt04, Long_ME04, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, Z
						

						; Evaluar la expresión E = ( ( N * M ) / ( Y + Z ) ) – 1
						;( N*M)
						MOV		EAX, N			;EAX = N
						IMUL	M				;EAX = N*M
						
						;(Y+Z)
						MOV		EBX, Y			;EBX=Y
						ADD		EBX,Z			;EBX=(Y+Z)

						;( ( N * M ) / ( Y + Z ) ) 
						IDIV	EBX				;EAX=EAX/EBX = ( ( N * M ) / ( Y + Z ) ) 

						;-1
						SUB 	EAX,1				;EAX-1


						
						;E = ( ( N * M ) / ( Y + Z ) ) – 1
						MOV		E, EAX			;E = ( ( N * M ) / ( Y + Z ) ) – 1

						; Mostrar el valor de E en pantalla
						INVOKE	WriteConsoleA, ManejadorS, ADDR MenSal01, Long_MS01, ADDR Caracteres, 0
						MacroEnteroACadena	E, Texto, Caracteres
						INVOKE	WriteConsoleA, ManejadorS, ADDR Texto, Caracteres, ADDR Caracteres, 0
						INVOKE	WriteConsoleA, ManejadorS, ADDR SaltoLinea, 2, ADDR Caracteres, 0

						; Salir al S. O.
						INVOKE	ExitProcess, 0
Principal				ENDP
						END		Principal























