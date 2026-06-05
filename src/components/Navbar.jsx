import { NavLink } from "react-router-dom";
import routes from "../routes";
import ThemeToggle from "./ThemeToggle";

function Navbar() {
  return (
    <header className="site-header">
      <nav className="navbar section-shell" aria-label="Navegacion principal">
        <NavLink className="brand" to={routes.home}>
          <span className="brand-mark">LP</span>
          <span>Luis Fernando Parra</span>
        </NavLink>

        <div className="nav-links">
          <NavLink to="/#about">Sobre mi</NavLink>
          <NavLink to="/#experience">Experiencia</NavLink>
          <NavLink to={routes.projects}>Proyectos</NavLink>
          <NavLink to={routes.blog}>Blog Tecnico</NavLink>
          <NavLink to="/#cv">CV</NavLink>
          <NavLink to={routes.contact}>Contacto</NavLink>
        </div>

        <ThemeToggle />
      </nav>
    </header>
  );
}

export default Navbar;
