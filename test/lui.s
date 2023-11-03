	.data

	.text
MAIN:
	;lui r7, 0xC1A0
	;ori r7,r7, 0xFEDE
	;dsll r7, r7, 31
	;dsll r7, r7, 1
	;dsrl r7,r7,31
	;dsrl r7,r7,1
    lui R7,0x80
	

	HALT	;the end
