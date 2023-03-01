#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>

int * poz, m1[100][100], m2[100][100], m3[100][100], n, m, p, i, j, *sum;
pthread_t threads[100][100];


void * mull (void * z){
	int i = ((int*) z)[0];
	int j = ((int *) z)[1];	
	sum = (int*) malloc(sizeof(int));	
	*sum = 0;
	for (int k = 0; k < m; ++k)
		*sum += m1[i][k] + m2[k][j];
	free(z);
	return (void*)sum;
}



int main(int argc, char **argv){

	printf("Introduceti numarul de linii si cel de coloane pentru prima matrice!:\n");
	scanf("%d %d", &n, &m);
	printf("Din motive de compatibilitate, cea de-a doua matrice va avea %d linii! Scrieti numarul de coloane pentru a doua matrice:\n", m);
	scanf("%d", &p);
	printf ("Scrieti elementele primei matrici:\n");
	for (i = 0; i < n; ++i)
		for (j = 0; j < m; ++j)
			scanf("%d", &m1[i][j]);
	printf("Scrieti elementele celei de-a doua matrici:\n");
	for (i = 0; i < m; ++i)
		for (j = 0; j < p; ++j)
			scanf("%d", &m2[i][j]);		
	for (i = 0; i < n; ++i)
		for (j = 0; j < p; ++j){
				pthread_t thr;
				threads[i][j] = thr;
				poz = (int*) malloc(2 * sizeof(int));
				poz[0] = i;
				poz[1] = j ;
				pthread_create(&threads[i][j], NULL, mull, poz);
		}

	
	for (i = 0; i < n; ++i){
		for (j = 0; j < p; ++j){
			int * x;
			pthread_join(threads[i][j], (void **) &x);
			m3[i][j] = *x;
			printf("%d ", m3[i][j]);
			free(x);
		}
		printf("\n");
	}
	return 0;
}
