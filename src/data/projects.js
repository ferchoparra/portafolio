// Agrega, edita o elimina proyectos desde este arreglo para escalar el portafolio.
// El contenido largo de cada caso vive en public/content/projects.
// Controles:
// - published: false oculta el proyecto en todo el sitio.
// - featured: true lo muestra también en la sección destacada del Home.
const projects = [
  {
    slug: "front-end",
    title: "Visualización de proyectos",
    file: "front-end.md",
    summary:
      "Visualización de proyectos analíticos mediante interfaces web y componentes reutilizables.",
    technologies: ["R", "SQL", "PostGIS", "QGIS", "Modelos estadísticos", "GIS"],
    featured: true,
    published: false,
  },
  {
    slug: "modelo-zonas-homogeneas-fisicas",
    title: "Modelo de Zonas Homogéneas Físicas Catastrales",
    file: "modelo-zonas-homogeneas-fisicas.md",
    summary:
      "Diseño e implementación de una metodología basada en teoría de grafos para la agrupación de zonas homogéneas físicas en procesos de actualización catastral.",
    technologies: ["R", "Teoría de grafos", "Procedimiento SKATER"],
    featured: true,
    published: true,
  },
  {
    slug: "pipeline-UC-spark",
    title: "Pipeline Spark Unity Catalog",
    file: "pipeline-UC-spark.md",
    summary:
      "Pipeline de procesamiento para preparar datos analíticos desde fuentes masivas e implementar un modelo de capitalización de renta agropecuaria.",
    // Arquitectura para transformar y analizar grandes volúmenes de datos espaciales con formatos columnares.
    technologies: ["R", "Python", "Unity Catalog", "Spark", "MLflow"],
    featured: true,
    published: false,
  },
  {
    slug: "modelo-capitalizacion-agricola",
    title: "Modelo de Capitalización de Renta Agropecuaria",
    file: "modelo-capitalizacion-agricola.md",
    summary:
      "Modelo masivo de capitalización de renta agropecuaria para estimar valores comerciales de terreno por hectárea en 648 municipios, integrando EVA, AHT, aptitud, costos, precios, transporte y zonas geoeconómicas.",
    technologies: ["R", "QGIS", "GIS", "Capitalización de renta", "GLMM", "Power BI"],
    featured: true,
    published: true,
  },
  {
    slug: "procesamiento-liquidacion-catastral",
    title: "Flujo de procesamiento para liquidación catastral",
    file: "procesamiento-liquidacion-catastral.md",
    summary:
      "Pipeline para procesamiento de información e implementación de liquidación para procesos de actualización catastral.",
    technologies: ["R", "Google Colab"],
    featured: true,
    published: false,
  },
  {
    slug: "modelo-contabilidad-carbono",
    title: "Modelo de contabilidad de emisiones de carbono",
    file: "modelo-contabilidad-carbono.md",
    summary:
      "Pipeline en R para estimar emisiones, absorciones y escenarios de mitigación AFOLU integrando FAOSTAT, NIR/BUR, NDC, uso del suelo y demanda agropecuaria.",
    technologies: ["R", "AFOLU", "FAOSTAT", "NDC", "BUR-Colombia", "Simulación"],
    featured: true,
    published: true,
  },
  {
    slug: "bst-patrones-puntuales",
    title: "Análisis espacial de un bosque seco tropical con procesos puntuales",
    file: "pp-bst.md",
    summary:
      "Tesis de maestría en Estadística aplicada al análisis de 1274 plantas en una parcela de bosque seco tropical mediante procesos puntuales marcados, funciones de segundo orden y clasificación funcional.",
    technologies: ["R", "Estadística espacial", "Procesos puntuales", "FPCA", "Ecología cuantitativa"],
    featured: true,
    published: true,
  },
  {
    slug: "mod-regionalizacion",
    title: "Modelo de regionalización",
    file: "mod-regionalizacion.md",
    summary:
      "Metodología para regionalizar cadenas agropecuarias mediante clustering no espacial, matriz de vecindad, SKATER y ajuste experto.",
    technologies: ["R", "sf", "spdep", "bigDM", "SKATER", "Estadística espacial"],
    featured: true,
    published: true,
  },
  {
    slug: "mod-optimizacion",
    title: "Modelo de optimización para la producción agropecuaria",
    file: "mod-optimizacion.md",
    summary:
      "Modelos de optimización de la producción para diferentes sistemas agropecuarios bajo escenarios prospectivos.",
    technologies: ["R", "GAMS", "QGIS", "Programación lineal"],
    featured: true,
    published: false,
  },
  {
    slug: "prospectiva-agropecuaria",
    title: "Prospectiva agropecuaria",
    file: "prospectiva-agropecuaria.md",
    summary:
      "Sistema de modelación económica para apoyar la prospectiva de cadenas agropecuarias en POP mediante proyecciones, equilibrio parcial y optimización regional.",
    technologies: ["R", "GAMS", "Equilibrio parcial", "Optimización regional", "Prospectiva cuantitativa"],
    featured: false,
    published: false,
  },
  {
    slug: "modelo-forestal",
    title: "Modelo de crecimiento y rendimiento forestal",
    file: "modelo-forestal.md",
    summary:
      "Herramienta de simulación en R para estimar crecimiento, rendimiento y volumen disponible de plantaciones forestales comerciales en Colombia.",
    technologies: ["R", "Weibull", "Modelos de ahusamiento", "Simulación forestal"],
    featured: true,
    published: true,
  },
];

export const isProjectPublished = (project) => project.published !== false;

export const publishedProjects = projects.filter(isProjectPublished);

export const featuredProjects = publishedProjects.filter((project) => project.featured);

export default projects;
