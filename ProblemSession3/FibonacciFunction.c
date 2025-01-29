#include <stdio.h>

// Function to calculate nth Fibonacci number
unsigned long long fibonacci(int n) {
    // If n is less than or equal to 0, return 0
    if (n <= 0) return 0;
    // If n is 1, return 1
    if (n == 1) return 1;

    // Initialize first two Fibonacci numbers
    unsigned long long a = 0;
    unsigned long long b = 1;
    unsigned long long result = 0;

    // Iterate from 2 to n to calculate nth Fibonacci number
    for (int i = 2; i <= n; i++) {
        result = a + b; // Calculate next Fibonacci number
        a = b;          // Update a to previous Fibonacci number
        b = result;     // Update b to current Fibonacci number
    }

    // Return nth Fibonacci number
    return result;
}

int main() {
    int n = 44; //  position in Fibonacci sequence to calculate
    unsigned long long fib = fibonacci(n); // Calculate nth Fibonacci number

    // Print nth Fibonacci number
    printf("The %dth Fibonacci number is: %llu\n", n, fib);

    return 0;
}