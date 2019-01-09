#include <stdio.h>
#include <stdint.h>

int main() {
    /* Any nonzero start state will work. */
    uint16_t start_state = 0xACE1u;
    uint16_t lfsr = start_state;
    unsigned period = 0;

    do {
        printf("0x%04X\n", lfsr);
        // Get the output bit
        unsigned lsb = lfsr & 1;
        // Shift register
        lfsr >>= 1;
        if (lsb)
            // If the output bit is 1, apply toggle mask          
            lfsr ^= 0xB400u;
        ++period;
    } while (lfsr != start_state);

    return 0;
}