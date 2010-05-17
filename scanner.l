/* 
 =================================================================================
 * Program Name 	: scanner.l
 * Author		: #B96902133, Hakki Caner Kirmizi
 * Date			: 20100516
 * Description		: A source code scanner for 'imaginative' csie programming
 * 			  language written with flex.
 * Environment		: Windows-7 Entreprise
 * Editor		: vim 7.2 for WIN 
 * Integration Tests	: linux2.csie.ntu.edu.tw
 * Flex			: 2.5.35
 * Bison		: bison (GNU Bison) 2.4.1
 * Compiler		: gcc (Debian 4.4.4-1) 4.4.4
 * Version Control	: TortoiseSVN 1.6.8, Build 19260 - 32 Bit
 * Project Hosting	: http://code.google.com/p/csie-parser/
 *
 =================================================================================
 */

	/* Grab yylineno in order to output syntax error(s) in parsing stage */
%option yylineno
  
	/* ----- DEFINITIONS PART ----- */

	/* DEFINITIONS FOR FINITE AUTOMATA */
	/* ------------------------------- */
	
	/* Universal Character Name: the naming conventions for UCS defined by International Standard ISO/IEC 10646 */
UCN     		(\\u[0-9a-fA-F]{4}|\\U[0-9a-fA-F]{8})
	
	/* DIGIT: any number from 0 to 9 */
DIGIT			[0-9]

	/* LETTER: any uppercase or lowercase letter */
LETTER			[A-Za-z]

	/* DELIMITER: any occurence of 'space', 'tab' or 'newline' */
DELIMITER		[ \t\n]

	/* IDENTIFIER: starting with a letter; following by any occurence of letter, digit or underscore */
IDENTIFIER		[a-zA-Z_][a-zA-Z0-9_]*

	/* INTEGER: 0 or more occurence of consecutive digits */
INTEGER			{DIGIT}+(\.{DIGIT}+)?(E[+-]?{DIGIT}+)?

	/* STRING: anything between double quote; just considers \" and \\ characters */
STRING			L?\"([^"\\]|\\['"?\\abfnrtv]|\\[0-7]{1,3}|\\[Xx][0-9a-fA-F]+|{UCN})*\"

	/* COMMENT: any c style comment */
COMMENT			("/*"([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*"*"+"/")|("//".*)


%%	/* ----- RULES PART ----- */

	/* rules for operators */
"||"			{ yylval = atoi(yytext); return OR; }
"&&"			{ yylval = atoi(yytext); return AND; }
"!"			{ yylval = atoi(yytext); return NOT; }
">"			{ yylval = atoi(yytext); return GREATERTHAN; }
">="			{ yylval = atoi(yytext); return GREATEREQ; }
"<"			{ yylval = atoi(yytext); return LESSTHAN; }
"<="			{ yylval = atoi(yytext); return LESSEQ; }
"=="			{ yylval = atoi(yytext); return EQUAL; }
"!="			{ yylval = atoi(yytext); return NOTEQ; }

	/* rules for keywords */
"int"			{ yylval = atoi(yytext); return INTSYM; }
"if"			{ yylval = atoi(yytext); return IFSYM; }
"else"			{ yylval = atoi(yytext); return ELSESYM; }
"while"			{ yylval = atoi(yytext); return WHILESYM; }
"break"			{ yylval = atoi(yytext); return BREAKSYM; }
"continue"		{ yylval = atoi(yytext); return CONTINUESYM; }
"scan"			{ yylval = atoi(yytext); return SCANSYM; }
"print"			{ yylval = atoi(yytext); return PRINTSYM; }

	/* rules for identifiers */
{IDENTIFIER}		{ yylval = atoi(yytext); return ID; }

	/* rules for literals */
{INTEGER}		{ yylval = atoi(yytext); return NUMBER; }

	/* ignore any kind of white space; i.e. no 'action'! */
{DELIMITER}+

	/* ignore any kind of comments; i.e. no 'action'! */
{COMMENT}
	
	/* new line */
\n|.	 		{ return yytext[0]; }


%%	/* ----- USER CODE PART ----- */

	
