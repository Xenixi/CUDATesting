#pragma once
#include <stdbool.h>
#include <iostream>

enum class Op
{
    ADD,
    SUB,
    MUL,
    DIV
};

class Begin
{

private:
    char *tag;

    int *valuesA, *valuesB, *dest;
    int arraySize;
    Op operation;

    int gridSize, blockSize;

    int *g_vA, *g_vB, *g_d;



public:
    Begin(char *tag);
    ~Begin();


    char *getTag();

    void setData(int *valuesA, int *valuesB, int *dest, int arraySize, Op operation);

    void setParams(int gridSize, int blockSize);

    void beginLaunch();

    
};