# Flujo de procesamiento para liquidacion catastral

## Resumen ejecutivo

Sistema estadístico para estimar capitalización agrícola combinando información productiva, económica y territorial.

## Problema

La evaluación de capitalización agrícola requería integrar fuentes heterogéneas y reducir sesgos de estimación entre regiones con condiciones productivas distintas.

## Datos utilizados

- Registros administrativos
- Series de producción agrícola
- Precios históricos
- Variables climáticas
- Coberturas de suelo
- Capas espaciales municipales

## Metodología

Se construyeron modelos estadísticos jerárquicos y validaciones por estratos territoriales, con controles de calidad, imputación robusta y análisis de sensibilidad.

| Proceso | Entrada | Salida |
| --- | --- | --- |
| Normalización | Tablas catastrales | Campos estandar |
| Validacion | Reglas de negocio | Alertas y reportes |
| Liquidacion | Base depurada | Resultados trazables |

## Resultados

Se obtuvo una metodología reproducible para estimar indicadores de capitalización y comparar escenarios por territorio, cultivo y período.

## Lecciones aprendidas

La trazabilidad de supuestos y la validación territorial son tan importantes como la métrica global del modelo.
