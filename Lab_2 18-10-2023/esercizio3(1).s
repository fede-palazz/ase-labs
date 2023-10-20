        .data
i:		.double    1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0;
        .double    1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
        .double    1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
        .double    1.0, 1.0, 1.0, 1.0, 1.0, 1.0
w:      .double    1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
		.double    1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
        .double    1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
        .double    1.0, 1.0, 1.0, 1.0, 1.0, 1.0
b:		.double    171.0
d:		.double    0xab
ris: 	.space     8



        .text
MAIN:   daddui  R1,R0,30	;R1 = 30
		dadd    R2,R0,R0	;R2   0   POINTER REG
		l.d		F18, b(R0)
		daddi	R31, R0,1
		;daddi 	R21, R0,2047;tutti zeri (dal più significativo e tutti uni)
;F17 = risultato		
		
LOOP1:		
		l.d F10, i(R2)
		l.d	F11, i(R2)
		mul.d   F5, F10, F11
		add.d	F17, F17, F5
		daddi	R2, R2, 8
		daddi	R1, R1, -1
		BNEZ R1, LOOP1

BIAS:	add.d 	F17, F17, F18
		
SHIF:	mfc1 R17, F17
		DSLL 	R17, R17, 1
		DSRL	R17, R17, 21
		DSRL 	R17, R17, 31
		daddi   R20, R20, -2047
		beqz	R20, ZERO
		sd 	R31, ris(R0)
		HALT
ZERO:	sd 	R0, ris(R0)
		HALT