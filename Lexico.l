%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
#include "tabla_simbolos.h"

simbolo tabla_simbolos[1000];
int tope = 0;
%}

%option noyywrap
%option yylineno

DIGITO		[0-9]
LETRA		[a-zA-Z]
CONST_REAL 	-?({DIGITO}+"."{DIGITO}+|"."{DIGITO}+|{DIGITO}+".")
CONST_INT 	-?{DIGITO}+
CONST_STR	\"(\\.|[^\"])*\"
ID			{LETRA}({LETRA}|{DIGITO}|_)*
COMENTARIO	\*\/.*\/\*

%%
":="			{ printf("ASIG: %s\n", yytext); return ASIG; }
","				{ printf("COMA: %s\n", yytext); return COMA; }
"("				{ printf("PAR_A: %s\n", yytext); return PAR_A; }
")"				{ printf("PAR_C: %s\n", yytext); return PAR_C; }
"["				{ printf("COR_A: %s\n", yytext); return COR_A; }
"]"				{ printf("COR_C: %s\n", yytext); return COR_C; }
"+"				{ printf("OP_SUM: %s\n", yytext); return OP_SUM; }
"-"				{ printf("OP_RES: %s\n", yytext); return OP_RES; }
"*"				{ printf("OP_MUL: %s\n", yytext); return OP_MUL; }
"/"				{ printf("OP_DIV: %s\n", yytext); return OP_DIV; }
"<"				{ printf("COMP_MEN: %s\n", yytext); return COMP_MEN; }
">"				{ printf("COMP_MAY: %s\n", yytext); return COMP_MAY; }
"<="			{ printf("COMP_MEN_IGL: %s\n", yytext); return COMP_MEN_IGL; }
">="			{ printf("COMP_MAY_IGL: %s\n", yytext); return COMP_MAY_IGL; }
"WHILE"			{ printf("WHILE: %s\n", yytext); return WHILE; }
"IN"			{ printf("IN: %s\n", yytext); return IN; }
"DO"			{ printf("DO: %s\n", yytext); return DO; }
"ENDWHILE"		{ printf("ENDWHILE: %s\n", yytext); return ENDWHILE; }
"IF"			{ printf("IF: %s\n", yytext); return IF; }
"ENDIF"			{ printf("ENDIF: %s\n", yytext); return ENDIF; }
"DISPLAY"		{ printf("DISPLAY: %s\n", yytext); return DISPLAY; }
"GET"			{ printf("GET: %s\n", yytext); return GET; }
"AND"			{ printf("OP_AND: %s\n", yytext); return OP_AND; }
"OR"			{ printf("OP_OR: %s\n", yytext); return OP_OR; }
"NOT"			{ printf("NOT: %s\n", yytext); return NOT; }
"DIM"			{ printf("DIM: %s\n", yytext); return DIM; }
"AS"			{ printf("OP_AS: %s\n", yytext); return AS; }
"integer"		{ printf("VAR_INT: %s\n", yytext); return VAR_INT; }
"real"			{ printf("VAR_REAL: %s\n", yytext); return VAR_REAL; }
"string"		{ printf("VAR_STR: %s\n", yytext); return VAR_STR; }
"FOR"			{ printf("FOR: %s\n", yytext); return FOR; }
"="				{ printf("IGUAL: %s\n", yytext); return IGUAL; }
"TO"			{ printf("TO: %s\n", yytext); return TO; }
"Step"			{ printf("STEP: %s\n", yytext); return STEP; }
"NEXT"			{ printf("NEXT: %s\n", yytext); return NEXT; }
{ID}        	{ 	
					if(strlen (yytext) > 64)
					{
						printf ("Error lexico en linea %d. La longitud del identificador debe ser a lo sumo 64 caracteres.\n", yylineno);
                        exit (1);
					}
					else
					{
					printf("ID: %s\n", yytext);
					insertar_id_en_ts(tabla_simbolos, &tope, yytext);
					return ID; }
					}
{CONST_INT}		{
					if (atoi (yytext) < -32768 || atoi (yytext) > 32767)
                    {			                  
						printf ("Error lexico en linea %d. Constante entera fuera de rango.\n", yylineno);
                        exit (1);
					}
					else
					{
						insertar_cte_ent_en_ts(tabla_simbolos, &tope, yytext);
						printf("CONST_INT: %s\n", yytext);
						return CONST_INT;
					}
				}
{CONST_REAL}	{ 
					if (atof (yytext) < -3.4E+38 || atof (yytext) > 3.4E+38)
					{
						printf ("Error lexico en linea %d. Constante real fuera de rango.\n", yylineno);
                        exit (1);
					}
					else
					{
						insertar_cte_real_en_ts (tabla_simbolos, &tope, yytext);
						printf("CONST_REAL: %s\n", yytext);
						return CONST_REAL;
					}
				}
{CONST_STR}		{ 
					if (strlen (yytext) > 32)
                    {
                        printf ("Error lexico en linea %d. La cantidad de caracteres del string debe ser menor o igual a 30.\n", yylineno);
						exit(1);
					}
					else
					{
						insertar_cte_string_en_ts(tabla_simbolos, &tope, yytext);
						printf("CONST_STR: %s\n", yytext);
						return CONST_STR;
					}
				}
{COMENTARIO}	{ printf("COMENTARIO: %s\n", yytext); }
"\n"
"\t"
"\n\t"
"\r\n"
" "
.			yyerror();
%%