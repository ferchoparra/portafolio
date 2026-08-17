# Modelo de regionalizacion

## Resumen ejecutivo

Modelos predictivos para anticipar rendimientos usando información climática, histórica y espacial.

## Problema

Los rendimientos agrícolas presentan autocorrelación espacial y alta variabilidad temporal, lo que limita enfoques predictivos tradicionales.

## Datos utilizados

- Series históricas de rendimiento
- Índices climáticos
- Suelos
- Altitud
- Pendientes
- Distancia a infraestructura
- Variables de manejo

## Metodología

Se compararon modelos lineales, random forest, gradient boosting y validación cruzada espacial para medir generalizacion fuera de la zona de entrenamiento.

| Modelo | Ventaja | Riesgo controlado |
| --- | --- | --- |
| Lineal | Interpretabilidad | Sesgo por no linealidad |
| Random forest | Relaciones no lineales | Sobreajuste espacial |
| XGBoost | Desempeno predictivo | Validacion territorial |

## Resultados

El flujo permitió identificar variables dominantes y estimar incertidumbre predictiva por zona agroecológica.

## Lecciones aprendidas

La validación aleatoria puede sobrestimar desempeño cuando existen patrones espaciales fuertes.
