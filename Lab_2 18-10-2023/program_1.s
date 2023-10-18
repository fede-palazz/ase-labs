;--------------------------------------------
; Program: program_1.s
; Floating point operations
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
    daddi R1,R0,0       ; COUNTER REG
    daddi R2,R0,64      ; MAX RANGE
    daddi R3,R0,0       ; POINTER REG

LOOP:
    ; Load values
    l.d F1,v1(R1)
    l.d F2,v2(R1)
    l.d F3,v3(R1)
    l.d F4,v4(R1)
    ; Compute calculations
    ; v5
    mul.d F5,F1,F2
    add.d F10,F3,F4
    add.d F5,F5,F10
    ; v6
    add.d F10,F4,F1
    div.d F6,F5,F10
    ; v7
    add.d F10,F2,F3
    mul.d F7,F6,F10
    ; Store values
    s.d F5,v5(R1)
    s.d F6,v6(R1)
    s.d F7,v7(R1)
    ; Update counters
    daddi R1,R1,8
    daddi R2,R2,-1
    ; Check loop condition
    bnez R2,LOOP

HALT