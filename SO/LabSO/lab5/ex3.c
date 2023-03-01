#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

int main(int argc, char **argv){
	printf("Starting parent %d\n", getpid());
	for (int i = 1; i < argc; ++i){
		pid_t pid = fork();
		if (pid < 0)
			return errno;
		else if (pid == 0){
			int nr = atoi(argv[i]);
	                printf("%d: ", nr);
        	        while (nr != 1){
                	        printf ("%d ", nr);
                      		 if (nr & 1 == 1)
                          	      nr = nr * 3 + 1;
                       		 else
                                	nr /= 2;
               		 }
	               	printf("1\n");
			return 0;
		}
		else{
			pid_t pidRet = wait(NULL);
			printf("Done Parent %d Me %d\n", getpid(), pidRet);
		}
	}
	printf("Done Parent %d Me %d\n", getppid(), getpid());

	return 0;
}
