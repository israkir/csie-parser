# Makefile for parser.y & scanner.l
# Author: b96902133, Hakki Caner KIRMIZI
# Date: 2010-5-22

LEX=flex
YACC=bison
PROG=parser
SCNR=scanner
CC=gcc
SRCS=$(PROG).y $(SCNR).l
LIBS=-ly -ll -lfl

all: $(PROG)

$(PROG): $(SRCS)
	$(LEX) $(SCNR).l
	$(YACC) -v $(PROG).y
	$(CC) $(PROG).tab.c $(LIBS) -o $(PROG)

clean:
	rm -rf $(PROG) lex.yy.c $(PROG).tab.h $(PROG).tab.c $(PROG).output *.o
