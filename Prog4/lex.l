%{
// --- 1. C DECLARATIONS ---
#include <string.h>
#include "y.tab.h"
%}

%option noyywrap

%%
    /* --- 2. TRANSLATION RULES --- */

[a-zA-Z_][a-zA-Z_0-9]* {
    // strdup() copies the matched text (e.g., "x" or "count") into memory.
    // We store this string in yylval so Yacc can use it.
    yylval.exp = strdup(yytext);
    return IDEN;
}

[0-9]+ {
    // Treat numbers just like strings (e.g., "50")
    yylval.exp = strdup(yytext);
    return NUM;
}

[-+*/()=] { return yytext[0]; } /* Pass operators straight to Yacc */

\n        { return '\n'; }      /* Enter key marks the end of an expression */

[ \t]+    ;                     /* Ignore spaces */

.         ;                     /* Ignore anything else */

%%