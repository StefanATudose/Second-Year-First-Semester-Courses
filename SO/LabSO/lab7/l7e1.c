#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>


void * invers(void * str){
	char * inv;
	inv = (char *)malloc(strlen((char*)str) + 1);
	int len = strlen(str);
	for (int i = len-1; i >= 0; --i){
		inv[len-i-1] = ((char*)str)[i];
	}
	printf("%d\n", len);
	return (void*)inv;

}


int main(int argc, char **argv){
	pthread_t thr;
	char * x, *y;
	pthread_create(&thr, NULL, invers, argv[1]);
	
	pthread_join(thr, (void**)&y);
	printf("%s\n", y);

	return 0;
}
