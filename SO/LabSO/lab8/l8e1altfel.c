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
	int ok = 0;
	while (!ok){
		pthread_mutex_lock(&mtx);
		if (available_resources >= count){
			available_resources -= count;
			printf("Got %d resources %d remaining\n", count, available_resources);
			ok = 1;
		}
		pthread_mutex_unlock(&mtx);
	}
	return 0;
}

int increase_count(int count){
	pthread_mutex_lock(&mtx);
	available_resources += count;
	printf("Released %d resources %d remaining\n", count, available_resources);
	pthread_mutex_unlock(&mtx);
	return 0;
}

void * fctThread(void * param){
	decrease_count(((int*)param)[0]);
	increase_count(((int*)param)[0]);
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
