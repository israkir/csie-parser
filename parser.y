/* 
 =============================================================================
 * Program Name 	: parser.y
 * Author		: #B96902133, Hakki Caner Kirmizi
 * Date			: 20100516
 * Description		: A parser for 'imaginative' csie programming language
 *			  written with GNU Bison.
 * Environment		: Windows-7 Entreprise
 * Editor		: vim 7.2 for WIN 
 * Integration Tests	: linux2.csie.ntu.edu.tw
 * Flex			: 2.5.35
 * Bison		: bison (GNU Bison) 2.4.1
 * Compiler		: gcc (Debian 4.4.4-1) 4.4.4
 * Version Control	: TortoiseSVN 1.6.8, Build 19260 - 32 Bit
 * Project Hosting	: http://code.google.com/p/csie-parser/
 *
 =============================================================================
 */
 
	/* ----- DEFINITIONS PART ----- */
	/* ============================ */
%{
  #define YYSTYPE double
  #include <math.h>
  #include <stdio.h>
%}

%token NUMBER
%nonassoc '{' '}'
%left '+' '-'
%left '*' '/'
%right NEG


%%	/* ----- GRAMMAR RULES PART ----- */
	/* ============================== */

program		: /* empty */
		| program blockStmt
		;
			
blockStmt	: '{' stmt '}'
		;
			
stmt		: arithExpr ';'			{ printf ("\t%.10g\n", $1); }
		;
		
arithExpr	: NUMBER			{ $$ = $1;          }
		| arithExpr '+' arithExpr	{ $$ = $1 + $3;     }
		| arithExpr '-' arithExpr	{ $$ = $1 - $3;     }
		| arithExpr '*' arithExpr	{ $$ = $1 * $3;     }
		| arithExpr '/' arithExpr	{ $$ = $1 / $3;     } 
		| '+' arithExpr			{ $$ = +$2;         }
		| '-' arithExpr %prec NEG	{ $$ = -$2;         }
		| '(' arithExpr ')'		{ $$ = $2;          }
		;

	
%%	/* ----- USER SUBROUTINES PART ----- */
	/* ================================= */


#include "lex.yy.c"

yyerror(const char *msg)
{
	printf("Fail (around line %d)\n", yylineno);
}
