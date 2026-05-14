%{
// --- 1. C DECLARATIONS ---
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror(char *s);
%}

// --- 1.5 YACC DECLARATIONS ---
%token TYPE IDEN NUM
%left '+' '-'
%left '*' '/'

%%
/* --- 2. GRAMMAR RULES --- */

// 1. The Start Symbol. A valid input is a valid function (FUN).
S : FUN             { printf("Accepted\n"); exit(0); } 
  ;

// 2. A Function has a TYPE, an IDEN, parameters in (), and a BODY.
FUN : TYPE IDEN '(' PARAMS ')' BODY 
    ;

// 3. The Body can be a single statement ending in ';' OR a block in { }
BODY : S1 ';' 
     | '{' SS '}'
     ;

// 4. Parameters. This is a RECURSIVE rule. 
// A parameter list is a PARAM, followed by a comma, followed by MORE PARAMS.
// Or just a single PARAM, or entirely empty.
PARAMS : PARAM ',' PARAMS 
       | PARAM 
       | /* empty */ 
       ;

// 5. A single parameter is just a TYPE and an IDEN (e.g., "int x")
PARAM : TYPE IDEN 
      ;

// 6. Set of Statements (also RECURSIVE). 
// It's a single statement, followed by more statements, or empty.
SS : S1 ';' SS 
   | /* empty */ 
   ;

// 7. A Single Statement can be an assignment, an expression, or a declaration.
S1 : ASSGN 
   | E 
   | DECL 
   ;

// 8. Declarations (e.g., "int x" or "int x = 5")
DECL : TYPE IDEN 
     | TYPE ASSGN 
     ;

// 9. Assignments (e.g., "x = 5 + 2")
ASSGN : IDEN '=' E 
      ;

// 10. Expressions (Standard math, plus ++ and -- operators)
E : E '+' E 
  | E '-' E 
  | E '*' E 
  | E '/' E 
  | '-' '-' E     // --x
  | '+' '+' E     // ++x
  | E '+' '+'     // x++
  | E '-' '-'     // x--
  | T             // Base case: an expression can just be a Term
  ;

// 11. A Term is just a number or a variable
T : NUM 
  | IDEN 
  ;

%%
// --- 3. C FUNCTIONS ---

int main() {
    printf("Enter function declaration (e.g., int main() { int x = 5; }):\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("ERROR: Invalid syntax\n");
    exit(0);
}