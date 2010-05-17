#!/bin/bash

flex scanner.l
bison -v parser.y
gcc parser.tab.c -ly -ll -lfl
a.out