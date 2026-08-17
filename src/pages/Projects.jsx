import ProjectCard from "../components/ProjectCard";
import { publishedProjects } from "../data/projects";
import usePageTitle from "../utils/usePageTitle";

function Projects() {
  usePageTitle("Proyectos | Luis Fernando Parra");

  return (
    <section className="section-shell page-block">
      <div className="section-heading">
        <p className="eyebrow">Portafolio técnico</p>
        <h1>Proyectos de Data Science, ML y GIS</h1>
        <p>
          Casos estructurados con problema, datos, metodología, tecnologías, resultados y
          aprendizajes.
        </p>
      </div>
      <div className="projects-grid">
        {publishedProjects.map((project) => (
          <ProjectCard project={project} key={project.slug} />
        ))}
      </div>
    </section>
  );
}

export default Projects;
