#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
///dintr un oarecare motiv variabila errno nu imi merge, de asta am folosit -1 
///pentru a arata eroare

int main(int argc, char ** argv){
	char text[1000];

	int sursa = open (argv[1], O_RDONLY);
	int destinatie = open(argv[2], O_WRONLY | O_CREAT);
	struct stat sb;
	if (stat(argv[1], &sb)){
		perror(argv[1]);
		return -1;
	}
	int readstat = read (sursa, text, sb.st_size);
	if (readstat < 0){
		perror("read buf");
		return -1;
	}
	int writestat = write(destinatie, text, sb.st_size);
	if (writestat < 0){
		perror("write buf");
		return -1;
	}
	close (destinatie);
	close (sursa);
	//printf("%s %s\n", arg1, arg2);
	return 0;
}
