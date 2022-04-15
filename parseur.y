/* file parseur.y
* compilation: bison -d parseur.y
* result: parseur.tab.c = C code for syntaxic analyser
* result: parseur.tab.h = def. of lexical units aka lexems
*/
%{ // the code between %{ and %} is copied at the start of the generated .c
#include <stdio.h>
int yylex(void); // -Wall : avoid implicit call
int yyerror(const char*); // on fonctions defined by the generator
%}
%token NUMBER // kinds of non-trivial tokens expected from the lexer
%start expression // main non-terminal
%% // denotes the begining of the grammar with bison-specific syntax
expression: // an expression is
expression '+' term // either a sum of an expression and a term
| expression '-' term // or an expression minus a term
| term // or a term
;
term: // a term is
term '*' factor // either a product of a term and a factor
| factor // or a factor
;
factor: // a factor is
| '(' expression ')' // either an expression surounded by parentheses
| '-' factor // or the negation of a factor
| NUMBER // or a token NUMBER
;
%% // denotes the end of the grammar
// everything after %% is copied at the end of the generated .c
int yyerror(const char *msg){ // called by the parser if the parsing fails
printf("Parsing:: syntax error\n");
return 1; // to distinguish with the 0 retured by the success
}
