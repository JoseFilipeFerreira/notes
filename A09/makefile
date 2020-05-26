compiler: compiler.fl compiler.y
	flex compiler.fl
	yacc -d compiler.y
	cc -g lex.yy.c y.tab.c -lm -o compiler
