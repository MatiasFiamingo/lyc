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
":="			return ASIG;
","				return COMA;
"("				return PAR_A;
")"				return PAR_C;
"["				return COR_A;
"]"				return COR_C;
"+"				return OP_SUM;
"-"				return OP_RES;
"*"				return OP_MUL;
"/"				return OP_DIV;
"<"				return COMP_MEN;
">"				return COMP_MAY;
"<="			return COMP_MEN_IGL;
">="			return COMP_MAY_IGL;
"WHILE"			return WHILE;
"IN"			return IN;
"DO"			return DO;
"ENDWHILE"		return ENDWHILE;
"IF"			return IF;
"ENDIF"			return ENDIF;
"DISPLAY"		return DISPLAY;
"GET"			return GET;
"AND"			return OP_AND;
"OR"			return OP_OR;
"NOT"			return NOT;
"DIM"			return DIM;
"AS"			return AS;
"integer"		return VAR_INT;
"real"			return VAR_REAL;
"string"		return VAR_STR;
"FOR"			return FOR;
"="				return IGUAL;
"TO"			return TO;
"Step"			return STEP;
"NEXT"			return NEXT;
{ID}        	{ 	
					if(strlen (yytext) > 64)
					{
						printf ("Error lexico en linea %d. La longitud del identificador debe ser a lo sumo 64 caracteres.\n", yylineno);
                        exit (1);
					}
					else
					{
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
						return CONST_STR;
					}
				}
{COMENTARIO}
"\n"
"\t"
"\n\t"
"\r\n"
" "
.			yyerror();
%%
