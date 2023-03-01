#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char **argv){
	pid_t pid = fork();
	if (pid < 0)
		return errno;
	else if(pid == 0){
		int nr = atoi(argv[1]);
		printf("%d: ", nr);
		while (nr != 1){
			printf ("%d ", nr);
			if (nr & 1 == 1)
				nr = nr * 3 + 1;
			else
				nr /= 2;
		}
		printf("1\n");
	}
	else{
		wait();
		printf("Child %d finished\n", pid);
	}
	return 0;
}
