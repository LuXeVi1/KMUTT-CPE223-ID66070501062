fibonacci:
        push    {r4, r5, r7}          // Save registers r4, r5, and r7 on stack (to preserve their values)
        sub     sp, sp, #44           // Allocate 44 bytes on stack (for local variables and function arguments)
        add     r7, sp, #0            // Set frame pointer (r7) to current stack pointer (sp)
        str     r0, [r7, #4]          // Store input parameter (n) on stack at offset 4
        ldr     r3, [r7, #4]          // Load value of n from stack into register r3
        cmp     r3, #0                // Compare n with 0
        bgt     .L2                   // If n > 0, branch to label .L2 (otherwise, continue)
        vmov.i32        d16, #0       // Set result (in register d16) to 0 (for n <= 0)
        b       .L3                   // Branch to label .L3 (to return result)
.L2:
        ldr     r3, [r7, #4]          // Load n into r3 again
        cmp     r3, #1                // Compare n with 1
        bne     .L4                   // If n != 1, branch to label .L4 (otherwise, continue)
        vldr.64 d16, .L7              // Load constant 1 into register d16 (for n == 1)
        b       .L3                   // Branch to label .L3 (to return result)
.L4:
        vmov.i32        d16, #0       // Initialize result (d16) to 0
        vstr.64 d16, [r7, #32]        // Store result on stack at offset 32
        mov     r2, #1                // Set r2 to 1 (initial value for Fibonacci calculation)
        mov     r3, #0                // Set r3 to 0 (initial value for Fibonacci calculation)
        strd    r2, [r7, #24]         // Store r2 and r3 on stack at offset 24 (current Fibonacci number)
        vmov.i32        d16, #0       // Initialize result (d16) to 0 again
        vstr.64 d16, [r7, #16]        // Store result on stack at offset 16
        movs    r3, #2                // Set r3 to 2 (loop counter starts at 2)
        str     r3, [r7, #12]         // Store loop counter on stack at offset 12
        b       .L5                   // Branch to label .L5 (start of loop)
.L6:
        ldrd    r0, [r7, #32]         // Load previous Fibonacci number into r0 and r1
        ldrd    r2, [r7, #24]         // Load current Fibonacci number into r2 and r3
        adds    r4, r0, r2            // Add previous and current Fibonacci numbers (r4 = r0 + r2)
        adc     r5, r1, r3            // Add with carry (r5 = r1 + r3 + carry)
        strd    r4, [r7, #16]         // Store result (r4 and r5) on stack at offset 16
        ldrd    r2, [r7, #24]         // Load current Fibonacci number into r2 and r3 again
        strd    r2, [r7, #32]         // Store current Fibonacci number as previous one (at offset 32)
        ldrd    r2, [r7, #16]         // Load result (r4 and r5) into r2 and r3
        strd    r2, [r7, #24]         // Store result as current Fibonacci number (at offset 24)
        ldr     r3, [r7, #12]         // Load loop counter into r3
        adds    r3, r3, #1            // Increment loop counter by 1
        str     r3, [r7, #12]         // Store updated loop counter on stack
.L5:
        ldr     r2, [r7, #12]         // Load loop counter into r2
        ldr     r3, [r7, #4]          // Load n into r3
        cmp     r2, r3                // Compare loop counter with n
        ble     .L6                   // If loop counter <= n, branch to label .L6 (continue loop)
        vldr.64 d16, [r7, #16]        // Load final result from stack into d16
.L3:
        vmov    r2, r3, d16           // Move result from d16 to registers r2 and r3
        mov     r0, r2                // Move result (r2) to r0 (return value)
        mov     r1, r3                // Move result (r3) to r1 (return value)
        adds    r7, r7, #44           // Deallocate stack space (44 bytes)
        mov     sp, r7                // Restore stack pointer (sp) to its original value
        pop     {r4, r5, r7}          // Restore saved registers (r4, r5, r7)
        bx      lr                    // Return from function (branch to address in link register)
.L7:
        .word   1                     // Constant 1 (used for Fibonacci(1))
        .word   0                     // Constant 0 (padding)
.LC0:
        .ascii  "The %dth Fibonacci number is: %llu\012\000" // Format string for printf (to print result)
main:
        push    {r7, lr}              // Save frame pointer (r7) and link register (lr) on stack
        sub     sp, sp, #16           // Allocate 16 bytes on stack (for local variables)
        add     r7, sp, #0            // Set frame pointer (r7) to current stack pointer (sp)
        movs    r3, #44               // Set n to 44 (Fibonacci number to compute)
        str     r3, [r7, #12]         // Store n on stack at offset 12
        ldr     r0, [r7, #12]         // Load n into r0 (to pass it as an argument to fibonacci function)
        bl      fibonacci             // Call fibonacci function (branch with link)
        strd    r0, [r7]              // Store result (r0 and r1) on stack at offset 0
        ldrd    r2, [r7]              // Load result into r2 and r3 (to pass it to printf)
        ldr     r1, [r7, #12]         // Load n into r1 (to pass it to printf)
        movw    r0, #:lower16:.LC0    // Load lower 16 bits of format string address into r0
        movt    r0, #:upper16:.LC0    // Load upper 16 bits of format string address into r0
        bl      printf                // Call printf to print result
        movs    r3, #0                // Set return value to 0 (indicating success)
        mov     r0, r3                // Move return value to r0 (to return it from main)
        adds    r7, r7, #16           // Deallocate stack space (16 bytes)
        mov     sp, r7                // Restore stack pointer (sp) to its original value
        pop     {r7, pc}              // Restore frame pointer (r7) and return from main (branch to address in link register)