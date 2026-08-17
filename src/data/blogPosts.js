// Cada artículo apunta a un archivo Markdown servido desde public/content/blog.
const blogPosts = [
  {
    slug: "optimizacion-geoparquet-analisis-espacial",
    title: "Optimización de GeoParquet para análisis espacial",
    excerpt:
      "Buenas prácticas para particionar, comprimir y consultar datos espaciales columnares en flujos analíticos.",
    date: "2026-06-01",
    readTime: "7 min",
    tags: ["GeoParquet", "GIS", "Big Data"],
    file: "optimizacion-geoparquet-analisis-espacial.md",
  },
  {
    slug: "validacion-cruzada-espacial-modelos-predictivos",
    title: "Validación cruzada espacial en modelos predictivos",
    excerpt:
      "Por qué la validación aleatoria puede ser optimista en datos espaciales y cómo evaluar generalización territorial.",
    date: "2026-06-02",
    readTime: "8 min",
    tags: ["Geoestadística", "Machine Learning", "Validación"],
    file: "validacion-cruzada-espacial-modelos-predictivos.md",
  },
  {
    slug: "introduccion-pyspark-procesamiento-geoespacial",
    title: "Introducción a PySpark para procesamiento geoespacial",
    excerpt:
      "Conceptos clave para llevar procesos geoespaciales desde scripts locales hacia pipelines distribuidos.",
    date: "2026-06-03",
    readTime: "6 min",
    tags: ["PySpark", "Geospatial", "Data Engineering"],
    file: "introduccion-pyspark-procesamiento-geoespacial.md",
  },
];

export default blogPosts;
