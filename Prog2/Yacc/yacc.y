%{
// --- 1. C DECLARATIONS ---
#include <stdio.h>
#include <stdlib.h>       
int yylex();
int yyerror(char *s); // Adding 'char *s' allows us to pass custom error messages
%}

// --- 1.5 YACC DECLARATIONS ---
%token NUM

/* Precedence Rules: 
   Things lower down in this list happen FIRST (like standard math).
   %left means these operators group left-to-right (e.g., 5-3-1 is evaluated as (5-3)-1).
*/
%left '+' '-'
%left '*' '/'

%%
/* --- 2. GRAMMAR RULES --- */

// $$ represents the result of the left side (S)
// $1 represents the value of the 1st thing on the right side (E)

S : E           { printf("Result is %d\n", $1); } // When the whole expression is solved, print it!
  ;

// For the rule E : E '+' E
// $1 is the first E, $2 is the '+', $3 is the second E.
// $$ is the result we are calculating.

E : E '+' E     { $$ = $1 + $3; }
  | E '-' E     { $$ = $1 - $3; }
  | E '*' E     { $$ = $1 * $3; }
  | E '/' E     { 
                    if($3 == 0) {
                        yyerror("Divide by zero"); // Prevent crashing
                    } else {
                        $$ = $1 / $3; 
                    }
                }
  | '(' E ')'   { $$ = $2; }      // The value of the parentheses is just the value of the E inside (which is the 2nd item)
  | NUM         { $$ = $1; }      // Base case: An expression can just be a number. We get $1 from yylval in Lex!
  | '-' NUM     { $$ = -$2; }     // Handles negative numbers like -5
  ;

%%
// --- 3. C FUNCTIONS ---

int main() {
    printf("Enter operation (e.g., 5+3*2):\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Invalid: %s\n", s);
    exit(0);
}