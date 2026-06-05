import { ArrowUpRight } from "lucide-react";
import { Link } from "react-router-dom";
import routes from "../routes";

function ProjectCard({ project }) {
  return (
    <article className="project-card">
      <div>
        <p className="card-kicker">Caso profesional</p>
        <h3>{project.title}</h3>
        <p>{project.summary}</p>
      </div>
      <div className="tag-row">
        {project.technologies.slice(0, 4).map((technology) => (
          <span className="tag" key={technology}>
            {technology}
          </span>
        ))}
      </div>
      <Link className="text-link" to={routes.projectDetail(project.slug)}>
        Ver detalle <ArrowUpRight size={16} />
      </Link>
    </article>
  );
}

export default ProjectCard;
