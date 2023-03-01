#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <errno.h>
#define MAX_RESOURCES 5
int available_resources = MAX_RESOURCES;
#define sizeNrThr 5

pthread_t nrThr[sizeNrThr];
int needResPerThread[] = {2, 2, 1, 4, 5};
void *p;
pthread_mutex_t mtx;


int decrease_count(int count){
	if (available_resources < count)
		return -1;
	else{
		available_resources -= count;
		printf("Got %d resources %d remaining\n", count, available_resources);
	}
	return 0;
}

int increase_count(int count){
	available_resources += count;
	printf("Released %d resources %d remaining\n", count, available_resources);
	return 0;
}

void * fctThread(void * param){
	int ok = -1;
	while (ok < 0){
		pthread_mutex_lock(&mtx);
		ok = decrease_count(((int*)param)[0]);	
		pthread_mutex_unlock(&mtx);
	}
	pthread_mutex_lock(&mtx);
	increase_count(((int*)param)[0]);
	pthread_mutex_unlock(&mtx);
	free(param);
	return NULL;
}




int main(){
	if (pthread_mutex_init(&mtx, NULL)){
		perror(NULL);
		return errno;
	}
	for (int i = 0; i < sizeNrThr; ++i){
		pthread_t thr;
		nrThr[i] = thr;
		p = malloc(sizeof(int));
		((int *)p)[0] = needResPerThread[i];
		pthread_create(&nrThr[i], NULL, fctThread, p);
	}
	for (int i = 0; i < sizeNrThr; ++i){
		pthread_join(nrThr[i], p);
	}
	pthread_mutex_destroy(&mtx);

	return 0;
}
