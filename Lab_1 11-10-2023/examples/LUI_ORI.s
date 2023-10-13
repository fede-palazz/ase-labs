; DATA SECTION
	.data
; constant and variables 


;long int result



; CODE SECTION      
	.text
MAIN:
	lui r7, 0xC1A0
	ori r7,r7, 0xFEDE
	dsll r7, r7, 31
	dsll r7, r7, 1
	dsrl r7,r7,31
	dsrl r7,r7,1
	

	HALT	;the end
