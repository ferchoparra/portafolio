import { ArrowLeft } from "lucide-react";
import { Link, Navigate, useParams } from "react-router-dom";
import projects from "../data/projects";
import routes from "../routes";
import usePageTitle from "../utils/usePageTitle";

function ProjectDetail() {
  const { slug } = useParams();
  const project = projects.find((item) => item.slug === slug);

  usePageTitle(project ? `${project.title} | Proyecto` : "Proyecto no encontrado");

  if (!project) return <Navigate to={routes.projects} replace />;

  const sections = [
    ["Resumen ejecutivo", project.summary],
    ["Problema", project.problem],
    ["Datos utilizados", project.data],
    ["Metodología", project.methodology],
    ["Resultados", project.results],
    ["Lecciones aprendidas", project.lessons],
  ];

  return (
    <article className="section-shell page-block project-detail">
      <Link className="text-link back-link" to={routes.projects}>
        <ArrowLeft size={16} /> Volver a proyectos
      </Link>
      <div className="detail-hero">
        <p className="eyebrow">Proyecto profesional</p>
        <h1>{project.title}</h1>
        <div className="tag-row">
          {project.technologies.map((technology) => (
            <span className="tag" key={technology}>
              {technology}
            </span>
          ))}
        </div>
      </div>

      <div className="detail-grid">
        {sections.map(([title, body]) => (
          <section className="detail-section" key={title}>
            <h2>{title}</h2>
            <p>{body}</p>
          </section>
        ))}
      </div>
    </article>
  );
}

export default ProjectDetail;
