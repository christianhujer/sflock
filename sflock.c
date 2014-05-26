#include <stddef.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/file.h>

void attemptLock(const char *lockFileName)
{
    if (lockFileName == NULL) return;
    int fd = open(lockFileName, O_CREAT | O_WRONLY, 0666);
    if (!fd || flock(fd, LOCK_EX)) perror(NULL);
}

int main(int argc, char *argv[])
{
    if (argc < 3) {
        fprintf(stderr, "Usage: %s LOCKFILENAME COMMAND...\n", argv[0]);
        return 1;
    }
    attemptLock(argv[0]);
    argv += 2; // skip our own command name and LOCKFILENAME.
    execvp(argv[0], argv);
}
