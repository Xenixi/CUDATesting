#pragma once
#include <cuda_runtime.h>
#include <cuda.h>

class Runner
{

public:

__device__ void processAdd(int *vA, int *vB, int *d, int size);

__device__ void processSub(int *vA, int *vB, int *d, int size);

__device__ void processMult(int *vA, int *vB, int *d, int size);

__device__ void processDivi(int *vA, int *vB, int *d, int size);


};

