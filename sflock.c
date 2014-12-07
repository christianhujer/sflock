#include <stddef.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/file.h>
#include <err.h>
#include <stdlib.h>

void attemptLock(const char *lockFileName)
{
    int fd = open(lockFileName, O_CREAT | O_WRONLY, 0666);
    if (!fd || flock(fd, LOCK_EX))
        warn("Cannot lock %s", lockFileName);
}

int main(int argc, char *argv[])
{
    if (argc < 3)
        errx(EXIT_FAILURE, "Not enough arguments.\nUsage: %s LOCKFILENAME COMMAND...\n", argv[0]);
    attemptLock(argv[1]);
    argv += 2;  // Skip our own command name and LOCKFILENAME.
    execvp(argv[0], argv);
    err(EXIT_FAILURE, "Cannot execute %s", argv[0]);
}
