import "./App.css";

function App() {
  const proyectos = [
    {
      titulo: "Modelo de Capitalización Agrícola",
      descripcion:
        "Diseño y desarrollo de modelos estadísticos para la estimación de capitalización agrícola.",
      tecnologias: "R · Estadística · GIS"
    },
    {
      titulo: "Predicción de Rendimientos",
      descripcion:
        "Modelos geoestadísticos y machine learning para estimar rendimientos agrícolas.",
      tecnologias: "R · XGBoost · Geoestadística"
    },
    {
      titulo: "Procesamiento Geoespacial Masivo",
      descripcion:
        "Optimización de operaciones espaciales usando GeoParquet y procesamiento distribuido.",
      tecnologias: "PySpark · GeoParquet · PostGIS"
    }
  ];

  return (
    <div className="App">

      {/* Navbar */}
      <nav className="navbar">
        <h2>Luis Fernando Parra</h2>

        <ul>
          <li><a href="#about">Sobre mí</a></li>
          <li><a href="#experience">Experiencia</a></li>
          <li><a href="#projects">Proyectos</a></li>
          <li><a href="#blog">Blog Técnico</a></li>
          <li><a href="#cv">CV</a></li>
          <li><a href="#contact">Contacto</a></li>
        </ul>
      </nav>

      {/* Hero */}
      <section className="hero">
        <h1>Luis Fernando Parra</h1>

        <h3>
          Ingeniero Forestal · Estadístico · Data Scientist · Geospatial Analytics
        </h3>

        <p>
          Desarrollo modelos estadísticos, geoestadísticos y de machine
          learning para resolver problemas complejos utilizando datos
          espaciales, big data y analítica avanzada.
        </p>
      </section>

      {/* Sobre mí */}
      <section id="about" className="section">
        <h2>Sobre mí</h2>

        <p>
          Profesional con experiencia en estadística aplicada,
          ciencia de datos, modelamiento geoespacial y desarrollo de
          soluciones analíticas para la toma de decisiones.
        </p>
      </section>

      {/* Experiencia */}
      <section id="experience" className="section">
        <h2>Experiencia</h2>

        <ul>
          <li>
            Desarrollo de modelos estadísticos y predictivos para el sector
            agropecuario.
          </li>

          <li>
            Procesamiento y análisis de grandes volúmenes de datos espaciales.
          </li>

          <li>
            Implementación de pipelines analíticos en R, Python y PySpark.
          </li>
        </ul>
      </section>

      {/* Proyectos */}
      <section id="projects" className="section">
        <h2>Proyectos Destacados</h2>

        <div className="projects-grid">
          {proyectos.map((proyecto, index) => (
            <div key={index} className="project-card">
              <h3>{proyecto.titulo}</h3>

              <p>{proyecto.descripcion}</p>

              <small>{proyecto.tecnologias}</small>
            </div>
          ))}
        </div>
      </section>

      {/* Blog */}
      <section id="blog" className="section">
        <h2>Blog Técnico</h2>

        <p>
          Próximamente compartiré artículos sobre estadística,
          machine learning, GIS y programación en R.
        </p>
      </section>

      {/* CV */}
      <section id="cv" className="section">
        <h2>Currículum</h2>

        <button>Descargar CV</button>
      </section>

      {/* Contacto */}
      <section id="contact" className="section">
        <h2>Contacto</h2>

        <p>correo@ejemplo.com</p>

        <p>GitHub</p>

        <p>LinkedIn</p>
      </section>

    </div>
  );
}

export default App;