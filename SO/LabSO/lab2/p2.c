#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int count_occurences(const char * text, const char * word){
	int contor = 0;
	char * buffer = malloc (1000);
	strcpy(text, buffer);
	return contor;
}


int main(){
	///printf("%d\n", count_occurences("balcalbananal", "al"));
	char * cuc = "banana";
	char *p = malloc (20);
	p = strstr(cuc, "baba");
	printf("%p\n", p);
	return 0;
}
