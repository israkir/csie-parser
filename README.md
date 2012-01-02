Description
===========
A simple parser for 'imaginative' csie programming language written with flex and GNU Bison. Scanner 
    for the csie-language is implemented using flex. Parser is implemented using GNU Bison.

Instructions
============

In order to compilethe program, just:

    $ make
    
in a unix-like system. Then, to run:

    $ ./parser [input-file]
    
---------------------------------------
    
Implemented grammar rules in parser.y are these:

    program -> blockStmt
    blockStmt -> {  [varDecl]  [stmt]  }
    varDecl -> int  [[ num ]] id  [, id]  ; 
    var -> id  [[ arithExpr ]]
    stmt -> var = arithExpr ; 
    stmt -> if ( boolExpr ) blockStmt 
    stmt -> if ( boolExpr ) blockStmt else blockStmt
    stmt -> while ( boolExpr ) blockStmt
    stmt -> break ; 
    stmt -> continue ; 
    stmt -> scan ( var  [, var]) ; 
    stmt -> print ( arithExpr  [, arithExpr]  ) ; 
    stmt -> blockStmt 
    arithExpr -> arithExpr + arithExpr 
    arithExpr -> arithExpr - arithExpr 
    arithExpr -> arithExpr * arithExpr 
    arithExpr -> arithExpr / arithExpr 
    arithExpr -> + arithExpr 
    arithExpr -> - arithExpr 
    arithExpr -> var 
    arithExpr -> num  
    arithExpr -> ( arithExpr ) 
    boolExpr -> boolExpr || boolExpr 
    boolExpr -> boolExpr && boolExpr 
    boolExpr -> ! boolExpr 
    boolExpr -> arithExpr > arithExpr 
    boolExpr -> arithExpr >= arithExpr 
    boolExpr -> arithExpr < arithExpr 
    boolExpr -> arithExpr <= arithExpr 
    boolExpr -> arithExpr == arithExpr 
    boolExpr -> arithExpr != arithExpr 
    
Some notes about grammars above:

* [x] means 0 or more occurrences of x.
* Inner brackets of [[x]] mean x-type array description: 
  e.g. `varDecl -> int  [[ num ]] id  [, id]  ;`
* 'id' is the terminal token for any identifier. For more information about how the identifier 
  defined, please look at scanner.l source code.
* 'num' is the terminal token for integer.
* The first grammar rule program -> blockStmt defines no function mechanism; it is basically main() 
  of the program.
* The grammar rules for 'if' statements:
  `stmt -> if ( boolExpr ) blockStmt` and `stmt -> if ( boolExpr ) blockStmt else blockStmt` 
  define a dangling-else-free statement. So, we do not have to consider a special case for this.
* Associativity and precedence are same as C programming language for the rules:

    arithExpr -> arithExpr + arithExpr 
    arithExpr -> arithExpr - arithExpr 
    arithExpr -> arithExpr * arithExpr 
    arithExpr -> arithExpr / arithExpr 
    arithExpr -> + arithExpr 
    arithExpr -> - arithExpr 

    boolExpr -> boolExpr || boolExpr 
    boolExpr -> boolExpr && boolExpr 
    boolExpr -> ! boolExpr 
   
---------------------------------------   
    
As for the output, there are two possibilities according to the syntax evaluation of the input 
source code. For example, for a valid source code as:

    {
       int a, b, c;
       scan(a, b);
       c = a + b;
       print(c);
    }
    
The output will be: 

    $ Pass
    
However, for a source code which has syntax error as:

    {
       int a, b, c;
       scan(a, b)
       c = a + b;
       print(c);
    }
    
The output will be:

    $ Fail (around line 4)