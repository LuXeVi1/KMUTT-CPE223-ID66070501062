Data    DCD     10, 12, 8, 1, 5, 7, 11, 6, 8    ; same input data

Main    
    LDR     r0, =Data        ; array base address
    MOV     r1, #0          ; start index
    MOV     r2, #8          ; end index (array length - 1)
    BL      QuickSort
    B       Exit

; QuickSort implementation
; r0: array base address
; r1: start index
; r2: end index
QuickSort
    STMFD   sp!, {r0-r4, lr}
    CMP     r1, r2          ; check if start >= end
    BGE     QSortEnd
    
    ; Calculate pivot position
    MOV     r3, r1          ; i = start
    ADD     r4, r1, #1      ; j = start + 1
    
PartLoop
    CMP     r4, r2          ; while j <= end
    BGT     PlaceLoop
    
    ; Compare elements
    LSL     r12, r4, #2     ; j * 4 for word alignment
    ADD     r12, r0, r12
    LDR     r12, [r12]      ; load arr[j]
    
    LSL     r11, r1, #2     ; pivot_index * 4
    ADD     r11, r0, r11
    LDR     r11, [r11]      ; load pivot
    
    CMP     r12, r11        ; compare with pivot
    BGE     NextJ
    
    ; Swap elements if needed
    ADD     r3, r3, #1      ; i++
    
    LSL     r12, r3, #2     ; i * 4
    ADD     r12, r0, r12    ; address of arr[i]
    LSL     r11, r4, #2     ; j * 4
    ADD     r11, r0, r11    ; address of arr[j]
    
    LDR     r10, [r12]      ; load arr[i]
    LDR     r9, [r11]       ; load arr[j]
    STR     r9, [r12]       ; store in arr[i]
    STR     r10, [r11]      ; store in arr[j]
    
NextJ
    ADD     r4, r4, #1      ; j++
    B       PartLoop
    
PlaceLoop
    ; Place pivot in correct position
    LSL     r12, r1, #2     ; pivot_index * 4
    ADD     r12, r0, r12    ; address of pivot
    LSL     r11, r3, #2     ; i * 4
    ADD     r11, r0, r11    ; address of final position
    
    LDR     r10, [r12]      ; load pivot
    LDR     r9, [r11]       ; load element at i
    STR     r9, [r12]       ; store in pivot position
    STR     r10, [r11]      ; store pivot at i
    
    ; Recursive calls
    STMFD   sp!, {r1-r2}    ; save current bounds
    SUB     r2, r3, #1      ; end = i - 1
    BL      QuickSort       ; sort left partition
    LDMFD   sp!, {r1-r2}    ; restore bounds
    
    STMFD   sp!, {r1}       ; save start
    ADD     r1, r3, #1      ; start = i + 1
    BL      QuickSort       ; sort right partition
    LDMFD   sp!, {r1}       ; restore start

QSortEnd
    LDMFD   sp!, {r0-r4, pc}

Exit
    END