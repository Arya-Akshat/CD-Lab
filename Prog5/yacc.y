%{
// --- 1. C DECLARATIONS ---
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
int yyerror(const char *s);

typedef char *string;

// Our Quadruple table from Program 4!
struct {
    string res, op1, op2;
    char op;
} code[100];

int idx = -1;

string addToTable(string op1, string op2, char op);
void targetCode();
%}

// --- 1.5 YACC DECLARATIONS ---
%union { char *exp; }

%token <exp> IDEN NUM
%type <exp> EXP

%left '+' '-'
%left '*' '/'

%%
/* --- 2. GRAMMAR RULES --- */

STMTS : STMTS STMT | ;

STMT  : EXP '\n' 
      ;

EXP : EXP '+' EXP  { $$ = addToTable($1, $3, '+'); }
    | EXP '-' EXP  { $$ = addToTable($1, $3, '-'); }
    | EXP '*' EXP  { $$ = addToTable($1, $3, '*'); }
    | EXP '/' EXP  { $$ = addToTable($1, $3, '/'); }
    | '(' EXP ')'  { $$ = $2; }
    | IDEN '=' EXP { $$ = addToTable($1, $3, '='); }
    | IDEN         { $$ = $1; }
    | NUM          { $$ = $1; }
    ;

%%
// --- 3. C FUNCTIONS ---

int main() {
    printf("Enter expression:\n");
    yyparse();

    printf("\nTarget code:\n");
    targetCode();
    return 0;
}

int yyerror(const char *s) {
    printf("Error: %s\n", s);
    exit(0);
}

// Exactly the same table builder as Program 4
string addToTable(string op1, string op2, char op) {
    // Clever shortcut: If it's an assignment like "x = @A", 
    // just rename the result of the last math operation from "@A" to "x".
    if(op == '=') {
        code[idx].res = op1; 
        return op1;
    }

    idx++;
    string res = malloc(3);
    sprintf(res, "@%c", idx + 'A');

    code[idx].op1 = op1;
    code[idx].op2 = op2;
    code[idx].op = op;
    code[idx].res = res;
    return res;
}

// --- THE NEW PART ---
void targetCode() {
    // Loop through every row in our table
    for(int i = 0; i <= idx; i++) {
        string instr;
        
        // Figure out which assembly command to use
        switch(code[i].op) {
            case '+': instr = "ADD"; break;
            case '-': instr = "SUB"; break;
            case '*': instr = "MUL"; break;
            case '/': instr = "DIV"; break;
        }

        // Print the assembly instructions for this specific row
        printf("LOAD\t R1, %s\n", code[i].op1);   // Load first variable into Register 1
        printf("LOAD\t R2, %s\n", code[i].op2);   // Load second variable into Register 2
        printf("%s\t R3, R1, R2\n", instr);       // Do the math, put answer in Register 3
        printf("STORE\t %s, R3\n", code[i].res);  // Store Register 3 back into memory
    }
}