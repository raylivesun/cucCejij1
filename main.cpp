#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

#define REAL_PATH "/path/to/script"

int main(int argc, char **argv)
{
    execv(REAL_PATH, argv);
    fprintf(stderr, "%s: %s: %s\n",
                    argv[0], REAL_PATH, strerror(errno));
    return 127;
}
