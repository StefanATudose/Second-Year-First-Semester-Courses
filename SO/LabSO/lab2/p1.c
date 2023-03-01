#include <stdio.h>
#include <stdlib.h>

int main(){
	int n, nr, i, j;
	scanf("%d", &n);
	int * mat = malloc(4 * n * n);
	for (i = 0; i < n; ++i)
		for (j = 0; j < n; ++j){
			scanf("%d", &nr);
			*(mat + i * n + j) = nr;
		}
	printf("Afisam elementele matricii:\n");
	for (i = 0; i < n; ++i){
		for (j = 0; j < n; ++j)
			printf("%d ", *(mat+i*n+j));
		printf("\n");
	}
	if (n % 2 != 0){
		nr = *(mat + n * (n / 2) + n / 2);
		printf("Cum n este impar, afisam elementul de la intersectia diagonalelor:\n%d\n", nr);
	}
	printf("Afisam elementele de pe cele doua diagolane:\n");
	for (i = 0; i < n; ++i)
		printf("%d ", *(mat + i * n + i));
	printf("\n");
	for (i = n-1; i >= 0; --i)
		printf("%d ", *(mat + i*n + (n-1-i)));
	printf("\n");

	return 0;
}

