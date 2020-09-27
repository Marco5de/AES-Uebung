#include <stdio.h>
#include <stdint.h>


#define MSG00_TEST 0b101010101010101010101010 0000000
#define MSG01_TEST 0b110010011101000111100010 0000000
#define MSG02_TEST 0b1001110010111101110001110000000

const uint8_t gen = 0b10011001;
const uint32_t msg = MSG02_TEST;



uint8_t crc(uint32_t message, uint8_t generator) {
    uint32_t remainder = message;
    uint32_t expanded_gen = (generator << 24);

    int i;
    for (i = 0; i < 25; i++) {
        // check if highest bit of message is one

        if (remainder & (1 << 31)) {
            remainder ^= expanded_gen;
        }

        // next bit
        remainder = remainder << 1;
    }
    // remainder at maximum has length of gen
    uint8_t ret = (uint8_t) (remainder >> 24);
    return ret;
}


void print_bits(uint8_t vec) {
    int i;
    for (i = 7; i > 0; i--) {
        if (vec >> i & 0x01) {
            printf("1");
        } else {
            printf("0");
        }
    }
    printf("\n");
}

int main() {
    uint8_t ret = crc(msg, gen);

    printf("Remaidner of crc= %u\n", ret);
    print_bits(ret);

    return 0;
}
