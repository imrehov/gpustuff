#include <cstdio>

#define N 1000000
#define BLOCK_SIZE 663

int A[N];

__device__ int dev_A[N];

__global__ void szorzas(int mennyivel) {
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    if (i >= N) {
        return;
    }
    dev_A[i] *= mennyivel;
}

int main() {
    for (int i = 0; i < N; i++) {
        A[i] = i;
    }

    cudaMemcpyToSymbol(dev_A, A, N * sizeof(int));
    int block_count = (N - 1) / BLOCK_SIZE + 1;
    szorzas <<< block_count, BLOCK_SIZE>>> (3);
    cudaMemcpyFromSymbol(A, dev_A, N * sizeof(int));

    for (int i = 0; i < N; i++) {
        printf("A[%d]=%d\n", i, A[i]);
    }
}