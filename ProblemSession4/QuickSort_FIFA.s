; QuickSort
Data      dcd 10, 12, 8, 1, 5, 7, 11, 6, 8
Start     ldr    r0, =Data
               mov r10, r0
               add  r12, r0, #32
               bl     qsort
               b      Stop
Swap     stmfd   sp!, {r2, r3, lr} 
               ldr    r2, [r0]
               ldr    r3, [r1] 
               str    r2, [r1]
               str    r3, [r0]
               ldmfd   sp!, {r2, r3, pc}
Partt     stmfd   sp!, {r4-r6, lr} 
               ldr   r4, [r12] 
               sub   r5, r10, #4 
               mov   r6, r10
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
qsort     stmfd   sp!, {r10, r12, lr}
               cmp     r10, r12
               bhs     qsort_end
               bl      Partt 
               stmfd   sp!, {r0}
               ldr     r0, [sp]
               sub     r12, r0, #4 
               cmp     r10, r12
               bhi     skip_left
               stmfd   sp!, {r10, r12}
               bl      qsort
               ldmfd   sp!, {r10, r12}
skip_left      
               ldr     r0, [sp] 
               add     r10, r0, #4 
               ldr     r12, [sp, #4] 
               cmp     r10, r12
               bhi     skip_right
               stmfd   sp!, {r10, r12}
               bl      qsort
               ldmfd   sp!, {r10, r12}
skip_right     
               add     sp, sp, #4 
qsort_end      
               ldmfd   sp!, {r10, r12, pc} 

Stop           end