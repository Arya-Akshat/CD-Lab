# Compiler Design Programs

Compact index for the Flex/Yacc exercises in this folder. The source code lives in the program directories; this file only explains what each one does and how to run it.

---

## Program 1

### 1a - Text Counter
Files: [Prog1/Lex/lex.l](Prog1/Lex/lex.l)

Counts lines, words, characters, and spaces until `#` is entered.

```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog1/Lex'
flex lex.l
cc lex.yy.c -o prog1a -ll
./prog1a
```

### 1b - String Parser for a^n b^(n+m) c^m
Files: [Prog1/Yacc/lex.l](Prog1/Yacc/lex.l), [Prog1/Yacc/yacc.y](Prog1/Yacc/yacc.y)

Checks whether the input string belongs to the language a^n b^(n+m) c^m with n > 0 and m > 0.

```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog1/Yacc'
yacc -d yacc.y
flex lex.l
cc lex.yy.c y.tab.c -o prog1b -ll
./prog1b
```

---

## Program 2

### 2a - Fraction & Integer Counter
Files: [Prog2/Lex/lex.l](Prog2/Lex/lex.l)

Counts positive integers, negative integers, positive fractions, and negative fractions.

```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog2/Lex'
flex lex.l
cc lex.yy.c -o prog2a -ll
./prog2a
```

### 2b - Arithmetic Calculator
Files: [Prog2/Yacc/lex.l](Prog2/Yacc/lex.l), [Prog2/Yacc/yacc.y](Prog2/Yacc/yacc.y)

Parses arithmetic expressions with `+`, `-`, `*`, `/`, parentheses, and negative numbers, then prints the integer result.

```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog2/Yacc'
yacc -d yacc.y
flex lex.l
cc lex.yy.c y.tab.c -o prog2b -ll
./prog2b
```

---

## Program 3

### 3a - For-Loop Depth Counter
Files: [Prog3/a/lex.l](Prog3/a/lex.l), [Prog3/a/yacc.y](Prog3/a/yacc.y)

Parses simplified C-like code, counts total `for` loops, and computes the maximum nesting depth using mid-rule actions.

```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog3/a'
yacc -d yacc.y
flex lex.l
cc lex.yy.c y.tab.c -o prog3a -ll
./prog3a
```

### 3b - C Function Syntax Checker
Files: [Prog3/b/lex.l](Prog3/b/lex.l), [Prog3/b/yacc.y](Prog3/b/yacc.y)

Checks whether a C-like function declaration and body follow the supported syntax.

```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog3/b'
yacc -d yacc.y
flex lex.l
cc lex.yy.c y.tab.c -o prog3b -ll
./prog3b
```

---

## Program 4 - Three Address Code and Quadruples
Files: [Prog4/lex.l](Prog4/lex.l), [Prog4/yacc.y](Prog4/yacc.y)

Parses arithmetic expressions and generates both three-address code and quadruples.

```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog4'
yacc -d yacc.y
flex lex.l
cc lex.yy.c y.tab.c -o prog4 -ll
./prog4
```

---

## Program 5 - Target Code Generation
Files: [Prog5/lex.l](Prog5/lex.l), [Prog5/yacc.y](Prog5/yacc.y)

Parses arithmetic expressions and converts the intermediate form into simple target code instructions.

```bash
cd '/Users/gurudev/Desktop/College/CD LAB /Compiler-Design/Prog5'
yacc -d yacc.y
flex lex.l
cc lex.yy.c y.tab.c -o prog5 -ll
./prog5
```

---

## Boilerplate Notes

Standard build pattern:

```bash
yacc -d yacc.y
flex lex.l
cc lex.yy.c y.tab.c -o program_name -ll
./program_name
```

If you use Bison instead of Yacc, `bison -d -y yacc.y` is the equivalent parser command.

Tool meanings:
- `bison -d` or `yacc -d` generates parser source and header files.
- `flex` generates the scanner source file.
- `cc` compiles and links the generated C files into an executable.

If a grammar uses only integer semantic values, `%union` and `%type` are not required.

---

## Exam Cheat Sheet Skeletons

### Lex skeleton (`lex.l`)

```c
%{
#include <stdio.h>
#include "y.tab.h"
%}

%option noyywrap

%%
/* ---> YOUR RULES GO HERE <--- */
%%
```

### Yacc skeleton (`yacc.y`)

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
