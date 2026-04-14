#include <cuda_runtime.h>
#include <stdio.h>

int A[] = {1, 2, 3, 4, 5};

__device__ int dev_A[5];

__global__ void szorzas() {
    for (int i = 0; i < 5; i++) {
        dev_A[i] *= 2;
    }
}

int main() {
    cudaMemcpyToSymbol(dev_A, A, 5 * sizeof(int));
    szorzas<<<1, 1>>>();
    cudaDeviceSynchronize();
    cudaMemcpyFromSymbol(A, dev_A, 5 * sizeof(int));

    for (int i = 0; i < 5; i++) {
        printf("A[%d] = %d\n", i, A[i]);
    }

    return 0;
}