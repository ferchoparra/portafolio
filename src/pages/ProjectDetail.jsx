import { ArrowLeft } from "lucide-react";
import { useEffect, useState } from "react";
import { Link, Navigate, useParams } from "react-router-dom";
import MarkdownRenderer from "../components/MarkdownRenderer";
import projects from "../data/projects";
import routes from "../routes";
import usePageTitle from "../utils/usePageTitle";

function ProjectDetail() {
  const { slug } = useParams();
  const project = projects.find((item) => item.slug === slug);
  const [content, setContent] = useState("");

  usePageTitle(project ? `${project.title} | Proyecto` : "Proyecto no encontrado");

  useEffect(() => {
    if (!project?.file) return;
    fetch(`${process.env.PUBLIC_URL}/content/projects/${project.file}`)
      .then((response) => response.text())
      .then(setContent)
      .catch(() =>
        setContent(
          "# Contenido no disponible\n\nRevisa que el archivo Markdown exista en public/content/projects/."
        )
      );
  }, [project]);

  if (!project) return <Navigate to={routes.projects} replace />;

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

      <MarkdownRenderer content={content} />
    </article>
  );
}

export default ProjectDetail;
