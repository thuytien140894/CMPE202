#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>

#define MAXLINE 4096

int main(int argc, char **argv) {
    char cmd[MAXLINE];
    char filename[MAXLINE];
    struct timeval tv0, tv1;
    FILE *record = fopen("record.txt", "w");
    int difference;
    FILE *test;

    if (record) {
        for (int i = 0; i < 30; i++) {
            sprintf(filename, "data/test%d.txt", i);
            if (fopen(filename, "r") == NULL) {
                exit(0);
            }

            sprintf(cmd, "../fasttext print-word-vectors ../result/fil9.bin < %s", filename);

            printf("TEST %d\n", i);
            gettimeofday(&tv0, NULL);
            printf("Start: %d seconds %06d microseconds\n", (int) tv0.tv_sec, (int) tv0.tv_usec);

            system(cmd);

            gettimeofday(&tv1, NULL);
            printf("End: %d seconds %06d microseconds\n", (int) tv1.tv_sec, (int) tv1.tv_usec);
            difference = (int) (tv1.tv_sec * 1000000 + tv1.tv_usec) - (int) (tv0.tv_sec * 1000000 + tv0.tv_usec);
            printf("Time elapsed: %d microseconds\n", difference);
            
            fprintf(record, "%d\n", difference);
            printf("------------------------------------------------------------------------------------------------------------------------------\n");
        }

        fclose(record);
    }
}

