# Pipeline Spatk Unity Catalog

## Resumen ejecutivo

Sistema estadistico para estimar capitalizacion agricola combinando informacion productiva, economica y territorial.

## Problema

La evaluacion de capitalizacion agricola requeria integrar fuentes heterogeneas y reducir sesgos de estimacion entre regiones con condiciones productivas distintas.

## Datos utilizados

- Registros administrativos
- Series de produccion agricola
- Precios historicos
- Variables climaticas
- Coberturas de suelo
- Capas espaciales municipales

## Metodologia

Se construyeron modelos estadisticos jerarquicos y validaciones por estratos territoriales, con controles de calidad, imputacion robusta y analisis de sensibilidad.

| Etapa | Herramienta | Control |
| --- | --- | --- |
| Ingesta | PySpark | Esquemas esperados |
| Gobierno | Unity Catalog | Permisos y linaje |
| Publicacion | Tablas analiticas | Calidad por lote |

## Resultados

Se obtuvo una metodologia reproducible para estimar indicadores de capitalizacion y comparar escenarios por territorio, cultivo y periodo.

## Lecciones aprendidas

La trazabilidad de supuestos y la validacion territorial son tan importantes como la metrica global del modelo.
