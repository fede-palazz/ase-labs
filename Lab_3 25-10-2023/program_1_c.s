;--------------------------------------------
; Program: program_1_c.s
; Floating point operations loop unrolling
;--------------------------------------------

    .data
v1:     .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1

v2:     .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1

v3:     .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1

v4:     .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
        .double 1,1,1,1,1,1,1,1
v5:     .space  512
v6:     .space  512
v7:     .space  512

    .text
MAIN:
    ;daddi R1,R0,0              ; counter reg i
    daddi R2,R0,64              ; max loop range
    ;daddi R3,R0,0              ; pointer reg
    daddi R4,R0,1               ; m = 1
    ;daddi R5,R0,0              ; is_even flag reg
    ;add.d F8,F0,F0             ; p = 0.0
    ;add.d F9,F0,F0             ; k = 0.0

LOOP:
    ; load values from memory
    l.d F1,v1(R3)
    l.d F4,v4(R3)

IS_EVEN_1:
    ; m << i (= m * 2^i)
    dsllv R4,R4,R1              ; logical shift left
    ; (double)m
    mtc1 R4,F10                 ; move m to F10 temp register
    cvt.d.l F10,F10             ; convert F10 value to FP
    ; p = v1[i] * (double)m
    mul.d F8,F1,F10
    l.d F2,v2(R3)
    l.d F3,v3(R3)
    ; m = (int) p -> (int) F8
    cvt.l.d F8,F8               ; convert m value to integer
    mfc1 R4,F8                  ; move p to m integer register
    ;J RESULTS
    daddi R5,R0,1               ; R5 = 1

RESULTS_EVEN_1:
    ; v6[i]
    add.d F10,F9,F1             ; k + v1[i]
    div.d F6,F5,F10             ; v5[i] / (k + v1[i])
    ; v5[i]
    mul.d F12,F8,F2              ; p*v2[i]
    add.d F11,F3,F4             ; v3[i] + v4[i]
    add.d F13,F12,F11             ; p*v2[i] + v3[i] + v4[i]
    s.d F13,v5(R3)
    ; v7[i]
    add.d F7,F2,F3              ; v2[i] + v3[i]
    mul.d F7,F7,F6              ; v6[i]*(v2[i] + v3[i])
    s.d F6,v6(R3)
    s.d F7,v7(R3)

IS_ODD_1:                       ; i+1 -> R3+8
    ; m * i
    dmul R10,R4,R1
    l.d F1,v1+8(R3)
    l.d F4,v4+8(R3)
    ; (double) m*i
    mtc1 R10,F10                ; move m*i to F10 temp reg
    cvt.d.l F10,F10             ; convert F10 value to FP
    ; p = v1[i] / ((double) m* i))
    div.d F8,F1,F10
    l.d F2,v2+8(R3)
    l.d F3,v3+8(R3)
    ; (int)v4[i]
    l.d F4,v4+8(R3)
    cvt.l.d F4,F4               ; convert R10 value to integer
    mfc1 R10,F4                 ; move v4[i] to R10 integer reg
    ; v4[i] / 2^i (= v4[i] >> i) -> arithmetic shift
    dsrav R10,R10,R1            ; shift right arithmetic by i
    ; k = ((float)((int)v4[i] / 2^i)
    mtc1 R10,F9                 ; move R10 to k reg
    cvt.d.l F9,F9               ; convert k value to FP
    daddi R5,R0,0               ; R5 = 0

RESULTS_ODD_1:                  ; i+1 -> R3+8
    ; v6[i]
    add.d F10,F9,F1             ; k + v1[i]
    div.d F6,F5,F10             ; v5[i] / (k + v1[i])
    ; v5[i]
    mul.d F12,F8,F2              ; p*v2[i]
    add.d F11,F3,F4             ; v3[i] + v4[i]
    add.d F13,F12,F11             ; p*v2[i] + v3[i] + v4[i]
    s.d F13,v5+8(R3)
    ; v7[i]
    add.d F7,F2,F3              ; v2[i] + v3[i]
    mul.d F7,F7,F6              ; v6[i]*(v2[i] + v3[i])
    s.d F6,v6+8(R3)
    s.d F7,v7+8(R3)

IS_EVEN_2:                      ; i+2 -> R3+16
    l.d F1,v1+16(R3)
    l.d F4,v4+16(R3)
    ; m << i (= m * 2^i)
    dsllv R4,R4,R1              ; logical shift left
    ; (double)m
    mtc1 R4,F10                 ; move m to F10 temp register
    cvt.d.l F10,F10             ; convert F10 value to FP
    ; p = v1[i] * (double)m
    mul.d F8,F1,F10
    l.d F2,v2+16(R3)
    l.d F3,v3+16(R3)
    ; m = (int) p -> (int) F8
    cvt.l.d F8,F8               ; convert m value to integer
    mfc1 R4,F8                  ; move p to m integer register
    daddi R5,R0,1               ; R5 = 1

RESULTS_EVEN_2:                 ; i+2 -> R3+16
    ; v6[i]
    add.d F10,F9,F1             ; k + v1[i]
    div.d F6,F5,F10             ; v5[i] / (k + v1[i])
    ; v5[i]
    mul.d F12,F8,F2              ; p*v2[i]
    add.d F11,F3,F4             ; v3[i] + v4[i]
    add.d F13,F12,F11             ; p*v2[i] + v3[i] + v4[i]
    s.d F13,v5+16(R3)
    ; v7[i]
    add.d F7,F2,F3              ; v2[i] + v3[i]
    mul.d F7,F7,F6              ; v6[i]*(v2[i] + v3[i])
    s.d F6,v6+16(R3)
    s.d F7,v7+16(R3)

IS_ODD_2:                       ; i+3 -> R3+24
    ; m * i
    dmul R10,R4,R1
    l.d F1,v1+24(R3)
    l.d F4,v4+24(R3)
    ; (double) m*i
    mtc1 R10,F10                ; move m*i to F10 temp reg
    cvt.d.l F10,F10             ; convert F10 value to FP
    ; p = v1[i] / ((double) m* i))
    div.d F8,F1,F10
    l.d F2,v2+24(R3)
    l.d F3,v3+24(R3)
    ; (int)v4[i]
    l.d F4,v4+24(R3)
    cvt.l.d F4,F4               ; convert R10 value to integer
    mfc1 R10,F4                 ; move v4[i] to R10 integer reg
    ; v4[i] / 2^i (= v4[i] >> i) -> arithmetic shift
    dsrav R10,R10,R1            ; shift right arithmetic by i
    ; k = ((float)((int)v4[i] / 2^i)
    mtc1 R10,F9                 ; move R10 to k reg
    cvt.d.l F9,F9               ; convert k value to FP
    daddi R5,R0,0               ; R5 = 0

RESULTS_ODD_2:                  ; i+3 -> R3+24
    ; v6[i]
    add.d F10,F9,F1             ; k + v1[i]
    div.d F6,F5,F10             ; v5[i] / (k + v1[i])
    ; v5[i]
    mul.d F12,F8,F2             ; p*v2[i]
    add.d F11,F3,F4             ; v3[i] + v4[i]
    add.d F13,F12,F11           ; p*v2[i] + v3[i] + v4[i]
    s.d F13,v5+24(R3)
    ; v7[i]
    add.d F7,F2,F3              ; v2[i] + v3[i]
    mul.d F7,F7,F6              ; v6[i]*(v2[i] + v3[i])
    s.d F6,v6+24(R3)
    s.d F7,v7+24(R3)

UPDATE_COUNTERS:
    daddi R1,R1,4               ; i++
    ; check loop condition
    bne R1,R2,LOOP
    daddi R3,R3,32              ; R3 += 32

END:
    HALT