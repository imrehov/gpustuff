#include <stdio.h>
#include <string.h>

int finder(char szo[], char mondat[]){
    for (int i = 0; i < strlen(mondat); i++) {
        int found = 1;
        for (int j = 0; j < strlen(szo); j++) {
            if (mondat[i + j] != szo[j]) {
                found = 0;
                break;
            }
        }

        if (found) {
            return i;
        }
    }
    return -1;
}

int main(){
    
    char szo[] = "kutya";

    char mondat[] = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pharetra massa diam, sed vulputate magna viverra ac. In non quam blandit, euismod diam sed, volutpat enim. Fusce sed nulla et risus scelerisque pretium id feugiat justo. Suspendisse semper ultrices pharetra. Integer bibendum, mi id sodales ullamcorper, lorem sapien consequat mi, ut rhoncus odio arcu at enim. Suspendisse tristique lorem in purus rutrum malesuada varius sed orci. Nulla tincidunt leo tellus, sit amet porttitor nisi tincidunt nec. Proin eu arcu sit amet massa finibus pulvinar. Sed molestie metus hendrerit ipsum viverra ullamcorper. Makutyauris felis diam, aliquam sit amet cursus nec, porttitor in erat. Nunc ornare nec ipsum efficitur tincidunt. Integer vitae odio ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae";

    int result = finder(szo, mondat);

    printf("%d\n", result);
}