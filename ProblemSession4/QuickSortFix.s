Data           dcd     10, 12, 8, 1, 5, 7, 11, 6, 8

               mov     r0, #0 ; Initialize counter
Start          ldr     r0, =Data ; Load array base address
               mov     r10, r0 ; r10 = low pointer
               add     r12, r0, #32 ; r12 = high pointer
               bl      qsort ; Call QuickSort
               b       Stop ; End program

Swap           stmfd   sp!, {r2, r3, lr}
               ldr     r2, [r0]
               ldr     r3, [r1]
               str     r2, [r1]
               str     r3, [r0]
               ldmfd   sp!, {r2, r3, pc}

Partt          stmfd   sp!, {r4-r6, lr}
               ldr     r4, [r12] ; Pivot = last element
               sub     r5, r10, #4 ; i = low - 1
               mov     r6, r10 ; j = low

partition_loop 
               cmp     r6, r12
               bge     end_partition
               ldr     r3, [r6]
               cmp     r3, r4
               bgt     skip_swap
               add     r5, r5, #4
               mov     r0, r5
               mov     r1, r6
               bl      Swap

skip_swap      
               add     r6, r6, #4
               b       partition_loop

end_partition  
               add     r5, r5, #4
               mov     r0, r5
               mov     r1, r12
               bl      Swap
               mov     r0, r5
               ldmfd   sp!, {r4-r6, pc}

qsort          stmfd   sp!, {r10, r12, lr}
               cmp     r10, r12
               bhs     qsort_end
               bl      Partt
               mov     r4, r0 ; Save pivot index

               sub     r12, r4, #4 ; Left partition
               bl      qsort

               mov     r10, r4 ; Right partition
               ldr     r12, [sp, #4] ; Restore original high
               bl      qsort

qsort_end      
               ldmfd   sp!, {r10, r12, pc}

Stop           end