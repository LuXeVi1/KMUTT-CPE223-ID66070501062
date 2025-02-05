    AREA    QuickSort, CODE, READONLY
    ENTRY

    ; Define the array to be sorted
    Data    DCD     10, 12, 8, 1, 5, 7, 11, 6, 8
    Size    EQU     9  ; Number of elements in the array

    ; Registers:
    ; R0 = Base address of the array
    ; R1 = Low index
    ; R2 = High index
    ; R3 = Pivot element
    ; R4 = Temporary storage
    ; R5 = Loop counter
    ; R6 = Temporary storage
    ; R7 = Temporary storage

    ; Main function to call QuickSort
    MOV     R0, #Data
    MOV     R1, #0
    MOV     R2, #Size-1
    BL      QuickSort
    B       EndProgram

QuickSort
    ; Save the return address
    PUSH    {LR}

    ; Check if low < high
    CMP     R1, R2
    BGE     EndQuickSort

    ; Partition the array and get the pivot index
    BL      Partition

    ; Save the pivot index
    PUSH    {R2}

    ; Recursively sort the left sub-array
    SUB     R2, R2, #1
    BL      QuickSort

    ; Restore the pivot index
    POP     {R2}

    ; Recursively sort the right sub-array
    ADD     R1, R2, #1
    BL      QuickSort

EndQuickSort
    ; Restore the return address and return
    POP     {LR}
    BX      LR

Partition
    ; Save the return address
    PUSH    {LR}

    ; Load the pivot element (last element)
    LDR     R3, [R0, R2, LSL #2]

    ; Initialize the index of the smaller element
    SUB     R4, R1, #1

    ; Loop through the array
    MOV     R5, R1
PartitionLoop
    CMP     R5, R2
    BGE     EndPartitionLoop

    ; If current element is smaller than or equal to pivot
    LDR     R6, [R0, R5, LSL #2]
    CMP     R6, R3
    BGT     SkipSwap

    ; Increment the index of the smaller element
    ADD     R4, R4, #1

    ; Swap elements
    LDR     R7, [R0, R4, LSL #2]
    STR     R6, [R0, R4, LSL #2]
    STR     R7, [R0, R5, LSL #2]

SkipSwap
    ; Increment loop counter
    ADD     R5, R5, #1
    B       PartitionLoop

EndPartitionLoop
    ; Swap the pivot element with the element at the index of the smaller element + 1
    ADD     R4, R4, #1
    LDR     R6, [R0, R4, LSL #2]
    LDR     R7, [R0, R2, LSL #2]
    STR     R6, [R0, R2, LSL #2]
    STR     R7, [R0, R4, LSL #2]

    ; Return the pivot index
    MOV     R2, R4

    ; Restore the return address and return
    POP     {LR}
    BX      LR

EndProgram
    ; End of program
    END