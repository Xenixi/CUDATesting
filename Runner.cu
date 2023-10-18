#include "Runner.cuh"


__device__ void Runner::processAdd(int *vA, int *vB, int *d, int size)
{
    for(int i = threadIdx.x; i < size; i += gridDim.x*blockDim.x){
        for(int j = 1; j < 1000; j++){
            d[i] = (vA[i] + vB[i]) * j + d[i];
        }
        

       

    }

}

__device__ void Runner::processSub(int *vA, int *vB, int *d, int size)
{
    for(int i = threadIdx.x; i < size; i += gridDim.x*blockDim.x){
        d[i] = vA[i] - vB[i];
    }
}

__device__ void Runner::processMult(int *vA, int *vB, int *d, int size)
{
    for(int i = threadIdx.x; i < size; i += gridDim.x*blockDim.x){
        d[i] = vA[i] * vB[i];
    }
}

__device__ void Runner::processDivi(int *vA, int *vB, int *d, int size)
{
    for(int i = threadIdx.x; i < size; i += gridDim.x*blockDim.x){
        d[i] = vA[i] / vB[i];
    }
}