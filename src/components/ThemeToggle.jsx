import { Moon, Sun } from "lucide-react";
import { useEffect, useState } from "react";

function getInitialTheme() {
  const savedTheme = localStorage.getItem("portfolio-theme");
  if (savedTheme) return savedTheme;
  if (!window.matchMedia) return "light";
  return window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
}

function ThemeToggle() {
  const [theme, setTheme] = useState(getInitialTheme);

  useEffect(() => {
    document.documentElement.dataset.theme = theme;
    localStorage.setItem("portfolio-theme", theme);
  }, [theme]);

  return (
    <button
      className="icon-button"
      type="button"
      aria-label="Cambiar modo claro u oscuro"
      title="Cambiar tema"
      onClick={() => setTheme((current) => (current === "dark" ? "light" : "dark"))}
    >
      {theme === "dark" ? <Sun size={18} /> : <Moon size={18} />}
    </button>
  );
}

export default ThemeToggle;
