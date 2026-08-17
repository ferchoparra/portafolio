# Validación cruzada espacial en modelos predictivos

Cuando los datos tienen autocorrelación espacial, una validación aleatoria puede mezclar observaciones cercanas entre entrenamiento y prueba. El resultado suele ser una estimación optimista del desempeño.

## Por qué importa

En problemas agrícolas, ambientales o territoriales, el modelo debe generalizar a zonas no observadas. Si la evaluación no respeta esa estructura, las métricas pueden parecer fuertes aunque el modelo falle en nuevos territorios.

## Estrategias comunes

- Bloques espaciales para separar entrenamiento y prueba por zonas.
- Leave-one-region-out cuando existen unidades administrativas claras.
- Buffers de exclusión para reducir contaminación por cercanía.
- Comparación entre validación aleatoria y espacial para medir sesgo de evaluación.

## Lectura técnica

La pregunta central no es solo cuánto error tiene el modelo, sino dónde se equivoca. Mapear residuales y revisar patrones espaciales ayuda a detectar sesgos no visibles en una métrica agregada.
