#include <stdio.h>
#include <stdlib.h>

void printBinary(int num, int bits) {
    for (int i = bits - 1; i >= 0; i--) {
        printf("%d", (num >> i) & 1);
    }
    printf("\n");
}

void signAndMagnitude(int num, int bits) {
    int sign = (num < 0) ? 1 : 0;
    int magnitude = abs(num);
    printf("Sign and Magnitude: %d", sign);
    printBinary(magnitude, bits - 1);
}

void onesComplement(int num, int bits) {
    if (num < 0) {
        num = ~(-num) & ((1 << bits) - 1);
    }
    printf("One's Complement: ");
    printBinary(num, bits);
}

void twosComplement(int num, int bits) {
    if (num < 0) {
        num = (~(-num) + 1) & ((1 << bits) - 1);
    }
    printf("Two's Complement: ");
    printBinary(num, bits);
}

int main() {
    int bits, num;

    printf("Enter the number of bits: ");
    scanf("%d", &bits);

    printf("Enter a decimal number in range -128 to 127: ");
    scanf("%d", &num);

    if (num < -128 || num > 127) {
        printf("Number out of range!\n");
        return 1;
    }

    signAndMagnitude(num, bits);
    onesComplement(num, bits);
    twosComplement(num, bits);

    return 0;
}