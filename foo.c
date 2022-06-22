#include <stdint.h>

uint8_t j = 1;

void foo(int *b)
{
    if(1.0f / j > 1.0f) {
        *b = 1;
    }
}

