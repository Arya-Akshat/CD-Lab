%{
// --- 1. C DECLARATIONS ---
#include "y.tab.h"
%}

%option noyywrap

%%
/* --- 2. TRANSLATION RULES --- */

[\t\n ]                     ; /* Ignore spaces, tabs, and newlines */

"int"|"float"|"char"|"void" { return TYPE; }  /* Recognize standard C data types */

[a-zA-Z][a-zA-Z0-9_]* { return IDEN; }  /* Variables must start with a letter, followed by letters/numbers/_ */

[0-9]+                      { return NUM; }   /* Recognize whole numbers */

.                           { return yytext[0]; } /* Pass brackets { } ( ) , ; = straight to Yacc */

%%