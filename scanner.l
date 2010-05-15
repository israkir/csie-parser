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
IDENTIFIER		([_a-zA-Z]|{UCN})([_a-zA-Z0-9]|{UCN})*

	/* INTEGER: 0 or more occurence of consecutive digits */
INTEGER			{DIGIT}+(\.{DIGIT}+)?(E[+-]?{DIGIT}+)?

	/* STRING: anything between double quote; just considers \" and \\ characters */
STRING			L?\"([^"\\]|\\['"?\\abfnrtv]|\\[0-7]{1,3}|\\[Xx][0-9a-fA-F]+|{UCN})*\"

	/* COMMENT: any c style comment */
COMMENT			("/*"([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*"*"+"/")|("//".*)


%%	/* ----- RULES PART ----- */


	/* RULES FOR LITERALS */
	/* ------------------ */
{INTEGER}		{ yylval = atoi(yytext); return NUMBER; }

	/* ignore any kind of white space; i.e. no 'action'! */
{DELIMITER}+

	/* ignore any kind of comments; i.e. no 'action'! */
{COMMENT}
	
	/* new line */
\n|.	 		{ return yytext[0]; }


%%	/* ----- USER CODE PART ----- */

	
