%{
// --- 1. C DECLARATIONS ---
#include <stdio.h>
int posint = 0, negint = 0, posfrac = 0, negfrac = 0;
%}

%option noyywrap

/* --- 1.5 LEX DEFINITIONS (MACROS) --- */
/* Think of these as variables holding regular expressions */

/* A number is one or more digits */
num     [0-9]+

/* Positive int: Optional '+' followed by a number */
posint  \+?{num}

/* Negative int: A '-' followed by a number */
negint  -{num}

/* Positive fraction: (+/+) OR (-/-) */
/* Notice we use \/ to escape the division slash so Lex doesn't get confused */
posnum  \+?{num}\/\+?{num}|-{num}\/-{num}

/* Negative fraction: (-/+) OR (+/-) */
negnum  -{num}\/\+?{num}|\+?{num}\/-{num}

%%
    /* --- 2. TRANSLATION RULES --- */

{posint}    { posint++; }
{negint}    { negint++; }
{posnum}    { posfrac++; }
{negnum}    { negfrac++; }

[ \t]       ;               /* Ignore spaces and tabs */

\n          { return 0; }   /* Enter key ends the input */

.           { ECHO; }       /* ECHO is a built-in Lex command. It just prints whatever it matched.
                               If the user types a random letter like 'A', it just prints 'A' and moves on. */

%%
// --- 3. C FUNCTIONS ---

int main() {
    printf("Enter numbers separated by spaces (Enter to stop):\n");
    yylex();
    
    printf("Positive integers: %d\n", posint);
    printf("Negative integers: %d\n", negint);
    printf("Positive fractions: %d\n", posfrac);
    printf("Negative fractions: %d\n", negfrac);
    return 0;
}