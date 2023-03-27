						TITLE	EXPRESION NUMERO CUATRO
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
X						DWORD	0
Y						DWORD	0
B						DWORD	0
R						DWORD	0
Z						DWORD	0
MenEnt01				BYTE	"Proporcione el valor de la variable X: "
Long_ME01				EQU		$ - MenEnt01
MenEnt02				BYTE	"Proporcione el valor de la variable Y: "
Long_ME02				EQU		$ - MenEnt02
MenEnt03				BYTE	"Proporcione el valor de la variable B: "
Long_ME03				EQU		$ - MenEnt03
MenEnt04				BYTE	"Proporcione el valor de la variable R: "
Long_ME04				EQU		$ - MenEnt04
MenEnt05				BYTE	"Proporcione el valor de la variable Z: "
Long_ME05				EQU		$ - MenEnt05
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

						; Leer los valores de X,Y,B,R,Z
						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt01, Long_ME01, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, X

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt02, Long_ME02, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, Y

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt03, Long_ME03, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, B

						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt04, Long_ME04, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, R
						
						INVOKE	WriteConsoleA, ManejadorS, ADDR MenEnt05, Long_ME05, ADDR Caracteres, 0
						INVOKE	ReadConsoleA, ManejadorE, ADDR Texto, 13, ADDR Caracteres, 0
						MacroCadenaAEntero	Texto, Z


						; Evaluar la expresión E = (X * Y) + (B – 3) + (R / Z)
						;( X*Y)
						MOV		EAX, X			;EAX = X
						IMUL	Y				;EAX = X*Y
						
						;(B-3)
						MOV		EBX, B			;EBX=B
						SUB		EBX,3			;EBX=(B-3)

						;(X*Y)+(B-3)
						ADD 		EAX,EBX			;EAX+EBX= (X*Y)+(B-3)
						MOV 		EBX,EAX			;EBX=EAX =(X*Y)+(B-3)

						;(R / Z)
						MOV 		EAX, R			;EAX= R
						IDIV	Z				;EAX=(R/Z)

						;E = (X * Y) + (B – 3) + (R / Z)
						ADD	EBX,EAX				;EBX=EBX+EAX = (X * Y) + (B – 3) + (R / Z)
				
						;E = (X * Y) + (B – 3) + (R / Z)
						MOV		E, EBX			;E = (X * Y) + (B – 3) + (R / Z)

						; Mostrar el valor de E en pantalla
						INVOKE	WriteConsoleA, ManejadorS, ADDR MenSal01, Long_MS01, ADDR Caracteres, 0
						MacroEnteroACadena	E, Texto, Caracteres
						INVOKE	WriteConsoleA, ManejadorS, ADDR Texto, Caracteres, ADDR Caracteres, 0
						INVOKE	WriteConsoleA, ManejadorS, ADDR SaltoLinea, 2, ADDR Caracteres, 0

						; Salir al S. O.
						INVOKE	ExitProcess, 0
Principal				ENDP
						END		Principal























