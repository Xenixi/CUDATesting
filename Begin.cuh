#pragma once
#include "Begin.h"

__global__ void cudaLaunch(int operation, int arraySize, int *g_vA, int *g_vB, int *g_d);