// Agrega, edita o elimina proyectos desde este arreglo para escalar el portafolio.
// El contenido largo de cada caso vive en public/content/projects.
const projects = [
  {
    slug: "front-end",
    title: "Visualización de proyectos",
    file: "front-end.md",
    summary:
      "Sistema estadistico para estimar capitalizacion agricola combinando informacion productiva, economica y territorial.",
    technologies: ["R", "SQL", "PostGIS", "QGIS", "Modelos estadisticos", "GIS"],
    featured: true,
  },
  {
    slug: "modelo-zonas-homogeneas-fisicas",
    title: "Modelo agrupación Zonas Homogéneas Físicas Catastrales",
    file: "modelo-zonas-homogeneas-fisicas.md",
    summary:
      "Sistema estadistico para estimar capitalizacion agricola combinando informacion productiva, economica y territorial.",
    technologies: ["R", "SQL", "PostGIS", "QGIS", "Modelos estadisticos", "GIS"],
    featured: true,
  },
  {
    slug: "pipeline-UC-spark",
    title: "Pipeline Spatk Unity Catalog",
    file: "pipeline-UC-spark.md",
    summary:
      "Sistema estadistico para estimar capitalizacion agricola combinando informacion productiva, economica y territorial.",
    technologies: ["R", "SQL", "PostGIS", "QGIS", "Modelos estadisticos", "GIS"],
    featured: true,
  },
  {
    slug: "modelo-capitalizacion-agricola",
    title: "Modelo de Capitalizacion de Renta Agropecuaria",
    file: "modelo-capitalizacion-agricola.md",
    summary:
      "Sistema estadistico para estimar capitalizacion agricola combinando informacion productiva, economica y territorial.",
    technologies: ["R", "SQL", "PostGIS", "QGIS", "Modelos estadisticos", "GIS"],
    featured: true,
  },
  {
    slug: "procesamiento-liquidacion-catastral",
    title: "Flujo de procesamiento para liquidación catastral",
    file: "procesamiento-liquidacion-catastral.md",
    summary:
      "Sistema estadistico para estimar capitalizacion agricola combinando informacion productiva, economica y territorial.",
    technologies: ["R", "SQL", "PostGIS", "QGIS", "Modelos estadisticos", "GIS"],
    featured: true,
  },
  {
    slug: "modelo-contabilidad-carbono",
    title: "Modelo de contabilidad de emisiones de carbono",
    file: "modelo-contabilidad-carbono.md",
    summary:
      "Sistema estadistico para estimar capitalizacion agricola combinando informacion productiva, economica y territorial.",
    technologies: ["R", "SQL", "PostGIS", "QGIS", "Modelos estadisticos", "GIS"],
    featured: true,
  },
  {
    slug: "mod-regionalizacion",
    title: "Modelo de regionalización",
    file: "mod-regionalizacion.md",
    summary:
      "Modelos predictivos para anticipar rendimientos usando informacion climatica, historica y espacial.",
    technologies: ["Python", "R", "Scikit-learn", "XGBoost", "Geoestadistica", "GIS"],
    featured: true,
  },
  {
    slug: "mod-optimizacion",
    title: "Modelo de optimización para la producción agropecuaria",
    file: "mod-optimizacion.md",
    summary:
      "Arquitectura para transformar y analizar grandes volumenes de datos espaciales con formatos columnares.",
    technologies: ["PySpark", "GeoParquet", "Python", "PostGIS", "SQL", "Big Data"],
    featured: true,
  },
  {
    slug: "prospectiva-agropecuaria",
    title: "Prospectiva agropecuaria",
    file: "prospectiva-agropecuaria.md",
    summary:
      "Aplicacion analitica en Shiny para explorar indicadores estadisticos y mapas interactivos.",
    technologies: ["R", "Shiny", "Leaflet", "ggplot2", "DT", "GIS"],
    featured: false,
  },
  {
    slug: "modelo-forestal",
    title: "Modelo de crecimiento y rendimiento forestal",
    file: "modelo-forestal.md",
    summary:
      "Pipeline de procesamiento distribuido para preparar datos analiticos desde fuentes masivas.",
    technologies: ["PySpark", "Python", "SQL", "Parquet", "Data Engineering", "Big Data"],
    featured: false,
  },
];

export default projects;
