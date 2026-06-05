import { Github, Linkedin, Mail } from "lucide-react";
import profile from "../data/profile";
import usePageTitle from "../utils/usePageTitle";

function Contact() {
  usePageTitle("Contacto | Luis Fernando Parra");

  return (
    <section className="section-shell page-block contact-page">
      <div className="section-heading">
        <p className="eyebrow">Contacto</p>
        <h1>Conversemos sobre datos, modelos y territorio</h1>
        <p>
          Disponible para oportunidades internacionales, posiciones de Data Scientist,
          ML Engineer y Geospatial Data Scientist.
        </p>
      </div>
      <div className="contact-grid">
        <a className="contact-card" href={profile.githubUrl} target="_blank" rel="noreferrer">
          <Github size={24} />
          <span>GitHub</span>
        </a>
        <a className="contact-card" href={profile.linkedinUrl} target="_blank" rel="noreferrer">
          <Linkedin size={24} />
          <span>LinkedIn</span>
        </a>
        <a className="contact-card" href={`mailto:${profile.email}`}>
          <Mail size={24} />
          <span>{profile.email}</span>
        </a>
      </div>
    </section>
  );
}

export default Contact;
