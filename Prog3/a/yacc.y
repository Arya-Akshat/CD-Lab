%{
// --- 1. C DECLARATIONS ---
#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyerror(const char *s);

// Global variables to track our state
int total_for_count = 0;      
int current_nesting = 0;      
int max_nesting = 0;          
%}

// --- 1.5 YACC DECLARATIONS ---
%token FOR IDEN NUM OP

%%
/* --- 2. GRAMMAR RULES --- */

// A program is a single statement, or multiple statements
STMTS : STMT
      | STMTS STMT
      ;

// What counts as a statement?
STMT : FORSTMT                // A for loop
     | IDEN '=' EXPR ';'      // An assignment (e.g., x = 5;)
     | IDEN ';'               // Just a variable (e.g., x;)
     | '{' STMTS '}'          // A block of code inside brackets
     | ';'                    // An empty statement
     ;

// --- THE MAGIC HAPPENS HERE ---
FORSTMT : FOR '(' ASSGN ';' COND ';' ASSGN ')' 
          {
              // MID-RULE ACTION: Yacc runs this the moment it sees the ')'
              // We just entered a for loop!
              total_for_count++;             
              current_nesting++;              
              
              if (current_nesting > max_nesting) {
                  max_nesting = current_nesting;  
              }
          }
          STMT 
          {
              // END-RULE ACTION: Yacc runs this after it finishes parsing the loop's body (STMT)
              // We are exiting the for loop!
              current_nesting--;            
          }
        ;

// Helper rules to define the pieces of the for loop
ASSGN : IDEN '=' EXPR | IDEN | /* empty */ ;
COND  : IDEN OP IDEN | IDEN OP NUM | IDEN | NUM ;
EXPR  : IDEN | NUM | IDEN '+' IDEN | IDEN '-' IDEN | IDEN '*' IDEN | IDEN '/' IDEN ;

%%
// --- 3. C FUNCTIONS ---

int main() {
    printf("Enter the code snippet (Ctrl+D / Ctrl+Z to stop):\n");
    yyparse();
    
    // Print the final score!
    printf("\nTotal FOR loops: %d\n", total_for_count);
    printf("Maximum nesting level: %d\n", max_nesting);
    return 0;
}

int yyerror(const char *s) {
    printf("Parse error\n");
    exit(1);
}