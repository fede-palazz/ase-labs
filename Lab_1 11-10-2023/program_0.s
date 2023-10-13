;-------------------------------------------
; Program: program_0.s
; Verify if the arrays are palindrome or not
;-------------------------------------------

    .data
v1:  	.byte   -2, 6, -3, 1, 9, 1, -3, 6, -2
v2:  	.byte   4, 7, -10, 3, 11, 9, 7, 6, 4, 7
v3:  	.byte   9, 2, 5, -1, -4, -1, 5, 2, 9
; Variables are inizialized to zero by default
fl1: 	.space 1
fl2: 	.space 1
fl3: 	.space 1
v4:  	.space 9

    .text
MAIN:
        ; Inizialize pointer registers
        daddi R1,R0,0           ; R1 = 0  POINTER REG LEFT
        daddi R2,R0,8           ; R2 = 8  POINTER REG RIGHT
        ; Inizialize temp registers
        daddi R3,R0,0           ; R3 = 0  TEMP REG 1
        daddi R4,R0,0           ; R4 = 0  TEMP REG 2
        ; Inizialize flag registers
        daddi R5,R0,0           ; R5 = 0  FLAG_1 REG
        daddi R6,R0,0           ; R6 = 0  FLAG_2 REG
        daddi R7,R0,0           ; R7 = 0  FLAG_3 REG

;-------------------------------------------
; POINT 1: Check if arrays are palindrome
;-------------------------------------------

LOOP1:   
        ; Load value from v1
        lb R3,v1(R1)
        lb R4,v1(R2)
        ; Check if paired values are the same
        bne R3,R4,NOT1
        ; Update pointers
        daddi R1,R1,1       ; R1++
        daddi R2,R2,-1      ; R2--
        ; Check whether the scan is finished
        bne R1,R2,LOOP1     ; continue the loop
        ; Palindrome array -> update flag 1
        daddi R5,R0,1       ; R5 = 1
        sb R5,fl1(R0)       ; fl1 = 1

NOT1:
        ; Reset array pointers
        daddi R1,R0,0    ; R1 = 0  POINTER REG LEFT
        daddi R2,R0,8    ; R2 = 8  POINTER REG RIGHT

LOOP2:   
        ; Load value from v2
        lb R3,v2(R1)
        lb R4,v2(R2)
        ; Check if paired values are the same
        bne R3,R4,NOT2
        ; Update pointers
        daddi R1,R1,1       ; R1++
        daddi R2,R2,-1      ; R2--
        ; Check whether the scan is finished
        bne R1,R2,LOOP2     ; continue the loop
        ; Palindrome array -> update flag 2
        daddi R6,R0,1       ; R6 = 1
        sb R6,fl2(R0)       ; fl2 = 1

NOT2:
        ; Reset array pointers
        daddi R1,R0,0    ; R1 = 0  POINTER REG LEFT
        daddi R2,R0,8    ; R2 = 8 POINTER REG RIGHT

LOOP3:   
        ; Load value from v3
        lb R3,v3(R1)
        lb R4,v3(R2)
        ; Check if paired values are the same
        bne R3,R4,NOT3
        ; Update pointers
        daddi R1,R1,1       ; R1++
        daddi R2,R2,-1      ; R2--
        ; Check whether the scan is finished
        bne R1,R2,LOOP3     ; continue the loop
        ; Palindrome array -> update flag 3
        daddi R7,R0,1       ; R7 = 1
        sb R7,fl3(R0)       ; fl3 = 1

NOT3:
        ; Reset array pointers
        daddi R1,R0,0    ; R1 = 0  POINTER REG LEFT
        daddi R2,R0,8   ; R2 = 8 POINTER REG RIGHT
        ; Reset temp registers
        daddi R3,R0,0    ; R3 = 0
        daddi R4,R0,0    ; R4 = 0

;---------------------------------------------------
; POINT 2: Sum of the elements in palindrome arrays
;---------------------------------------------------

CHECK_V1:
        ; Check whether v1 is palindrome
        ; R5 = 0 => v1 NOT palindrome => skip to v2
        beqz R5,CHECK_V2
        ; v1 is palindrome => sum v1[R1] in R4
        lb R3,v1(R1)
        ; R4 -> Accumulator register
        dadd R4,R4,R3

CHECK_V2:
        ; Check whether v2 is palindrome
        ; R6 = 0 => v2 NOT palindrome => skip to v3
        beqz R6,CHECK_V3
        ; v2 is palindrome => sum v2[R1] in R4
        lb R3,v2(R1)
        ; R4 -> Accumulator register
        dadd R4,R4,R3

CHECK_V3:
        ; Check whether v3 is palindrome
        ; R7 = 0 => v3 NOT palindrome => skip
        beqz R7,UPDATE_REGS
        ; v3 is palindrome => sum v3[R1] in R4
        lb R3,v3(R1)
        ; R4 -> Accumulator register
        dadd R4,R4,R3        

UPDATE_REGS:
        ; Save current sum in both v4[R1] and v4[R2]
        sb R4,v4(R1)
        sb R4,v4(R2)
        ; Reset accumulator register
        daddi R4,R0,0           ; R4 = 0
        ; Update pointers
        daddi R1,R1,1       ; R1++
        daddi R2,R2,-1      ; R2--
        ; Check whether the scan is over
        ; if R2 < R1 => exit the loop
        slt R3,R2,R1
        ; R3 = 0 => continue the loop
        beqz R3,CHECK_V1

END:
        HALT