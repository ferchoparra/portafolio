// Agrega, edita o elimina proyectos desde este arreglo para escalar el portafolio.
// El contenido largo de cada caso vive en public/content/projects.
const projects = [
  {
    slug: "front-end",
    title: "Visualización de proyectos",
    file: "front-end.md",
    summary:
      "Visualización de di",
    technologies: ["R", "SQL", "PostGIS", "QGIS", "Modelos estadisticos", "GIS"],
    featured: true,
  },
  {
    slug: "modelo-zonas-homogeneas-fisicas",
    title: "Modelo Zonas Homogéneas Físicas Catastrales",
    file: "modelo-zonas-homogeneas-fisicas.md",
    summary:
      "Diseño e implementación de una metodología basada en teoría de grafos para la agrupación de zonas homogéneas físicas de los procesos de actualización catastral.",
    technologies: ["R", "Teoría de grafos", "Procedimiento SKATER"],
    featured: true,
  },
  {
    slug: "pipeline-UC-spark",
    title: "Pipeline Spatk Unity Catalog",
    file: "pipeline-UC-spark.md",
    summary:
      "Pipeline de procesamiento para preparar datos analiticos desde fuentes masivas para la implementar un modelo de capitalización de renta agropecuaria.",
    // Arquitectura para transformar y analizar grandes volumenes de datos espaciales con formatos columnares.
    technologies: ["R", "Python", "Unity Catalog", "Spark", "MLflow"],
    featured: true,
  },
  {
    slug: "modelo-capitalizacion-agricola",
    title: "Modelo de Capitalizacion de Renta Agropecuaria",
    file: "modelo-capitalizacion-agricola.md",
    summary:
      "Diseño e implementación de un modelo de capitalización de renta agropecuaria como insumo para generar avalúos catastrales de manera masiva.",
    technologies: ["R", "QGIS", "Modelos estadisticos", "Series de tiempo"],
    featured: true,
  },
  {
    slug: "procesamiento-liquidacion-catastral",
    title: "Flujo de procesamiento para liquidación catastral",
    file: "procesamiento-liquidacion-catastral.md",
    summary:
      "Pipeline para procesamiento de información e implementación de liquidación para procesos de actualización catastral.",
    technologies: ["R", "Google Colab"],
    featured: true,
  },
  {
    slug: "modelo-contabilidad-carbono",
    title: "Modelo de contabilidad de emisiones de carbono",
    file: "modelo-contabilidad-carbono.md",
    summary:
      "Pipeline en R para estimar emisiones, absorciones y escenarios de mitigacion AFOLU integrando FAOSTAT, NIR/BUR, NDC, uso del suelo y demanda agropecuaria.",
    technologies: ["R", "AFOLU", "FAOSTAT", "NDC", "BUR-Colombia", "Simulacion"],
    featured: true,
  },
  {
    slug: "bst-patrones-puntuales",
    title: "Analisis espacial de un bosque seco tropical con procesos puntuales",
    file: "pp-bst.md",
    summary:
      "Tesis de maestria en Estadistica aplicada al analisis de 1274 plantas en una parcela de bosque seco tropical mediante procesos puntuales marcados, funciones de segundo orden y clasificacion funcional.",
    technologies: ["R", "Estadistica espacial", "Procesos puntuales", "FPCA", "Ecologia cuantitativa"],
    featured: true,
  },
  {
    slug: "mod-regionalizacion",
    title: "Modelo de regionalización",
    file: "mod-regionalizacion.md",
    summary:
      "Modelo de clasificación a partir de herramientas de téoria de grafos, basado en información de cadenas agropecuarias.",
    technologies: ["R", "QGIS", "Teoría de grafos", "Procedimiento SKATER"],
    featured: true,
  },
  {
    slug: "mod-optimizacion",
    title: "Modelo de optimización para la producción agropecuaria",
    file: "mod-optimizacion.md",
    summary:
      "Modelos de optimización de la producción para diferentes sistemas agropecurios bajo escenarios prospectivos",
    technologies: ["R", "GAMS", "QGIS", "programación lineal"],
    featured: true,
  },
  {
    slug: "prospectiva-agropecuaria",
    title: "Prospectiva agropecuaria",
    file: "prospectiva-agropecuaria.md",
    summary:
      "Sistema de modelación para cadenas agropecuarias: proyecciones económicas, modelo de equilibrio parcial y modelo de optimización. Con enfoque en prospectiva cuantitativa. ",
    technologies: ["R", "GAMS", "series de tiempo", "modelos de optimización", "prospectiva cuantitativa"],
    featured: false,
  },
  {
    slug: "modelo-forestal",
    title: "Modelo de crecimiento y rendimiento forestal",
    file: "modelo-forestal.md",
    summary:
      "Herramienta de simulacion en R para estimar crecimiento, rendimiento y volumen disponible de plantaciones forestales comerciales en Colombia.",
    technologies: ["R", "Weibull", "modelos de ahusamiento", "simulacion forestal"],
    featured: false,
  },
];

export default projects;
