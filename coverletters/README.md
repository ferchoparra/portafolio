# Cartas de presentación editables

Edita [coverletter.md](coverletter.md) y genera el PDF desde la raíz del proyecto:

```sh
npm run coverletter:pdf
```

El resultado se guarda en `public/assets/coverletters/coverletter.pdf`. El comando reemplaza el PDF del mismo nombre y conserva una copia en `coverletters/generated/`. La carta inicial es una presentación general basada en `cv/cv.md`; personaliza destinatario, fecha, empresa, cargo y motivación para cada postulación, sin inventar experiencia ni resultados.

Para mantener varias cartas, copia el Markdown con un nombre descriptivo, edítalo y pasa su ruta:

```sh
npm run coverletter:pdf -- coverletters/empresa-cargo.md
```

Este ejemplo genera `public/assets/coverletters/empresa-cargo.pdf`. Usa nombres distintos para conservar cada versión.

Para revisar antes de generar:

```sh
npm run coverletter:preview
npm run coverletter:preview -- coverletters/empresa-cargo.md
```

Abre el HTML correspondiente en `coverletters/generated/`. También puedes imprimirlo desde el navegador seleccionando A4, escala 100 % y sin encabezados ni pies de página.

El generador comparte `cv/style.css` con el CV: mismos colores, fuente Arial, tamaño A4 y márgenes. Requiere Node.js y Chrome o Edge, sin dependencias adicionales. Si el navegador está en otra ubicación, define `CV_BROWSER` con la ruta del ejecutable.

Admite títulos `#`, `##`, `###`, párrafos separados por una línea en blanco, **negrita**, listas con `- ` y saltos de página con `<!-- pagebreak -->`. No interpreta tablas, enlaces Markdown ni HTML; escribe las direcciones web como texto. Procura que cada carta ocupe una página y revisa el PDF si añades contenido.

Los PDF en `public/assets/coverletters/` se incluirán en el sitio cuando lo despliegues. Mantén allí solo cartas que quieras publicar. Las vistas previas y copias de `generated/` se ignoran en Git.
