import { Download, Github, Linkedin, MapPinned } from "lucide-react";
import { Link } from "react-router-dom";
import profile from "../data/profile";
import routes from "../routes";

function Hero() {
  return (
    <section className="hero section-shell">
      <div className="hero-content">
        <p className="eyebrow">Estadistica aplicada, ML y analitica geoespacial</p>
        <h1>{profile.name}</h1>
        <div className="hero-title" aria-label={profile.titleLines.join(", ")}>
          {profile.titleLines.map((line) => (
            <span key={line}>{line}</span>
          ))}
        </div>
        <p className="hero-description">{profile.description}</p>
        <div className="hero-actions">
          <Link className="button primary" to={routes.projects}>
            Ver proyectos
          </Link>
          <a className="button" href={profile.cvUrl} download>
            <Download size={18} />
            Descargar CV
          </a>
          <a className="button ghost" href={profile.githubUrl} target="_blank" rel="noreferrer">
            <Github size={18} />
            GitHub
          </a>
          <a className="button ghost" href={profile.linkedinUrl} target="_blank" rel="noreferrer">
            <Linkedin size={18} />
            LinkedIn
          </a>
        </div>
      </div>

      <aside className="hero-panel" aria-label="Especialidad profesional">
        <MapPinned size={30} />
        <h2>Modelos con contexto territorial</h2>
        <p>
          Unión de estadística, información espacial y procesamiento escalable para problemas
          agrícolas, ambientales y de decisión pública.
        </p>
        <dl>
          <div>
            <dt>Stack</dt>
            <dd>R, Python, Spark, SQL</dd>
          </div>
          <div>
            <dt>Geo</dt>
            <dd>PostGIS, QGIS, GeoParquet</dd>
          </div>
          <div>
            <dt>Modelos</dt>
            <dd>ML, Estadística Espacial, Inferencia</dd>
          </div>
        </dl>
      </aside>
    </section>
  );
}

export default Hero;
