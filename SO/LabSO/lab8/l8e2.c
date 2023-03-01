#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <errno.h>
#include <semaphore.h>
#define sizeNrThr 5

int contor = 0;
pthread_t nrThr[sizeNrThr];
void *p;
pthread_mutex_t mtx;
sem_t sem;

void barrier_point(){
	pthread_mutex_lock(&mtx);
	++contor;
	if (contor == sizeNrThr){
		pthread_mutex_unlock(&mtx);
		sem_post(&sem);
	}
	else{
		pthread_mutex_unlock(&mtx);
		sem_wait(&sem);
		sem_post(&sem);
	}
	
}


void * tfun (void *v){
	int *tid = (int *)v;
	printf("%d reached the barrier\n", *tid);
	barrier_point();
	printf("%d passed the barrier\n", *tid);

	free (tid);
	return NULL;
}



int main(){
	if (pthread_mutex_init(&mtx, NULL)){
		perror(NULL);
		return errno;
	}
	if (sem_init(&sem, 0, 0)){
		perror(NULL);
		return errno;
	}
	for (int i = 0; i < sizeNrThr; ++i){
		pthread_t thr;
		nrThr[i] = thr;
		p = malloc(sizeof(int));
		((int *)p)[0] = i;
		pthread_create(&nrThr[i], NULL, tfun, p);
	}
	for (int i = 0; i < sizeNrThr; ++i){
		pthread_join(nrThr[i], p);
	}
	pthread_mutex_destroy(&mtx);
	sem_destroy(&sem);
	return 0;
}
