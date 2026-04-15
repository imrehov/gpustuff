#include <cuda_runtime.h>
#include <cstdio>

char szo[] = "kutya";

char mondat[] = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pharetra massa diam, sed vulputate magna viverra ac. In non quam blandit, euismod diam sed, volutpat enim. Fusce sed nulla et risus scelerisque pretium id feugiat justo. Suspendisse semper ultrices pharetra. Integer bibendum, mi id sodales ullamcorper, lorem sapien consequat mi, ut rhoncus odio arcu at enim. Suspendisse tristique lorem in purus rutrum malesuada varius sed orci. Nulla tincidunt leo tellus, sit amet porttitor nisi tincidunt nec. Proin eu arcu sit amet massa finibus pulvinar. Sed molestie metus hendrerit ipsum viverra ullamcorper. Makutyauris felis diam, aliquam sit amet cursus nec, porttitor in erat. Nunc ornare nec ipsum efficitur tincidunt. Integer vitae odio ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae";

constexpr int SZO_LEN = sizeof(szo);
constexpr int MONDAT_LEN = sizeof(mondat);

int result = -1;

__device__ char dev_szo[SZO_LEN];

__device__ char dev_mondat[MONDAT_LEN];

__device__ int dev_result;

__global__ void szokeres() {
    for (int i = 0; i <= MONDAT_LEN - SZO_LEN; i++) {
        int found = 1;

        for (int j = 0; j < SZO_LEN - 1; j++) {
            if (dev_mondat[i + j] != dev_szo[j]) {
                found = 0;
                break;
            }
        }

        if (found) {
            dev_result = i;
            return;
        }
    }
}

int main(){
    cudaMemcpyToSymbol(dev_szo, szo, sizeof(szo));
    cudaMemcpyToSymbol(dev_mondat, mondat, sizeof(mondat));
    cudaMemcpyToSymbol(dev_result, &result, sizeof(int));
    szokeres<<<1, 1>>>();
    cudaDeviceSynchronize();
    cudaMemcpyFromSymbol(&result, dev_result, sizeof(int));    

    printf("%d\n", result);
    return 0;

}