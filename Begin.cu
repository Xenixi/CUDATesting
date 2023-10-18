#include <cuda.h>
#include <cuda_runtime.h>
#include "Begin.cuh"
#include "Runner.cuh"
#include <chrono>



Begin::Begin(char *tag)
{
    this->tag = tag;
}

Begin::~Begin()
{
}

char *Begin::getTag()
{
    return this->tag;
}

void Begin::setData(int *valuesA, int *valuesB, int *dest, int arraySize, Op operation)
{
    this->valuesA = valuesA;
    this->valuesB = valuesB;
    this->dest = dest;
    this->operation = operation;
    this->arraySize = arraySize;
}

void Begin::setParams(int gridSize, int blockSize)
{
    this->gridSize = gridSize;
    this->blockSize = blockSize;
}

void Begin::beginLaunch()

{
    cudaMalloc((void **)&g_vA, sizeof(int) * (this->arraySize));
    cudaMalloc((void **)&g_vB, sizeof(int) * (this->arraySize));
    cudaMalloc((void **)&g_d, sizeof(int) * (this->arraySize));

  

    
    cudaMemcpy((void *)g_vA, (void *)valuesA, (sizeof(int) * this->arraySize), cudaMemcpyHostToDevice);
    cudaMemcpy((void *)g_vB, (void *)valuesB, (sizeof(int) * this->arraySize), cudaMemcpyHostToDevice);
    cudaMemcpy((void *)g_d, (void *)dest, (sizeof(int) * this->arraySize), cudaMemcpyHostToDevice);

    auto start = std::chrono::high_resolution_clock::now();
    cudaLaunch<<<gridSize, blockSize>>>(static_cast<int>(operation), this->arraySize , g_vA, g_vB, g_d);
    cudaDeviceSynchronize();
    auto stop = std::chrono::high_resolution_clock::now();

    auto dur = std::chrono::duration_cast<std::chrono::milliseconds>(stop-start);

    std::cout << "Operation INNER completed in " << dur.count() << " milliseconds\n";

    
    cudaMemcpy((void *)dest, (void *)g_d, sizeof(int) * (this->arraySize), cudaMemcpyDeviceToHost);

    cudaFree(g_vA);
    cudaFree(g_vB);
    cudaFree(g_d);

    


}

__global__ void cudaLaunch(int operation, int arraySize, int *g_vA, int *g_vB, int *g_d)
{
    
    Runner run;


    if (operation == 0)
    {
        run.processAdd(g_vA, g_vB, g_d, arraySize);
    }
    else if (operation == 1)
    {
        run.processSub(g_vA, g_vB, g_d, arraySize);
    }
    else if (operation == 2)
    {
        run.processMult(g_vA, g_vB, g_d, arraySize);
    }
    else if (operation == 3)
    {
        run.processDivi(g_vA, g_vB, g_d, arraySize);
    }
    
}
