compile: compiler.fl compiler.y
	flex compiler.fl
	yacc -d compiler.y
	cc lex.yy.c y.tab.c -lm -o compile
