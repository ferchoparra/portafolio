# Validacion cruzada espacial en modelos predictivos

Cuando los datos tienen autocorrelacion espacial, una validacion aleatoria puede mezclar observaciones cercanas entre entrenamiento y prueba. El resultado suele ser una estimacion optimista del desempeno.

## Por que importa

En problemas agricolas, ambientales o territoriales, el modelo debe generalizar a zonas no observadas. Si la evaluacion no respeta esa estructura, las metricas pueden parecer fuertes aunque el modelo falle en nuevos territorios.

## Estrategias comunes

- Bloques espaciales para separar entrenamiento y prueba por zonas.
- Leave-one-region-out cuando existen unidades administrativas claras.
- Buffers de exclusion para reducir contaminacion por cercania.
- Comparacion entre validacion aleatoria y espacial para medir sesgo de evaluacion.

## Lectura tecnica

La pregunta central no es solo cuanto error tiene el modelo, sino donde se equivoca. Mapear residuales y revisar patrones espaciales ayuda a detectar sesgos no visibles en una metrica agregada.
