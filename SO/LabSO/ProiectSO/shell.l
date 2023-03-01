%{

#include <string.h>
#include "y.tab.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

%}

%option noyywrap

%%

"history" {
	return HISTORY;
}

\n {
	return NEWLINE;
}

[ \t] {
	//nimic, daca vad spatii sau taburi le sar
}

">" {
	return GREAT;
}

"<" {
	return LESS;
}
">>" {
	return GREATGREAT;
}
">&" {
	return GREATAMPERSAND;
}

"|" {
	return PIPE;
}

"&" {
	return AMPERSAND;
}

[^ \t\n][^ \t\n]* {
	yylval.str = strdup(yytext);
	return WORD;
}


. {
	return NOTOKEN;
}

%%

