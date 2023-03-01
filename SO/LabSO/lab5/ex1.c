#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>


int main(){
	pid_t pid = fork();
	if (pid < 0)
		return errno;
	else if(pid == 0){
		pid_t child_pid = getpid();
		pid_t parent_pid = getppid();
		printf("My PID = %d,   Child PID = %d\n", child_pid, parent_pid);
	}
	else{
		wait();
		char * argv[] = {"ls", NULL};
		execve("/usr/bin/ls", argv, NULL);
		perror(NULL);
	}

	return 0;
}
