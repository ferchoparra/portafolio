# Modelo de optimizacion para la produccion agropecuaria

## Resumen ejecutivo

Arquitectura para transformar y analizar grandes volumenes de datos espaciales con formatos columnares.

## Problema

Los procesos espaciales en escritorio no escalaban para millones de geometrias y multiples cruces territoriales.

## Datos utilizados

- Geometrias administrativas
- Grillas espaciales
- Puntos de observacion
- Sensores remotos derivados
- Tablas de atributos

## Metodologia

Se particionaron datos con GeoParquet, se optimizaron joins espaciales y se diseno un flujo distribuido con controles de calidad por lote.

| Decision | Implementacion | Beneficio |
| --- | --- | --- |
| Formato columnar | GeoParquet | Lecturas selectivas |
| Particionamiento | Variables de consulta | Menor costo de proceso |
| Pipeline | PySpark | Repetibilidad |

## Resultados

El procesamiento paso de ejecuciones manuales extensas a pipelines repetibles con menor tiempo de ejecucion y mejor trazabilidad.

## Lecciones aprendidas

El formato fisico de los datos y la estrategia de particionamiento definen gran parte del rendimiento.
