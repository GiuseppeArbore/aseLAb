	.data
v1:	.byte	2, 6, -3, 11, 9, 11, -3, 6, 2
v2:	.byte	4, 7, -10, 3, 11, 9, 7, 6, 4, 7
v3:	.byte	9, 22, 5, -1, 9, -1, 5, 22, 9
flag1:	.space	1
flag2:	.space	1
flag3:	.space	1
v4:	.space	9
dim:	.byte	8
lst:	.byte	9

	.text
main:
	dadd	R1, R0, R0	;R1=0
	daddi	R5, R0, 1	;R5=1
	dadd	R6, R0, R0	;R6=0
	lb	R4, dim(R0)		;R4=14
	lb 	R7, dim(R0)		;R7=14
	lb	R8, lst(R0)
	sb	R5, flag1(R0)	
	sb	R5, flag2(R0)
	sb	R5, flag3(R0)

inizializzo:
	sb	R0,v4(R1)
	daddi R1, R1, 1
	bne R1, R8, inizializzo
	dadd	R1, R0, R0
	

loop1:
	beq	R1, R4, somma1	;esce quando R1=7
	lb	R2, v1(R1)
	lb	R3, v1(R4)
	daddi	R1, R1, 1
	daddi	R4, R4, -1
	beq	R2, R3, loop1
	sb	R0, flag1(R0)	;metto flag1 a 0
	dadd	R1, R0, R0
	dadd	R4, R0, R7

loop2:	
	beq	R1, R4, somma2
	lb	R2, v2(R1)
	lb	R3, v2(R4)
	daddi	R1, R1, 1
	daddi	R4, R4, -1
	beq	R2, R3, loop2
	sb	R0, flag2(R0)
	dadd	R1, R0, R0
	dadd	R4, R0, R7
	
loop3:	
	beq	R1, R4, somma3
	lb	R2, v3(R1)
	lb	R3, v3(R4)
	daddi	R1, R1, 1
	daddi	R4, R4, -1
	beq	R2, R3, loop3
	sb	R0, flag3(R0)


somma1:
	lb	R1, v1(R6)
	sb	R1, v4(R6)
	daddi	R6, R6, 1
	bne	R6, R7, somma1
	dadd	R6, R0, R0
	lb	R4, dim(R0)
	dadd	R1, R0, R0
	dadd	R4, R0, R7
	j	loop2
	
somma2:
	lb	R1, v2(R6)
	lb	R2, v4(R6)
	dadd	R1, R1, R2
	sb	R1, v4(R6)
	daddi	R6, R6, 1
	bne	R6, R7, somma2
	dadd	R6, R0, R0
	lb	R4, dim(R0)
	dadd	R1, R0, R0
	dadd 	R4, R0, R7
	j	loop3

somma3:
	lb	R1, v3(R6)
	lb	R2, v4(R6)
	dadd	R1, R1, R2
	sb	R1, v4(R6)
	daddi	R6, R6, 1
	bne	R6, R7, somma3
	halt
