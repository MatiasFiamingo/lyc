#ifndef _TABLA_SIMBOLOS_H_
#define _TABLA_SIMBOLOS_H_

typedef struct
{
    char nombre[100];
    char tipo[50];
    char valor[100];
    int longitud;

} simbolo;

int buscar_en_ts (simbolo tabla_simbolos[], int tope, char *nombre);
void insertar_id_en_ts (simbolo tabla_simbolos[], int *tope, char *id);
void insertar_cte_ent_en_ts (simbolo tabla_simbolos[], int *tope, char *cte_ent);
void insertar_cte_real_en_ts (simbolo tabla_simbolos[], int *tope, char *cte_real);
void insertar_cte_string_en_ts (simbolo tabla_simbolos[], int *tope, char *cte_string);
void mostrar_ts (simbolo tabla_simbolos[], int tope);
void guardar_ts (simbolo tabla_simbolos[], int tope);

#endif

