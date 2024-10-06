	.data
i:	.double 1.0, 1.0, 1.0, 1.0, 1.0
	.double 1.0, 2.0, 3.0, 4.0, 5.0
	.double 5.0, 6.0, 7.0, 8.0, 9.0
	.double 9.0, 10.0, 11.0, 12.0, 13.0
	.double 2.5, 2.5, 2.5, 2.5, 2.5
	.double 1.5, 2.5, 3.5, 4.5, 6.5
	
w:	.double 1.5, 2.5, 3.5, 4.5, 6.5
	.double 5.0, 6.0, 7.0, 8.0, 9.0
	.double 9.0, 10.0, 11.0, 12.0, 13.0
	.double 2.5, 2.5, 2.5, 2.5, 2.5
	.double 1.0, 2.0, 3.0, 4.0, 5.0
	.double 1.0, 1.0, 1.0, 1.0, 1.0
	
k:	.byte 30
b:	.double 0xab
ex: .double 0x7ff
z:	.double 0.0

	.text
main:	
	l.d F4, b(R0)
	l.d F5, ex(R0)
	l.d F6, z(R0)
	lb	R1, k(R0)
	add.d F7, F6, F6
	dadd R2, R0, R0

loop:	
	daddi R1, R1, -1
	l.d	F1, i(R2)
	l.d F2, w(R2)
	mul.d	F1, F1, F2
	daddi R2, R2, 8
	add.d	F6, F6, F1
	bnez	R1, loop

	add.d	F6, F6, F4
	mfc1	R2, F6
	mfc1	R1, F5
	dsll	R2, R2, 1
	dsrl	R2, R2, 30
	dsrl	R2, R2, 23
	bne		R2, R1, fine
	add.d	F6, F7, F7
	
fine:	halt
	