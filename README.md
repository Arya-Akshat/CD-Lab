# Compiler Design Programs

This folder contains a set of Flex (Lex) and Bison (Yacc) programs used for compiler design practice. The actual source code is kept in the program folders; this README only explains what each program does and how to compile and run it.

---

## Program 1 - String Parser for a^n b^(n+m) c^m

Files:
- [Prog1/Lex/lex.l](Prog1/Lex/lex.l)
- [Prog1/Yacc/yacc.y](Prog1/Yacc/yacc.y)

Description:
- Checks whether the input string belongs to the language a^n b^(n+m) c^m with n > 0 and m > 0.

Compile and run:
```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog1'
yacc -d Yacc/yacc.y
flex Lex/lex.l
cc lex.yy.c y.tab.c -o prog1 -ll
./prog1
```

---

## Program 2 - Text Counter

Files:
- [Prog2/Lex/lex.l](Prog2/Lex/lex.l)

Description:
- Counts lines, words, characters, and spaces until `#` is entered.

Compile and run:
```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog2'
flex Lex/lex.l
cc lex.yy.c -o prog2 -ll
./prog2
```

---

## Program 3 - For-Loop Analysis and Function Syntax Checking

### Program 3a - For-Loop Depth Counter

Files:
- [Prog3/a/lex.l](Prog3/a/lex.l)
- [Prog3/a/yacc.y](Prog3/a/yacc.y)

Description:
- Parses simplified C-like code, counts total `for` loops, and computes the maximum nesting depth using mid-rule actions.

Compile and run:
```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog3/a'
yacc -d yacc.y
flex lex.l
cc lex.yy.c y.tab.c -o prog3a -ll
./prog3a
```

### Program 3b - C Function Syntax Checker

Files:
- [Prog3/b/lex.l](Prog3/b/lex.l)
- [Prog3/b/yacc.y](Prog3/b/yacc.y)

Description:
- Checks whether a C-like function declaration and body follow the supported syntax.

Compile and run:
```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog3/b'
yacc -d yacc.y
flex lex.l
cc lex.yy.c y.tab.c -o prog3b -ll
./prog3b
```

---

## Program 4 - Three Address Code and Quadruples

Files:
- [Prog4/lex.l](Prog4/lex.l)
- [Prog4/yacc.y](Prog4/yacc.y)

Description:
- Parses arithmetic expressions and generates both three-address code and quadruples.

Compile and run:
```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog4'
yacc -d yacc.y
flex lex.l
cc lex.yy.c y.tab.c -o prog4 -ll
./prog4
```

---

## Program 5 - Target Code Generation

Files:
- [Prog5/lex.l](Prog5/lex.l)
- [Prog5/yacc.y](Prog5/yacc.y)

Description:
- Parses arithmetic expressions and converts the intermediate form into simple target code instructions.

Compile and run:
```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog5'
yacc -d yacc.y
flex lex.l
cc lex.yy.c y.tab.c -o prog5 -ll
./prog5
```

---

## Boilerplate Notes

Use these commands as the standard pattern for this folder:

```bash
yacc -d yacc.y
flex lex.l
cc lex.yy.c y.tab.c -o program_name -ll
./program_name
```

If your system uses Bison instead of Yacc, `bison -d -y yacc.y` is the equivalent parser-generation command.

General meanings of the tools:
- `bison -d` generates the parser source and header files.
- `flex` generates the scanner source file.
- `cc` compiles and links the generated C files into an executable.

If a grammar uses only integer semantic values, `%union` and `%type` are not required. They are needed when semantic values have different types.

---

## Exam Cheat Sheet Skeletons

Memorize these two skeletons to keep your exam answer structure clean and to quickly write a valid Lex/Yacc program format.

### 1. The Lex Skeleton (`lex.l`)

```c
%{
#include <stdio.h>
#include "y.tab.h"  /* Only include this if there is a Yacc file */
%}

%option noyywrap

%%
/* ---> YOUR RULES GO HERE <--- */
%%
```

### 2. The Yacc Skeleton (`yacc.y`)

```c
%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyerror();
%}

/* ---> %token DEFINITIONS GO HERE <--- */

%%
/* ---> YOUR GRAMMAR GOES HERE <--- */
%%

int main() {
	yyparse();
	return 0;
}

int yyerror() {
	printf("Error!\n");
	exit(0);
}
```
