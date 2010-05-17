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

%token ID NUMBER INTSYM IFSYM ELSESYM WHILESYM BREAKSYM CONTINUESYM SCANSYM PRINTSYM GREATERTHAN GREATEREQ LESSTHAN LESSEQ EQUAL NOTEQ
%nonassoc '{' '}' '[' ']' ';' ','
%right '='
%left OR
%left AND
%left '+' '-'
%left '*' '/'
%right NOT
%left '(' ')'
%right NEG


%%	/* ----- GRAMMAR RULES PART ----- */
	/* ============================== */

program		: /* lambda */
		| program blockStmt
		;
			
blockStmt	: '{' varDeclInit stmtInit '}'
		;

varDeclInit	: /* lambda */
	 	| INTSYM intArrayInit ID idList ';' varDeclInit
	 	;

intArrayInit	: /* lambda */
	  	| '[' NUMBER ']' intArrayInit 
		;

idList		: /* lambda */
		| ',' ID idList
		;
			
var		: ID arithExprInit
     		;

varList		: /* lambda */
	 	| ',' var varList
	 	;

arithExprInit	: /* lambda */
	      	| '[' arithExpr ']' arithExprInit
		;

arithExprList	: /* lambda */
	      	| ',' arithExpr arithExprList
	      	;

stmtInit	: /* lambda */
      		| var '=' arithExpr ';' stmtInit
		| IFSYM '(' boolExpr ')' blockStmt stmtInit
		| IFSYM '(' boolExpr ')' blockStmt ELSESYM blockStmt stmtInit
		| WHILESYM '(' boolExpr ')' blockStmt stmtInit
		| BREAKSYM ';' stmtInit
		| CONTINUESYM ';' stmtInit
		| SCANSYM '(' var varList ')' ';' stmtInit
		| PRINTSYM '(' arithExpr arithExprList ')' ';' stmtInit
		| blockStmt stmtInit
		;
		
arithExpr	: arithExpr '+' arithExpr
		| arithExpr '-' arithExpr
		| arithExpr '*' arithExpr
		| arithExpr '/' arithExpr
		| '+' arithExpr
		| '-' arithExpr %prec NEG
		| NUMBER
		| var
		| '(' arithExpr ')'
		;

boolExpr	: boolExpr OR boolExpr
	 	| boolExpr AND boolExpr
		| NOT boolExpr
	 	| arithExpr GREATERTHAN arithExpr
		| arithExpr GREATEREQ arithExpr
		| arithExpr LESSTHAN arithExpr
	 	| arithExpr LESSEQ arithExpr
		| arithExpr EQUAL arithExpr
		| arithExpr NOTEQ arithExpr
		;

	
%%	/* ----- USER SUBROUTINES PART ----- */
	/* ================================= */


#include "lex.yy.c"

yyerror(const char *msg)
{
	printf("Fail (around line %d)\n", yylineno);
}
