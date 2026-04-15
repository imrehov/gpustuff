
#include <cstdio>
#include <stdlib.h>
#define N 8



void fill(int array[], int n){
    for (int i = 0; i < n; i++) {
        array[i] = rand() % 101;
    }
}

void sort(int array[], int n){
    for (int i = 0; i < n; i++) {
        int j = 0;
        while (j < n - 1) {
            if (array[j] > array[j + 1]) {
                int temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
            j++;
        }
    }
}


int main(){
    int arr[N];
    fill(arr, N);

    for (int i = 0; i < N; i++) {
        printf("A[%d]=%d\n", i, arr[i]);
    }

    printf("\n");
    
    sort(arr, N);

    for (int i = 0; i < N; i++) {
        printf("A[%d]=%d\n", i, arr[i]);
    }
}