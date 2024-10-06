	AREA vettori_morse, DATA, READONLY
size_1   DCB 0, 'E', 1, 'T'
size_2   DCB 0, 'I', 1, 'A', 2, 'N', 3, 'M'
size_3   DCB 0, 'S', 1, 'U', 2, 'R', 3, 'W', 4, 'D', 5, 'K', 6, 'G', 7, 'O'
size_4   DCB 0, 'H', 1, 'V', 2, 'F', 4, 'L', 6, 'P', 7, 'J', 8, 'B', 9, 'X', 10, 'C', 11, 'Y', 12, 'Z', 13, 'Q'
size_5   DCB 0, '5', 1, '4', 3, '3', 7, '2', 15, '1', 16, '6', 24, '7', 28, '8', 30, '9', 31, '0'

spaz	 DCB ' '
	
	AREA fun, CODE, READONLY

	export function1

function1
	MOV R12, sp
	STMFD sp!,{r4-r8, r10-r11, lr}
	;R0 contiene vet_input
	;R1 contiene lenght
	;R2 contiene output
	;R3 output lenght
	;sp change_symbol 2  -->r6
	;sp+4 space 3    --> r5
	;sp+8 sentence_end 4   -->R4
	;r10 contatore
	;r11 valore 
	
	LDR R4, [r12, #8]
	LDR R5, [r12, #4]
	LDR R6, [r12]
	
	LDRB R7, [r0]
	
new		MOV R10, #0
		MOV R11, #0
		

loop	LDRB R7, [r0]
		CMP R7, r6   ;VEDO SE 2
		BEQ lettera
		CMP R7, r5   ; VEDO SE 3
		BEQ spazio
		BGT fine     ; VEDO SE 4
		
		ADD R0, R0, #1  ;incremento indirizzo
		ADD R10,R10,#1	;incremeno lunghezza
		LSL R11, #1		;shifto a sx di 1 il valore che ho
		ADD R11, R11, R7 ;aggiungo il mio valore
		b loop  
	

lettera 
		BL tree
		add r0, r0, #1
		b new
		
spazio		
		BL		tree
		
		LDR R7, =spaz
		LDRB R7, [r7]
		STRB R7, [R2]
		ADD R0, R0, #1
		ADD R2, R2, #1
		ADD R3, R3, #1
		
		
		b new 
	
fine 	
		BL tree
		b u
		
tree proc
		PUSH {r4, r5, r6, R10, R11, LR}
		CMP R10, #1
		LDREQ R4, =size_1
		CMP R10, #2
		LDREQ R4, =size_2
		CMP R10, #3
		LDREQ R4, =size_3
		CMP R10, #4
		LDREQ R4, =size_4
		CMP R10, #5
		LDREQ R4, =size_5
		
loopP	LDRB R5, [R4]
		CMP R11, R5
		BEQ trovato
		ADD R4, R4, #2		
		b loopP
		
trovato add r4, r4, #1
		LDRB r6, [r4]
		STRB R6, [R2]
		ADD R2, R2, #1
		ADD R3, R3, #1	
		
		POP {r4, r5, r6, R10, R11, PC}
		endp
	
u		MOV R0, R3
		LDMFD sp!, {r4-r8, r10-r11, pc}
		
		END
