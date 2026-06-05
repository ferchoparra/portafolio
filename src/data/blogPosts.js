// Cada articulo apunta a un archivo Markdown servido desde public/content/blog.
const blogPosts = [
  {
    slug: "optimizacion-geoparquet-analisis-espacial",
    title: "Optimizacion de GeoParquet para analisis espacial",
    excerpt:
      "Buenas practicas para particionar, comprimir y consultar datos espaciales columnares en flujos analiticos.",
    date: "2026-06-01",
    readTime: "7 min",
    tags: ["GeoParquet", "GIS", "Big Data"],
    file: "optimizacion-geoparquet-analisis-espacial.md",
  },
  {
    slug: "validacion-cruzada-espacial-modelos-predictivos",
    title: "Validacion cruzada espacial en modelos predictivos",
    excerpt:
      "Por que la validacion aleatoria puede ser optimista en datos espaciales y como evaluar generalizacion territorial.",
    date: "2026-06-02",
    readTime: "8 min",
    tags: ["Geoestadistica", "Machine Learning", "Validacion"],
    file: "validacion-cruzada-espacial-modelos-predictivos.md",
  },
  {
    slug: "introduccion-pyspark-procesamiento-geoespacial",
    title: "Introduccion a PySpark para procesamiento geoespacial",
    excerpt:
      "Conceptos clave para llevar procesos geoespaciales desde scripts locales hacia pipelines distribuidos.",
    date: "2026-06-03",
    readTime: "6 min",
    tags: ["PySpark", "Geospatial", "Data Engineering"],
    file: "introduccion-pyspark-procesamiento-geoespacial.md",
  },
];

export default blogPosts;
