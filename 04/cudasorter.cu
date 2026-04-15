#include <cstdio>
#include <stdlib.h>
#include <cuda_runtime.h>

#define N 50

int arr[N];


void fill(int array[], int n){
    for (int i = 0; i < n; i++) {
        array[i] = rand() % 101;
    }
}

__device__ int dev_arr[N];

__global__ void sort(int n){
    for (int i = 0; i < n; i++) {

        int workerIdx = 2 * threadIdx.x + (i % 2);

        if (workerIdx + 1 < n) {
            if (dev_arr[workerIdx] > dev_arr[workerIdx + 1]) {
                int temp = dev_arr[workerIdx];
                dev_arr[workerIdx] = dev_arr[workerIdx + 1];
                dev_arr[workerIdx + 1] = temp;
            }
        }

        __syncthreads();
    }
}

int main(){

    fill(arr, N);

    for (int i = 0; i < N; i++) {
        printf("A[%d]=%d\n", i, arr[i]);
    }

    cudaMemcpyToSymbol(dev_arr, arr, N * sizeof(int));
    sort<<<1, N/2>>>(N);
    cudaMemcpyFromSymbol(arr, dev_arr, N * sizeof(int));

    printf("\n");
    


    for (int i = 0; i < N; i++) {
        printf("A[%d]=%d\n", i, arr[i]);
    }
}