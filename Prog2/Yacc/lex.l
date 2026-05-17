%{
// --- 1. C DECLARATIONS ---
#include "y.tab.h" 
// We don't need 'extern YYSTYPE yylval;' here, y.tab.h handles it automatically in modern Yacc!
%}

%%
    /* --- 2. TRANSLATION RULES --- */

[0-9]+  { 
            // yytext is the string Lex found (e.g., "42")
            // atoi() converts the string "42" into the integer 42
            // yylval is the mailbox where we leave this integer for Yacc to pick up
            yylval.num = atoi(yytext); 
            return NUM; // Tell Yacc: "I found a number!"
        }

[ \t]   ;               /* If you see a space or tab, do nothing (ignore it) */

\n      { return 0; }   /* Enter key = End of input */

.       { return yytext[0]; } /* For anything else (+, -, *, /, (, ) ), 
                                 just pass the character itself to Yacc */

%%