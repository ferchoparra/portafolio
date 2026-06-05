// Agrega, edita o elimina proyectos desde este arreglo para escalar el portafolio.
const projects = [
  {
    slug: "modelo-capitalizacion-agricola",
    title: "Modelo de Capitalizacion Agricola",
    summary:
      "Sistema estadistico para estimar capitalizacion agricola combinando informacion productiva, economica y territorial.",
    problem:
      "La evaluacion de capitalizacion agricola requeria integrar fuentes heterogeneas y reducir sesgos de estimacion entre regiones con condiciones productivas distintas.",
    data:
      "Registros administrativos, series de produccion agricola, precios historicos, variables climaticas, coberturas de suelo y capas espaciales municipales.",
    methodology:
      "Se construyeron modelos estadisticos jerarquicos y validaciones por estratos territoriales, con controles de calidad, imputacion robusta y analisis de sensibilidad.",
    technologies: ["R", "SQL", "PostGIS", "QGIS", "Modelos estadisticos", "GIS"],
    results:
      "Se obtuvo una metodologia reproducible para estimar indicadores de capitalizacion y comparar escenarios por territorio, cultivo y periodo.",
    lessons:
      "La trazabilidad de supuestos y la validacion territorial son tan importantes como la metrica global del modelo.",
    featured: true,
  },
  {
    slug: "prediccion-rendimientos-agricolas",
    title: "Prediccion de Rendimientos Agricolas",
    summary:
      "Modelos predictivos para anticipar rendimientos usando informacion climatica, historica y espacial.",
    problem:
      "Los rendimientos agricolas presentan autocorrelacion espacial y alta variabilidad temporal, lo que limita enfoques predictivos tradicionales.",
    data:
      "Series historicas de rendimiento, indices climaticos, suelos, altitud, pendientes, distancia a infraestructura y variables de manejo.",
    methodology:
      "Se compararon modelos lineales, random forest, gradient boosting y validacion cruzada espacial para medir generalizacion fuera de la zona de entrenamiento.",
    technologies: ["Python", "R", "Scikit-learn", "XGBoost", "Geoestadistica", "GIS"],
    results:
      "El flujo permitio identificar variables dominantes y estimar incertidumbre predictiva por zona agroecologica.",
    lessons:
      "La validacion aleatoria puede sobrestimar desempeno cuando existen patrones espaciales fuertes.",
    featured: true,
  },
  {
    slug: "procesamiento-geoespacial-masivo",
    title: "Procesamiento Geoespacial Masivo",
    summary:
      "Arquitectura para transformar y analizar grandes volumenes de datos espaciales con formatos columnares.",
    problem:
      "Los procesos espaciales en escritorio no escalaban para millones de geometrias y multiples cruces territoriales.",
    data:
      "Geometrias administrativas, grillas espaciales, puntos de observacion, sensores remotos derivados y tablas de atributos.",
    methodology:
      "Se particionaron datos con GeoParquet, se optimizaron joins espaciales y se diseno un flujo distribuido con controles de calidad por lote.",
    technologies: ["PySpark", "GeoParquet", "Python", "PostGIS", "SQL", "Big Data"],
    results:
      "El procesamiento paso de ejecuciones manuales extensas a pipelines repetibles con menor tiempo de ejecucion y mejor trazabilidad.",
    lessons:
      "El formato fisico de los datos y la estrategia de particionamiento definen gran parte del rendimiento.",
    featured: true,
  },
  {
    slug: "dashboard-shiny",
    title: "Dashboard Shiny",
    summary:
      "Aplicacion analitica en Shiny para explorar indicadores estadisticos y mapas interactivos.",
    problem:
      "Los equipos tecnicos necesitaban consultar indicadores, filtros y mapas sin depender de notebooks o consultas manuales.",
    data:
      "Indicadores agregados, tablas de seguimiento, capas espaciales simplificadas y resultados de modelos.",
    methodology:
      "Se diseno una interfaz modular con filtros reactivos, visualizaciones comparativas y mapas para lectura territorial.",
    technologies: ["R", "Shiny", "Leaflet", "ggplot2", "DT", "GIS"],
    results:
      "La herramienta facilito exploracion de datos, comunicacion de hallazgos y revision de resultados por actores no tecnicos.",
    lessons:
      "Un dashboard util no solo muestra graficas: debe responder preguntas operativas concretas.",
    featured: false,
  },
  {
    slug: "pipeline-pyspark",
    title: "Pipeline PySpark",
    summary:
      "Pipeline de procesamiento distribuido para preparar datos analiticos desde fuentes masivas.",
    problem:
      "La preparacion de datos consumia demasiado tiempo y generaba inconsistencias entre ejecuciones locales.",
    data:
      "Archivos particionados, tablas SQL, datos georreferenciados, logs de proceso y catalogos maestros.",
    methodology:
      "Se implementaron etapas de ingesta, normalizacion, deduplicacion, enriquecimiento espacial y exportacion a formatos analiticos.",
    technologies: ["PySpark", "Python", "SQL", "Parquet", "Data Engineering", "Big Data"],
    results:
      "El pipeline redujo reprocesos, estandarizo reglas de negocio y dejo salidas listas para modelamiento y visualizacion.",
    lessons:
      "La calidad del pipeline depende de pruebas simples, contratos de datos claros y monitoreo de volumenes.",
    featured: false,
  },
];

export default projects;
