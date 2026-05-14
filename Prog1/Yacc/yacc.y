%{
// --- 1. C DECLARATIONS SECTION ---
#include <stdio.h>  // Standard I/O for printf
#include <stdlib.h> // Standard library for the exit() function

int yylex();        // Tells Yacc: "Don't worry, Lex will provide this function to get tokens."
int yyerror();      // Tells Yacc: "If the grammar is violated, call this error handler."
%}

%%
/* --- 2. GRAMMAR RULES (CFG) SECTION --- */

S : A B             /* The Start symbol S must be an 'A' followed by a 'B' */
  ;                 /* Semicolon marks the end of the rule for S */

A : 'a' A 'b'       /* A can be an 'a', followed by another 'A', followed by a 'b' (Recursive to allow a^n b^n) */
  |                 /* OR (|) it can be empty (Epsilon). We just leave the right side blank! */
  ;

B : 'b' B 'c'       /* B can be a 'b', followed by another 'B', followed by a 'c' (Recursive to allow b^m c^m) */
  |                 /* OR it can be empty (Epsilon) */
  ;

%%
// --- 3. C FUNCTIONS SECTION ---

int main() {
    printf("Enter the input:\n");
    
    yyparse(); // This is the magic function. It starts asking Lex for tokens and building the CFG.
               // It pauses here until the parsing is completely finished.
    
    // If yyparse() finishes without triggering an error, the code continues to the next line:
    printf("Valid string\n"); 
    return 0;
}

// Yacc automatically calls this function the moment an unexpected token breaks the grammar rules
int yyerror() {
    printf("Invalid string\n"); 
    exit(0);   // Immediately kill the program so it doesn't return to main() and print "Valid string"
}