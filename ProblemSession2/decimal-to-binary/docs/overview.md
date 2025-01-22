# Overview of Decimal to Binary Conversion

## Algorithms

### Sign and Magnitude

**Steps:**
1. Determine the sign bit based on whether the number is positive or negative.
2. Convert the absolute value of the number to binary.
3. Combine the sign bit and the binary magnitude.

### 1's Complement

**Steps:**
1. Convert the absolute value of the number to binary.
2. If the number is negative, invert all the bits.

### 2's Complement

**Steps:**
1. Convert the absolute value of the number to binary.
2. If the number is negative, invert all the bits and add 1.

## Example
For example, to convert the decimal number -5 to binary using an 8-bit representation:
- **Sign and Magnitude**: Sign bit is 1, magnitude is 00000101, so the result is 10000101.
- **1's Complement**: Invert all bits of 00000101 to get 11111010.
- **2's Complement**: Invert all bits of 00000101 to get 11111010, then add 1 to get 11111011.