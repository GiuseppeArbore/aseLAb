	.data
v1:	.double 1.0, 1.0, 1.0, 1.0
	.double 1.0, 2.0, 3.0, 4.0
	.double 5.0, 6.0, 7.0, 8.0
	.double 9.0, 10.0, 11.0, 12.0
	.double 2.5, 2.5, 2.5, 2.5
	.double 1.5, 2.5, 3.5, 4.5
	.double 5.5, 6.5, 7.5, 8.5
	.double 9.5, 10.5, 11.5, 12.5
	.double 3.2, 3.2, 3.2, 3.2
	.double 1.2, 2.2, 3.2, 4.2
	.double 5.2, 6.2, 7.2, 8.2
	.double 9.2, 10.2, 11.2, 12.2
	.double 4.2, 4.2, 4.2, 4.2
	.double 1.2, 2.2, 3.2, 4.2
	.double 5.0, 6.0, 7.0, 8.0
	.double 9.0, 10.0, 11.0, 12.0

v4:	.double 4.0, 4.0, 4.0, 4.0
	.double 1.0, 2.0, 3.0, 4.0
	.double 5.0, 6.0, 7.0, 8.0
	.double 9.0, 10.0, 11.0, 12.0
	.double 3.0, 3.0, 3.0, 3.0
	.double 1.0, 2.0, 3.0, 4.0
	.double 5.0, 6.0, 7.0, 8.0
	.double 9.0, 10.0, 11.0, 12.0
	.double 1.9, 1.9, 1.9, 1.9
	.double 1.9, 2.9, 3.9, 4.9
	.double 5.9, 6.9, 7.9, 8.9
	.double 9.9, 10.9, 11.9, 12.9
	.double 2.9, 2.9, 2.9, 2.9
	.double 1.8, 2.8, 3.8, 4.8
	.double 5.8, 6.8, 7.8, 8.8
	.double 9.8, 10.8, 11.8, 12.8
	
v2: .double 0.1, 0.1, 0.1, 0.1
	.double 1.1, 2.1, 3.1, 4.1
	.double 5.1, 6.1, 7.1, 8.1
	.double 9.1, 10.1, 11.1, 12.1
	.double 0.1, 0.1, 0.1, 0.1
	.double 1.1, 2.1, 3.1, 4.1
	.double 5.2, 6.2, 7.2, 8.2
	.double 9.2, 10.2, 11.2, 12.2
	.double 0.3, 0.3, 0.3, 0.3
	.double 1.3, 2.3, 3.3, 4.3
	.double 5.3, 6.3, 7.3, 8.3
	.double 9.3, 10.3, 11.3, 12.3
	.double 0.3, 0.3, 0.3, 0.3
	.double 1.3, 2.3, 3.3, 4.3
	.double 5.0, 6.0, 7.0, 8.0
	.double 9.0, 10.0, 11.0, 12.0
	
v3: .double 0.0, 0.0, 0.0, 0.0
	.double 1.2, 2.2, 3.2, 4.2
	.double 5.1, 6.1, 7.1, 8.1
	.double 9.1, 10.1, 11.1, 12.1
	.double 0.0, 0.0, 0.0, 0.0
	.double 1.3, 2.5, 3.5, 4.5
	.double 5.7, 6.7, 7.7, 8.7
	.double 9.5, 10.5, 11.5, 12.5
	.double 0.9, 0.9, 0.9, 0.9
	.double 1.6, 2.6, 3.6, 4.6
	.double 5.3, 6.3, 7.3, 8.3
	.double 9.8, 10.8, 11.8, 12.8
	.double 11.4, 11.4, 11.4, 11.4
	.double 1.4, 2.4, 3.4, 4.4
	.double 5.1, 6.1, 7.1, 8.1
	.double 9.0, 10.0, 11.0, 12.0
lst:	.byte	64

	
v5:	.space	512
v6: .space	512
v7:	.space	512



	.text
main:
	dadd	R8, R0, R0
	dadd	R10, R0, R0
	lb		R9, lst(R0)		


ciclo:
	l.d	F1, v1(R8)
	l.d	F2, v2(R8)
	l.d	F3,	v3(R8)
	l.d	F4, v4(R8)
	mul.d	F5, F1, F2
	add.d	F5, F5, F3
	add.d	F5, F5, F4
	s.d		F5, v5(R8)
	add.d	F6, F4, F1
	div.d	F6, F5, F6
	s.d		F6, v6(R8)
	add.d	F7, F2, F3
	mul.d	F7, F7, F6
	s.d		F7, v7(R8)
	daddi	R10, R10, 1
	daddi	R8, R8, 8
	bne		R10, R9, ciclo
	
	halt
	