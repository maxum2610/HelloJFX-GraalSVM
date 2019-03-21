#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

extern void outBox(int argc, char** argv);

int main(int argc, char** argv) {
    fprintf(stderr, "MAIN ENTRY POINT => Hello, JAVA main, argc = %d, argv = %p\n", argc, argv);
    outBox(argc, argv);
    fprintf(stderr, "MAIN ENTRY POINT => EXIT\n");
}

