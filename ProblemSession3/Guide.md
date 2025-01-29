# Understanding Fibonacci Assembly Code (Guide)

## Overview
This document explains the provided ARM assembly code in simple terms for those unfamiliar with assembly language. The code computes the Fibonacci sequence and prints the result for `n = 44`.

---

## What is the Fibonacci Sequence?
The Fibonacci sequence is a series of numbers where each number is the sum of the two previous ones :

```
F(0) = 0
F(1) = 1
F(n) = F(n-1) + F(n-2) for n >= 2
```

For example:
```
0, 1, 1, 2, 3, 5, 8, 13, 21, ...
```

---

## Code Structure
The code consists of two main parts:
1. **Fibonacci Function (`fibonacci`)**: Computes the nth Fibonacci number using an iterative approach.
2. **Main Function (`main`)**: Calls `fibonacci(44)`, then prints the result.

### **1. Fibonacci Function (`fibonacci`)**

#### **Step 1: Handling Base Cases**
- If `n == 0`, return `0`
- If `n == 1`, return `1`

```assembly
cmp     r3, #0                // Check if n == 0
bgt     .L2                   // If n > 0, go to .L2
vmov.i32 d16, #0              // Store 0 as the result
b       .L3                   // Jump to return section

.L2:
cmp     r3, #1                // Check if n == 1
bne     .L4                   // If n != 1, go to .L4
vldr.64 d16, .L7              // Store 1 as the result
b       .L3                   // Jump to return section
```

#### **Step 2: Iteratively Compute Fibonacci**
- Stores `F(n-2)` and `F(n-1)` in registers.
- Loops from `2` to `n`, adding `F(n-2) + F(n-1)` to get `F(n)`.

```assembly
mov     r2, #1                // Set F(1) = 1
mov     r3, #0                // Set F(0) = 0
movs    r3, #2                // Loop starts from 2

.L6:
ldrd    r0, [r7, #32]         // Load F(n-2)
ldrd    r2, [r7, #24]         // Load F(n-1)
adds    r4, r0, r2            // Compute F(n) = F(n-1) + F(n-2)
strd    r4, [r7, #16]         // Store F(n)

adds    r3, r3, #1            // Increment loop counter
cmp     r3, r3                // Compare with n
ble     .L6                   // If not reached n, repeat loop
```

#### **Step 3: Return the Result**
```assembly
vldr.64 d16, [r7, #16]        // Load final result
mov     r0, r2                // Move result to return register
bx      lr                    // Return from function
```

---

### **2. Main Function (`main`)**
- Calls `fibonacci(44)` and prints the result using `printf`.

```assembly
movs    r3, #44               // Set n = 44
bl      fibonacci             // Call fibonacci function
strd    r0, [r7]              // Store result
ldr     r1, [r7, #12]         // Load n into r1
movw    r0, #:lower16:.LC0    // Load format string
movt    r0, #:upper16:.LC0    // Load format string
bl      printf                // Print the result
```

---