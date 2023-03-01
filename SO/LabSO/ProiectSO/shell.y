%{						///pasi urmatori: rezolvare memory leaks (free currSimpleComm)
	#include <ctype.h>
	#include <stdio.h>
	#include <sys/wait.h>
   	#include <sys/types.h>
   	#include <sys/stat.h>
   	#include <fcntl.h>
   	#include <stdlib.h>
   	#include <signal.h>
   	extern int yylex(void);
   	
   	char* commandText;
   	int isPipe;
   	
   	
	struct SimpleCommand {

		int _numberOfAvailableArguments;
				
		int _numberOfArguments;
				
		char ** _arguments;
	};
	
	struct SimpleCommand * SimpleCommandNew (){
 		struct SimpleCommand * p = (struct SimpleCommand *) malloc (sizeof(struct SimpleCommand));
 		p -> _numberOfArguments = 0;
 		p -> _numberOfAvailableArguments = 10;
 		p -> _arguments = (char**)malloc(p->_numberOfAvailableArguments * 10); 	
 		return p;
 	}
 	
	void insertArg (struct SimpleCommand ** p, char *argument){
		if ((*p)->_numberOfArguments < (*p)->_numberOfAvailableArguments){
			(*p)->_arguments[(*p)->_numberOfArguments++] = argument;
			//printf("Am inserat argumentul %s in comanda simpla\n", (*p)->_arguments[0]);
		}
		else{
			int cateArg = (*p)->_numberOfAvailableArguments * 10 + 100;
			struct SimpleCommand * newP = (struct SimpleCommand*) realloc ((*p), cateArg);
			newP -> _numberOfAvailableArguments += 10;
			*p = newP;
			(*p)->_arguments[(*p)->_numberOfArguments++] = argument;
		}
		
	}
	
	
	///COMMAND STRUCT AND FUNCTIONS
	
	
	struct Command {
		int _numberOfAvailableSimpleCommands;
		int _numberOfSimpleCommands;
		struct SimpleCommand ** _simpleCommands;
		char * _outFile;
		char * _inputFile;
		char * _errFile;
		int _background;
		int _append;
		//de implementat in afara structului
		//void prompt();
		//void print();
		//void execute();
		//void clear();

		//incerc fara
//		static SimpleCommand *_currentSimpleCommand;				
	};
 	
 	
 	struct Command * CommandNew (){
 		struct Command * p = (struct Command*) malloc (sizeof(struct Command));
 		p ->_numberOfAvailableSimpleCommands = 10;
 		p ->_numberOfSimpleCommands = 0;
		p ->_simpleCommands = (struct SimpleCommand**) malloc (10 * sizeof(struct SimpleCommand));
		p -> _background = 0;
		p -> _outFile = NULL;
		p -> _inputFile = NULL;
		p -> _errFile = NULL;
		p -> _append = 0;
		return p;
 	}
 	
	void insertSimpleCommand(struct Command ** c, struct SimpleCommand * sc){
		if ((*c)->_numberOfAvailableSimpleCommands > (*c)->_numberOfSimpleCommands){
			(*c)->_simpleCommands[(*c)->_numberOfSimpleCommands++] = sc;
		}		
		else{
			int cateArg = ((*c)->_numberOfAvailableSimpleCommands+10) * sizeof(struct SimpleCommand);
			
			struct Command * newP = (struct Command*) realloc ((*c), cateArg);
			newP -> _numberOfAvailableSimpleCommands += 10;
			(*c) = newP;
			(*c)->_simpleCommands[(*c)->_numberOfSimpleCommands++] = sc;
		}
	}
	
	void prompt(){
		printf ("sttsh$");
		yyparse();
	}
 
 	void execute (struct Command * c){
 		int tmpin = dup(0);
 		int tmpout = dup(1);
 		int tmperr = dup(2);
 		int fdin;
 		if (c -> _inputFile) {
 			fdin = open (c -> _inputFile, O_RDONLY);
 		}
 		else{
 			fdin = dup(tmpin);
 		}	
 			
	 	int ret; int fdout, fderr;
	 	for (int i = 0; i < c -> _numberOfSimpleCommands; ++i){
	 		dup2 (fdin, 0);
	 		close (fdin);
	 		
	 		if (i == c-> _numberOfSimpleCommands-1){
	 			if (c -> _outFile){
	 				if (c -> _append == 1)
		 				fdout = open(c->_outFile, O_WRONLY | O_CREAT | O_APPEND, 0777);
		 			else
		 				fdout = open(c->_outFile, O_WRONLY | O_CREAT, 0777);
	 			}
	 			else{
		 			fdout = dup(tmpout);
		 		}
		 		if (c -> _errFile){
		 			fderr = open(c->_errFile, O_WRONLY | O_CREAT);
		 		}
		 		else{
		 			fderr = dup(tmperr);
		 		}
	 		}
	 		else{
	 			int fdpipe[2];
	 			pipe(fdpipe);
	 			fdout = fdpipe[1];
	 			fdin = fdpipe[0];
	 		}
	 		dup2 (fderr, 2);
	 		close (fderr);
	 		dup2(fdout, 1);
	 		close (fdout);
	 		
	 		ret = fork();
	 		if (ret == 0){
	 			execvp(c->_simpleCommands[i]->_arguments[0], c->_simpleCommands[i]->_arguments);
	 			perror("ceva ati incurcat(sau noi)");
	 			_exit(1);
	 		}
	 		kill(ret, SIGCONT);
	 	}
	 	
	 	dup2(tmpin, 0);
	 	dup2(tmpout, 1);
	 	dup2(tmperr, 2);
	 	close(tmperr);
	 	close(tmpin);
	 	close(tmpout);
	 	if (!c-> _background){
	 		waitpid (ret, NULL, 0);
	 	}

	 }
 		
 	struct SimpleCommand * currSimpleComm;
	struct Command * currComm;
 	 
 	 void storeInHistory(char* comm){
 	 	int fd = open("history.txt", O_WRONLY | O_CREAT | O_APPEND, 0777);
 	 	int written = write(fd, comm, strlen(comm));
 	 	if (written < 0){
 	 		perror("write in history failure");
 	 		return;
 	 	}
 	 	close (fd);
 	 }
 	 
 	 void showHist(){
 	 	int ret = fork();
 	 	if (ret == 0){
	 	 	char * argList[] = {"less", "-FXN", "history.txt", NULL};
 	 		execvp ("less", argList);
 	 	}
 	 	waitpid(ret, NULL, 0);
 	 }
 	
 	void sigHandler(int sig){
 		printf("Programul s-a terminat. Puteti folosi shell-ul in continuare!\n");
 	}	 
 	 
%}
%union {
	char * str;
}

%token WORD NOTOKEN PIPE GREAT GREATGREATAMPERSAND HISTORY
	GREATAMPERSAND LESS AMPERSAND NEWLINE GREATGREAT; 
 
%type <str> WORD;

 
%start goal


%% 
goal: command_list;

	
cmd_start: WORD{
		if (isPipe){
			strcat(commandText, "| ");
		}
		isPipe = 1;
		strcat(commandText, $1);
		strcat(commandText, " ");
		currSimpleComm = SimpleCommandNew();
		insertArg(&currSimpleComm, $1); 
	};


cmd_and_args: cmd_start arg_list;

arg_list: arg_list WORD{
		strcat(commandText, $2);
		strcat(commandText, " ");
		insertArg(&currSimpleComm, $2);
	}
	|;
	
pipe_list: cmd_and_args{
		currComm = CommandNew();
		insertSimpleCommand(&currComm, currSimpleComm);
		//free(currSimpleComm);
	}
	| pipe_list PIPE cmd_and_args{
		insertSimpleCommand(&currComm, currSimpleComm);
		//free(currSimpleComm);
	};
	

io_modifier:
	GREATGREAT WORD{
		strcat(commandText, ">> ");
		strcat (commandText, $2);
		currComm -> _outFile = $2;
		currComm -> _append = 1;
	}
	| GREAT WORD{
		strcat(commandText, "> ");
		strcat (commandText, $2);
		currComm -> _outFile = $2;
		currComm -> _append = 0;
	}
	| GREATAMPERSAND WORD{
		strcat(commandText, ">& ");
		strcat (commandText, $2);
		currComm -> _errFile = $2;
	}
	| LESS WORD{
		strcat(commandText, "< ");
		strcat (commandText, $2);
		currComm -> _inputFile = $2;
	};
	
io_modifier_list: io_modifier
	| io_modifier_list io_modifier
	| /*nimic*/;
	
background_optional:
	AMPERSAND{
		strcat(commandText, "& ");
		currComm -> _background = 1;
	}
	| ;
	
command_line:
	pipe_list io_modifier_list background_optional NEWLINE {
		execute (currComm);
		free(currComm);
	}
	| NEWLINE /*accept empty cmd line*/
	| HISTORY NEWLINE{
		strcpy(commandText, "history");
		showHist();
	}
	| error NEWLINE{yyerrok;};
	

	
command_list: command_list command_line{
		strcat(commandText, "\n");
		storeInHistory(commandText);
		free(commandText);
		commandText = (char*)malloc(100);
		isPipe = 0;
		printf ("sttsh$");
	}
	|;
%%
 
  
void yyerror(char * s)
/* yacc error handler */
{  
	fprintf (stderr, "%s\n", s);
}
  
int main(void)
{
	signal(SIGINT, sigHandler);
	commandText = (char*)malloc(100);
	isPipe = 0;
	while (1){
		prompt();
	}	
} 


