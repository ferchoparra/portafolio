import { Download } from "lucide-react";
import Hero from "../components/Hero";
import ProjectCard from "../components/ProjectCard";
import SkillCard from "../components/SkillCard";
import Timeline from "../components/Timeline";
import experience from "../data/experience";
import profile from "../data/profile";
import projects from "../data/projects";
import skillGroups, { coreTechnologies } from "../data/skills";
import usePageTitle from "../utils/usePageTitle";

function Home() {
  usePageTitle("Luis Fernando Parra | Data Scientist & Geospatial Analytics");
  const featuredProjects = projects.filter((project) => project.featured);

  return (
    <>
      <Hero />

      <section className="section-shell section-block tech-strip" aria-labelledby="tech-title">
        <div className="section-heading">
          <p className="eyebrow">Tecnologias principales</p>
          <h2 id="tech-title">Stack para estadistica, ML y GIS</h2>
        </div>
        <div className="tech-grid">
          {coreTechnologies.map((technology) => (
            <span key={technology}>{technology}</span>
          ))}
        </div>
      </section>

      <section id="about" className="section-shell section-block split-layout">
        <div className="section-heading">
          <p className="eyebrow">Sobre mi</p>
          <h2>Perfil profesional</h2>
        </div>
        <div className="prose">
          <p>
            Soy ingeniero forestal con formacion de posgrado en Estadistica y experiencia
            desarrollando modelos estadisticos, modelos de machine learning, procesos
            geoestadisticos y soluciones de analitica espacial.
          </p>
          <p>
            Mi trabajo conecta datos, territorio y decision: desde la preparacion de datos
            con R, Python, SQL y PySpark hasta la comunicacion de resultados mediante mapas,
            dashboards Shiny y visualizaciones tecnicas.
          </p>
        </div>
      </section>

      <section id="experience" className="section-shell section-block">
        <div className="section-heading">
          <p className="eyebrow">Experiencia</p>
          <h2>Trayectoria enfocada en modelos y territorio</h2>
        </div>
        <Timeline items={experience} />
      </section>

      <section id="skills" className="section-shell section-block">
        <div className="section-heading">
          <p className="eyebrow">Habilidades</p>
          <h2>Capacidades tecnicas</h2>
        </div>
        <div className="skills-grid">
          {skillGroups.map((group) => (
            <SkillCard group={group} key={group.title} />
          ))}
        </div>
      </section>

      <section id="projects" className="section-shell section-block">
        <div className="section-heading">
          <p className="eyebrow">Proyectos destacados</p>
          <h2>Casos reales para mostrar impacto tecnico</h2>
        </div>
        <div className="projects-grid">
          {featuredProjects.map((project) => (
            <ProjectCard project={project} key={project.slug} />
          ))}
        </div>
      </section>

      <section id="cv" className="section-shell section-block cv-band">
        <div>
          <p className="eyebrow">CV</p>
          <h2>Curriculum profesional</h2>
          <p>
            El boton usa una ruta configurable. Reemplaza el archivo en
            <code> public/assets/cv/luis-fernando-parra-cv.pdf</code> por tu version final.
          </p>
        </div>
        <a className="button primary" href={profile.cvUrl} download>
          <Download size={18} />
          Descargar CV
        </a>
      </section>
    </>
  );
}

export default Home;
