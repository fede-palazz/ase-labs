;--------------------------------------------
; Program: program_1.s
; Neural Computation
;--------------------------------------------

    .data
i:      .double 1,1,1,1,1
        .double 1,1,1,1,1
        .double 1,1,1,1,1
        .double 1,1,1,1,1
        .double 1,1,1,1,1
        .double 1,1,1,1,1

w:      .double 1,1,1,1,1
        .double 1,1,1,1,1
        .double 1,1,1,1,1
        .double 1,1,1,1,1
        .double 1,1,1,1,1
        .double 1,1,1,1,1

b:      .word   0xAB    
y:      .space  8


    .text
MAIN:
    daddi R1,R0,0       ; COUNTER REG
    daddi R2,R0,30      ; MAX RANGE
    ld R3,b(R0)         ; Load b from word
    mtc1 R3, F10        ; Convert b to floating point value

LOOP:
    ; Load values
    l.d F1,i(R1)
    l.d F2,w(R1)
    ; Compute calculations
    mul.d F3,F1,F2      ; i * w
    add.d F4,F4,F3      ; x += i * w
    ; Update counters
    daddi R1,R1,8
    daddi R2,R2,-1
    ; Check loop condition
    bnez R2,LOOP
    ; Add b
    add.d F4,F4,F10     ; x += b

CHECK_NAN:
    mfc1 R6,F4          ; Convert exponent to decimal
    dsll R6,R5,1        ; Shift left 1
    dsrl R6,R6,31       ; Shift right 31
    dsrl R6,R6,23       ; Shift right 22
    daddi R6,R6,-2047   ; Subtract the desired exponent
    bne R6,R0,SAVE_Y    ; R6 != 0 => f(x) = x
    add.d F4,F0,F0      ; R6 = 0  => f(x) = 0

SAVE_Y:
    s.d F4, y(R0)

HALT