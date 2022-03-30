%{
    int currentLine = 1, currentPos = 1;
    int numInt = 0, numOp = 0, numPara = 0, numEq = 0;
%}

DIGIT [0-9]

%%

"+" {printf("PLUS\n"); currentPos += yyleng; numOp++;}
"-" {printf("MINUS\n"); currentPos += yyleng; numOp++;}
"*" {printf("MULT\n"); currentPos += yyleng; numOp++;}
"/" {printf("DIV\n"); currentPos += yyleng; numOp++;}
"(" {printf("L_PAREN\n"); currentPos += yyleng; numPara++;}
")" {printf("R_PAREN\n"); currentPos += yyleng; numPara++;}
"=" {printf("EQUAL\n"); currentPos += yyleng; numEq++;}

{DIGIT}+ {printf("NUMBER %s\n", yytext); currentPos += yyleng; numInt++;}

[ \t]+ {/* ignore spaces */ currentPos += yyleng;}

"\n" {currentLine++; currentPos = 1;}

.   {printf("Error at line %d, column %d", currentLine, currentPos);}

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
    printf("# Integers: %d\n", numInt);
    printf("# Operators: %d\n", numOp);
    printf("# Parantheses: %d\n", numPara);
    printf("# Equal Signs: %d\n", numEq);
}