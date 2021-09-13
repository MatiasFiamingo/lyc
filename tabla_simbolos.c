#include <stdio.h>
#include <stdlib.h>
#include "tabla_simbolos.h"
#include "string.h"

int buscar_en_ts (simbolo tabla_simbolos[], int tope, char *nombre)
{
    int i;
    
    for (i = 0; i < tope; i++)
    {
        if (strcmp (nombre, tabla_simbolos[i].nombre) == 0)
            return i;
    }

    return -1;
}

void insertar_id_en_ts (simbolo tabla_simbolos[], int *tope, char *id)
{
	char aux[100];
    strcpy (aux, "_");
    strcat (aux, id);
	
    if (buscar_en_ts (tabla_simbolos, *tope, aux) == -1)
    {
        strcpy (tabla_simbolos[(*tope)].nombre, aux);
        strcpy (tabla_simbolos[(*tope)].tipo, "id");
        tabla_simbolos[(*tope)].longitud = strlen (id);

        (*tope)++;
    }
}

void insertar_cte_ent_en_ts (simbolo tabla_simbolos[], int *tope, char *cte_ent)
{
    char aux[100];

    strcpy (aux, "_");
    strcat (aux, cte_ent);

    if (buscar_en_ts (tabla_simbolos, *tope, aux) == -1)
    {
        strcpy (tabla_simbolos[(*tope)].nombre, aux);
        strcpy (tabla_simbolos[(*tope)].tipo, "cte_ent");
        strcpy (tabla_simbolos[(*tope)].valor, cte_ent);

        (*tope)++;
    }   
}

void insertar_cte_real_en_ts (simbolo tabla_simbolos[], int *tope, char *cte_real)
{
    char aux[100];

    strcpy (aux, "_");
    strcat (aux, cte_real);

    if (buscar_en_ts (tabla_simbolos, *tope, aux) == -1)
    {
        strcpy (tabla_simbolos[(*tope)].nombre, aux);
        strcpy (tabla_simbolos[(*tope)].tipo, "cte_real");
        strcpy (tabla_simbolos[(*tope)].valor, cte_real);

        (*tope)++;
    }
}   

void insertar_cte_string_en_ts (simbolo tabla_simbolos[], int *tope, char *cte_string)
{
    char aux[100];

    strcpy (aux, "_");
    strcat (aux, cte_string);

    if (buscar_en_ts (tabla_simbolos, *tope, aux) == -1)
    {
        strcpy (tabla_simbolos[(*tope)].nombre, aux);
        strcpy (tabla_simbolos[(*tope)].tipo, "cte_string");
        strcpy (tabla_simbolos[(*tope)].valor, cte_string);
        tabla_simbolos[(*tope)].longitud = strlen (cte_string);

        (*tope)++;
    }   
}

void mostrar_ts (simbolo tabla_simbolos[], int tope)
{
    int i;

    printf ("Nro | Nombre | Tipo | Valor | Longitud\n");
    for (i = 0; i < tope; i++)
    {
      printf ("%d | %s | %s | %s | %d\n", i, tabla_simbolos[i].nombre, tabla_simbolos[i].tipo, tabla_simbolos[i].valor, tabla_simbolos[i].longitud);
    }
}

void guardar_ts (simbolo tabla_simbolos[], int tope)
{
    int i;
    FILE *archivo = fopen ("ts.txt", "w");

    if (archivo == NULL)
    {
        printf ("Error al crear archivo de tabla de simbolos\n");
        exit (1);
    }

    fprintf (archivo, "Nro | Nombre | Tipo | Valor | Longitud\n");
    for (i = 0; i < tope; i++)
    {
      fprintf (archivo, "%d | %s | %s | %s | %d\n", i, tabla_simbolos[i].nombre, tabla_simbolos[i].tipo, tabla_simbolos[i].valor, tabla_simbolos[i].longitud);
    }

    fclose (archivo);
}