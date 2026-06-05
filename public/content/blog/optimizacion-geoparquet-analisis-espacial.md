# Optimizacion de GeoParquet para analisis espacial

GeoParquet permite almacenar geometria y atributos en un formato columnar eficiente. Para analisis espacial masivo, la ventaja no esta solo en el formato, sino en como se organiza el dato antes de consultarlo.

## Principios practicos

- Particionar por variables de consulta frecuente, como region, fecha o tipo de cobertura.
- Evitar archivos demasiado pequenos, porque aumentan la sobrecarga del lector distribuido.
- Mantener columnas geometricas limpias y validar CRS antes de exportar.
- Separar capas de alta cardinalidad cuando no siempre son necesarias.

## Flujo recomendado

Un flujo robusto empieza con control de calidad espacial, normalizacion de atributos, simplificacion cuando aplica y escritura particionada. Despues conviene medir tiempos de lectura, filtros y joins antes de definir el layout final.

## Criterio de exito

La optimizacion debe evaluarse con consultas reales. Un dataset bien particionado reduce lectura innecesaria y mejora el rendimiento de procesos en Python, PySpark y motores SQL compatibles.
