%{
// --- 1. C DECLARATIONS ---
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
int yyerror();

typedef char *string; // Just a shortcut so we can type 'string' instead of 'char *'

// This is our Quadruple Table!
struct {
    string res, op1, op2;
    char op;
} code[100];

int idx = -1; // Keeps track of which row of the table we are filling

// Helper functions declared
string addToTable(string op1, string op2, char op);
void threeAddressCode();
void quadruples();
%}

// --- 1.5 YACC DECLARATIONS ---

// %union tells Yacc: "The tokens Lex sends me are going to be strings, not integers."
%union {
    char *exp;
}

%token <exp> IDEN NUM
%type <exp> EXP

%right '='
%left '+' '-'
%left '*' '/'

%%
/* --- 2. GRAMMAR RULES --- */

STMTS : STMTS STMT | ;

STMT  : EXP '\n' 
      ;

// Every time Yacc matches a math operation, it calls addToTable() to create a TAC step.
// addToTable returns the name of the temporary variable (like "@A") so it can be passed up the tree.

EXP : IDEN '=' EXP { $$ = addToTable($1, $3, '='); }
    | EXP '+' EXP  { $$ = addToTable($1, $3, '+'); }
    | EXP '-' EXP  { $$ = addToTable($1, $3, '-'); }
    | EXP '*' EXP  { $$ = addToTable($1, $3, '*'); }
    | EXP '/' EXP  { $$ = addToTable($1, $3, '/'); }
    | '(' EXP ')'  { $$ = $2; }
    | IDEN         { $$ = $1; } // Base case: an expression is just a variable name
    | NUM          { $$ = $1; } // Base case: an expression is just a number string
    ;

%%
// --- 3. C FUNCTIONS ---

int main() {
    printf("Enter an expression (e.g., x = a + b * c):\n");
    yyparse();

    printf("\nThree Address Code:\n");
    threeAddressCode();

    printf("\nQuadruples Table:\n");
    quadruples();
    
    return 0;
}

int yyerror() {
    printf("Error in syntax\n");
    exit(0);
}

// The engine that builds the table
string addToTable(string op1, string op2, char op) {
    // Special case: If it's an assignment (X = t2), we don't need a new temp variable
    if(op == '=') {
        code[idx].res = op1; // Override the result of the last row
        return op1;
    }

    idx++; // Move to the next row in the table
    
    // Create a new temporary variable name (e.g., "@A", "@B")
    string res = malloc(3);
    sprintf(res, "@%c", idx + 'A'); // 'A' + 0 = 'A', 'A' + 1 = 'B', etc.

    // Fill the 4 columns
    code[idx].op1 = op1;
    code[idx].op2 = op2;
    code[idx].op = op;
    code[idx].res = res;
    
    // Return the temp variable (e.g., "@A") back to Yacc so it becomes $$
    return res;
}

void threeAddressCode() {
    for(int i = 0; i <= idx; i++) {
        printf("%s = %s %c %s\n", code[i].res, code[i].op1, code[i].op, code[i].op2);
    }
}

void quadruples() {
    printf("ID\tRes\tOp1\tOp2\tOperator\n"); // Added a header for clarity
    for(int i = 0; i <= idx; i++) {
        printf("%d:\t%s\t%s\t%s\t%c\n", i, code[i].res, code[i].op1, code[i].op2, code[i].op);
    }
}