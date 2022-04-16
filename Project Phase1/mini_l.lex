%{
    int currentLine = 1, currentPos = 1;
%}

DIGIT [0-9]

%%

"function" {printf("FUNCTION\n"); currentPos += yyleng;}
"beginparams" {printf("BEGIN_PARAMS\n"); currentPos += yyleng;}
"endparams" {printf("END_PARAMS\n"); currentPos += yyleng;}
"beginlocals" {printf("BEGIN_LOCALS\n"); currentPos += yyleng;}
"endlocals" {printf("END_LOCALS\n"); currentPos += yyleng;}
"beginbody" {printf("BEGIN_BODY\n"); currentPos += yyleng;}
"endbody" {printf("END_BODY\n"); currentPos += yyleng;}
"integer" {printf("INTEGER\n"); currentPos += yyleng;}
"array" {printf("ARRAY\n"); currentPos += yyleng;}
"enum" {printf("ENUM\n"); currentPos += yyleng;}
"of" {printf("OF\n"); currentPos += yyleng;}
"if" {printf("IF\n"); currentPos += yyleng;}
"then" {printf("THEN\n"); currentPos += yyleng;}
"endif" {printf("ENDIF\n"); currentPos += yyleng;}
"else" {printf("ELSE\n"); currentPos += yyleng;}
"for" {printf("FOR\n"); currentPos += yyleng;}
"while" {printf("WHILE\n"); currentPos += yyleng;}
"do" {printf("DO\n"); currentPos += yyleng;}
"beginloop" {printf("BEGINLOOP\n"); currentPos += yyleng;}
"endloop" {printf("ENDLOOP\n"); currentPos += yyleng;}
"continue" {printf("CONTINUE\n"); currentPos += yyleng;}
"read" {printf("READ\n"); currentPos += yyleng;}
"write" {printf("WRITE\n"); currentPos += yyleng;}
"and" {printf("AND\n"); currentPos += yyleng;}
"or" {printf("OR\n"); currentPos += yyleng;}
"not" {printf("NOT\n"); currentPos += yyleng;}
"true" {printf("TRUE\n"); currentPos += yyleng;}
"false" {printf("FALSE\n"); currentPos += yyleng;}
"return" {printf("RETURN\n"); currentPos += yyleng;}
"+" {printf("ADD\n"); currentPos += yyleng;}
"-" {printf("SUB\n"); currentPos += yyleng;}
"*" {printf("MULT\n"); currentPos += yyleng;}
"/" {printf("DIV\n"); currentPos += yyleng;}
"==" {printf("EQ\n"); currentPos += yyleng;}
"<>" {printf("NEQ\n"); currentPos += yyleng;}
"<" {printf("LT\n"); currentPos += yyleng;}
">" {printf("GT\n"); currentPos += yyleng;}
"%" {printf("MOD\n"); currentPos += yyleng;}
"<=" {printf("LTE\n"); currentPos += yyleng;}
">=" {printf("GTE\n"); currentPos += yyleng;}
"(" {printf("L_PAREN\n"); currentPos += yyleng;}
")" {printf("R_PAREN\n"); currentPos += yyleng;}
";" {printf("SEMICOLON\n"); currentPos += yyleng;}
":" {printf("COLON\n"); currentPos += yyleng;}
"," {printf("COMMA\n"); currentPos += yyleng;}
"[" {printf("L_SQUARE_BRACKET\n"); currentPos += yyleng;}
"]" {printf("R_SQUARE_BRACKET\n"); currentPos += yyleng;}
":=" {printf("ASSIGN\n"); currentPos += yyleng;}

"##"[^\n]*	   {;}

(\.{DIGIT}+)|({DIGIT}+(\.{DIGIT}*)?([eE][+-]?[0-9]+)?)   {printf("NUMBER %s\n", yytext); currentPos += yyleng;}


[a-zA-Z][a-zA-Z0-9_]*[_] {printf("Error at line %d, column %d. Identifier \"%s\" cannot end with an underscore\n", currentLine, currentPos, yytext); exit(0);}
[a-zA-Z][a-zA-Z0-9_]*[a-zA-Z0-9]* {printf("IDENT %s\n", yytext);}

[0-9_][a-zA-Z0-9_]* {printf("Error at line %d, column %d. Identifier \"%s\" must begin with a letter\n", currentLine, currentPos, yytext); exit(0);}

[ \t]+ {/* ignore spaces */ currentPos += yyleng;}

"\n" {currentLine++; currentPos = 1;}

.   {printf("Error at line %d, column %d. Unrecognized symbol: \"%s\"\n", currentLine, currentPos, yytext); exit(0);}


%%

int main(int argc, char ** argv){
    if (argc >= 2){
        yyin = fopen(argv[1], "r");
        if (yyin == NULL){
            yyin = stdin;
        }
    }
    else{
        yyin = stdin;
    }
    yylex();
}
