# Optimización de GeoParquet para análisis espacial

GeoParquet permite almacenar geometría y atributos en un formato columnar eficiente. Para análisis espacial masivo, la ventaja no está solo en el formato, sino en cómo se organiza el dato antes de consultarlo.

## Principios prácticos

- Particionar por variables de consulta frecuente, como región, fecha o tipo de cobertura.
- Evitar archivos demasiado pequeños, porque aumentan la sobrecarga del lector distribuido.
- Mantener columnas geométricas limpias y validar CRS antes de exportar.
- Separar capas de alta cardinalidad cuando no siempre son necesarias.

## Flujo recomendado

Un flujo robusto empieza con control de calidad espacial, normalización de atributos, simplificación cuando aplica y escritura particionada. Después conviene medir tiempos de lectura, filtros y joins antes de definir el layout final.

## Criterio de éxito

La optimización debe evaluarse con consultas reales. Un dataset bien particionado reduce lectura innecesaria y mejora el rendimiento de procesos en Python, PySpark y motores SQL compatibles.
