%{
// --- 1. C DECLARATIONS ---
#include "y.tab.h"
%}

%option noyywrap

%%
    /* --- 2. TRANSLATION RULES --- */

"for"                       { return FOR; }  /* Recognize the keyword 'for' */

">"|"<"|">="|"<="|"=="|"!=" { return OP; }   /* Relational operators */

[a-zA-Z]+                   { return IDEN; } /* Identifiers (variable names) */

[0-9]+                      { return NUM; }  /* Numbers */

[\n\t ]                     ;                /* Ignore spaces, tabs, and newlines */

.                           { return yytext[0]; } /* Pass everything else like ( ) ; { } to Yacc */

%%