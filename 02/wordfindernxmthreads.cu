#include <cuda_runtime.h>
#include <cstdio>

char szo[] = "tya";

char mondat[] = "Tur tincidunt. Integer vitae odio ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrikutyaces posuere cubilia curae";

constexpr int SZO_LEN = sizeof(szo);
constexpr int MONDAT_LEN = sizeof(mondat);

int result = -1;

__device__ char dev_szo[SZO_LEN];

__device__ char dev_mondat[MONDAT_LEN];

__device__ int dev_result;

__device__ char dev_temp[MONDAT_LEN];

__global__ void szokeres() {


    if (threadIdx.y == 0) {
        dev_temp[threadIdx.x] = 0;
        //ezzel csak az első "sor" thread írja be a 0-t
    }

    __syncthreads();

    if (dev_mondat[threadIdx.x + threadIdx.y] != dev_szo[threadIdx.y]) {
        dev_temp[threadIdx.x] = 1;
    }

    __syncthreads();

    if (threadIdx.y == 0) {
        if (dev_temp[threadIdx.x] == 0) {
            dev_result = threadIdx.x;
        }
    }
}

int main(){
    cudaMemcpyToSymbol(dev_szo, szo, sizeof(szo));
    cudaMemcpyToSymbol(dev_mondat, mondat, sizeof(mondat));
    cudaMemcpyToSymbol(dev_result, &result, sizeof(int));
    szokeres<<<1, dim3(MONDAT_LEN - SZO_LEN + 1, SZO_LEN - 1)>>>();
    cudaDeviceSynchronize();
    cudaMemcpyFromSymbol(&result, dev_result, sizeof(int));    

    printf("%d\n", result);
    return 0;

}