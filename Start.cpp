#include <iostream>
#include <string>
#include "Begin.h"
#include <math.h>
#include <chrono>

int main(int argc, char **agrv)
{

    std::cout << "Hello" << std::endl;

    Begin begin((char *)"Test tag");

    std::cout << begin.getTag() << std::endl;

    constexpr int SIZE = 5e8;

    int *valuesA = (int *)malloc(sizeof(int) * SIZE);

    int *valuesB = (int *)malloc(sizeof(int) * SIZE);

    for (int i = 0; i < SIZE; i++)
    {
        valuesA[i] = (i + 2) * 2 * i;
        valuesB[i] = (i - 2) * 3 * log(i);
    }

    int *dest = (int *)malloc(sizeof(int) * SIZE);

    begin.setData(valuesA, valuesB, dest, SIZE, Op::ADD);
    begin.setParams(4, 576);

    std::cout << "Begin launch\n";

    auto start = std::chrono::high_resolution_clock::now();
    begin.beginLaunch();
    auto stop = std::chrono::high_resolution_clock::now();

    auto dur = std::chrono::duration_cast<std::chrono::milliseconds>(stop-start);

    std::cout << "Operation completed in " << dur.count() << " milliseconds\n";

    free(dest);
    dest = (int *)malloc(sizeof(int) * SIZE);
    start = std::chrono::high_resolution_clock::now();

    for(int i = 0; i < SIZE; i++) {
       for(int j = 1; j < 1000; j++){
            dest[i] = (valuesA[i] + valuesB[i]) * j + dest[i];
        }
    }


    stop = std::chrono::high_resolution_clock::now();

    dur = std::chrono::duration_cast<std::chrono::milliseconds>(stop-start);

    std::cout << "Operation 2 completed in " << dur.count() << " milliseconds\n";


    /* for (int i = 0; i < SIZE; i++)
     {
         std::cout << "Value " << i << " is " << dest[i] << "\n";
     }
    */
    free(valuesA);
    free(valuesB);
    free(dest);
}