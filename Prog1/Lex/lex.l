%{
// --- 1. C DECLARATIONS ---
#include <stdio.h>
int lines = 0, chars = 0, words = 0, spaces = 0;
%}

/* Tell Lex we are only reading one file, so we don't need the yywrap() function */
%option noyywrap 

%%
        /* --- 2. TRANSLATION RULES --- */

\n              { lines++; }      /* Every Enter key is a new line */

\t              { spaces += 4; }  /* Treat a tab as 4 spaces */

[ ]             { spaces++; }     /* A single space */

[^ \t\n#]+      { 
                    /* Regex breakdown:
                       [^ ...] means "Match anything EXCEPT what is in these brackets"
                       So this matches any chunk of characters that is NOT a space, tab, newline, or #.
                       The + means "one or more of these in a row". This defines our "word".
                       
                       yyleng is a built-in Lex variable that holds the length of the matched text.
                    */
                    words++; 
                    chars += yyleng; 
                }

#               { return 0; }     /* Stop scanning when we see a hashtag */

%%
// --- 3. C FUNCTIONS ---

int main() {
    printf("Enter the string (Type # to end):\n");
    yylex(); // Start scanning! It will keep scanning until a rule returns 0
    
    printf("Lines: %d\nWords: %d\nChars: %d\nSpaces: %d\n", lines, words, chars, spaces);
    return 0;
}