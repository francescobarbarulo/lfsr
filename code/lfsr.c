#include <stdio.h>
#include <stdint.h>

int main()
{
    // Any nonzero start state will work.
    uint16_t start_state = 0xACE1u;
    uint16_t lfsr = start_state;
    uint16_t bit;
    unsigned period = 0;

    do
    {
        printf("0x%04X\n", lfsr);
        /* taps: 16 14 13 11; feedback polynomial: x^16 + x^14 + x^13 + x^11 + 1 */
        bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1;
        lfsr = (lfsr >> 1) | (bit << 15);
        ++period;
    } while (lfsr != start_state);

    return 0;
}