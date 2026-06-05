import { Github, Linkedin, Mail } from "lucide-react";
import profile from "../data/profile";

function Footer() {
  return (
    <footer className="footer">
      <div className="section-shell footer-content">
        <p>© 2026 Luis Fernando Parra. Data Science, Estadistica y GIS.</p>
        <div className="social-links" aria-label="Redes profesionales">
          <a href={profile.githubUrl} target="_blank" rel="noreferrer" aria-label="GitHub">
            <Github size={18} />
          </a>
          <a href={profile.linkedinUrl} target="_blank" rel="noreferrer" aria-label="LinkedIn">
            <Linkedin size={18} />
          </a>
          <a href={`mailto:${profile.email}`} aria-label="Correo electronico">
            <Mail size={18} />
          </a>
        </div>
      </div>
    </footer>
  );
}

export default Footer;
