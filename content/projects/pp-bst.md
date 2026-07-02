# Ánalisis de la estructura espacial de un bosque seco tropical mediante patrones puntuales

## Resumen ejecutivo

Se analiza un patrón puntual marcado de un bosque seco tropical, el cual es generado a partir de la localización de los árboles dentro de una parcela de una hectárea ubicada en el parque nacional natural El Tuparro en la Orinoquia Colombiana. Utilizamos dos marcas cualitativas la especie y tamaño, y una marca cuantitativa el diámetro a la altura del pecho - dap. El objetivo del estudio fue analizar a un nivel de comunidad ecológica, la distribución espacial de las plantas mediante el patrón puntual marcado, para entender los procesos de competencia y facilitación que tienen una influencia en el patrón generado. Se propuso una metodología basada en diferentes herramientas provenientes de la teoría de procesos puntuales: primero se estimó la intensidad utilizando un kernel e incorporando la covariable distancia a las rocas; después utilizamos diferentes herramientas de segundo orden para analizar las intra e inter dependencias de cada una de las marcas; y finalmente usamos tres métodos para clasificar a las especies por su comportamiento espacial, uno basado en índices de dispersión y los otros dos con funciones de segundo orden. Los resultados muestran una influencia del suelo rocoso sobre la distribución espacial de las plantas dentro del área de estudio; las funciones de segundo orden indican un patrón de inhibición para todas las especies, y para algunas se identificó un patrón de agrupación a distancias cercanas; el tamaño de las plantas también influye en la distribución espacial, los árboles grandes y medianos tienden a formar pequeños patrones agregados con radios de 1.3 metros, mientras que las plantas pequeñas se agrupan más alrededor de plantas grandes que medianas; los tres tipos de información utilizados para el análisis de clasificación muestran similitudes en los grupos de especies formados, sin embargo, las funciones de segundo orden muestran mejores resultados de clasificación

## Problema

La preparacion de datos consumia demasiado tiempo y generaba inconsistencias entre ejecuciones locales.

## Datos utilizados


- Datos georreferenciados de las especies dentro de la parcela. 
- Información cualitativa nombre de la especie
- Información cuantitativa diametro a la altura del pecho de los arboles. 


![Distribución de los árboles](/portafolio/content/projects/assets/pp-bst/map.png)

## Metodologia

Se implementaron etapas de ingesta, normalizacion, deduplicacion, enriquecimiento espacial y exportacion a formatos analiticos.

| Etapa | Control | Resultado |
| --- | --- | --- |
| Ingesta | Volumenes esperados | Datos disponibles |
| Limpieza | Duplicados y nulos | Base confiable |
| Exportacion | Contratos de datos | Insumos modelables |

## Resultados

El pipeline redujo reprocesos, estandarizo reglas de negocio y dejo salidas listas para modelamiento y visualizacion.

## Lecciones aprendidas

La calidad del pipeline depende de pruebas simples, contratos de datos claros y monitoreo de volumenes.
