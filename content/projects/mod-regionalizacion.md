# Modelo de regionalizacion

## Resumen ejecutivo

Modelos predictivos para anticipar rendimientos usando informacion climatica, historica y espacial.

## Problema

Los rendimientos agricolas presentan autocorrelacion espacial y alta variabilidad temporal, lo que limita enfoques predictivos tradicionales.

## Datos utilizados

- Series historicas de rendimiento
- Indices climaticos
- Suelos
- Altitud
- Pendientes
- Distancia a infraestructura
- Variables de manejo

## Metodologia

Se compararon modelos lineales, random forest, gradient boosting y validacion cruzada espacial para medir generalizacion fuera de la zona de entrenamiento.

| Modelo | Ventaja | Riesgo controlado |
| --- | --- | --- |
| Lineal | Interpretabilidad | Sesgo por no linealidad |
| Random forest | Relaciones no lineales | Sobreajuste espacial |
| XGBoost | Desempeno predictivo | Validacion territorial |

## Resultados

El flujo permitio identificar variables dominantes y estimar incertidumbre predictiva por zona agroecologica.

## Lecciones aprendidas

La validacion aleatoria puede sobrestimar desempeno cuando existen patrones espaciales fuertes.
