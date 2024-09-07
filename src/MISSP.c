#include <stdio.h>

#define MAX_N 100000

int find_missing_doll(int dolls[], int n){
    
}


int main() {
    int T, N;
    int dolls[MAX_N];

    // Read number of test cases
    scanf("%d", &T);

    for (int t = 0; t < T; t++) {
        // Read number of dolls
        scanf("%d", &N);

        // Read doll types
        for (int i = 0; i < N; i++) {
            scanf("%d", &dolls[i]);
        }

        // Find and print the missing doll type
        int missing_doll = find_missing_doll(dolls, N);
        printf("%d\n", missing_doll);
    }

    return 0;
}

