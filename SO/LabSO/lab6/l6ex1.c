#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/wait.h>
#include <string.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <string.h>

int main(int argc, char **argv){
	char sir[] = "Salut";
	int aux;
	int pageSize = getpagesize();
	int cuc = shm_open(sir, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
	if (ftruncate(cuc, pageSize*100) == -1){
		perror(NULL);
		shm_unlink(sir);
		return errno;
	}
	
	printf("Starting parent %d\n", getpid());
	
	for (int i = 1; i < argc; ++i){
		pid_t pid = fork();
		if (pid < 0)
			return errno;
		else if (pid == 0){
			void *cuc2 = mmap(NULL, pageSize, PROT_WRITE, MAP_SHARED, cuc, (i-1)*pageSize);
			int nr = atoi(argv[i]);
	                aux = sprintf(cuc2, "%d: ", nr);
	                cuc2 += aux;
        	        while (nr != 1){
                	        aux = sprintf (cuc2, "%d ", nr);
                	        cuc2 += aux;
                      		 if (nr & 1 == 1)
                          	      nr = nr * 3 + 1;
                       		 else
                                	nr /= 2;
               		 }
	               	sprintf(cuc2, "1\n");
			return 0;
		}
		else{
			pid_t pidRet = wait(NULL);
			printf("Done Parent %d Me %d\n", getpid(), pidRet);
		}
	}
	
	void * ceva;
	for (int i = 1; i < argc; ++i){
		ceva = mmap(NULL, pageSize, PROT_READ, MAP_SHARED, cuc, (i-1)*pageSize);
		printf("%s", (char*) ceva);
		munmap(ceva, pageSize);
	}
	shm_unlink(sir);
	printf("Done Parent %d Me %d\n", getppid(), getpid());
	
	
	return 0;
}
