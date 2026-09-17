# CV editable

El contenido está en [`cv.md`](cv.md). Puedes editarlo con cualquier editor de texto o con la vista previa Markdown de VS Code. Se transcribió el PDF anterior, corrigiendo espaciado y errores tipográficos; el diseño es nuevo y no reproduce elementos gráficos ni firmas del original.

Desde la raíz del repositorio:

```sh
npm run cv:preview
```

Abre `cv/generated/cv.html` en el navegador para revisar el resultado. Vuelve a ejecutar el comando y recarga la página después de editar.

```sh
npm run cv:pdf
```

Este comando genera la vista previa y **reemplaza `public/assets/cv/luis-fernando-parra-cv.pdf`**, que es el archivo enlazado en el portafolio. Requiere Node.js y Chrome o Edge instalados; no añade dependencias npm. El PDF anterior se conserva si falla la generación.

También se guarda una copia en `cv/generated/luis-fernando-parra-cv.pdf`. Si el PDF del portafolio está abierto y bloqueado, cierra el archivo y vuelve a ejecutar el comando; mientras tanto puedes revisar la copia generada.

Si el navegador está en otra ubicación, configura `CV_BROWSER`. Ejemplo en PowerShell:

```powershell
$env:CV_BROWSER = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
npm run cv:pdf
```

También puedes usar el botón **Imprimir / Guardar PDF** de la vista previa. Selecciona A4, escala 100 % y desactiva encabezados y pies de página del navegador. Guarda el resultado con el nombre y ruta indicados arriba.

## Cómo editar

- `# Nombre`: título principal.
- `## Sección`: encabezado de sección.
- `### Cargo o estudio`: subtítulo.
- Una línea en blanco separa párrafos y títulos.
- `- Texto`: elemento de una lista (un elemento por línea).
- `**Texto**`: texto en negrita, también dentro de párrafos, títulos y listas.
- `<!-- pagebreak -->`: comienza una nueva página.

Este es el subconjunto Markdown admitido; enlaces, tablas y HTML no se interpretan. Edita [`style.css`](style.css) para ajustar colores, márgenes, fuente y espaciado. Si agregas mucho contenido, el navegador creará páginas adicionales: revisa el PDF antes de publicarlo.

La vista previa se ignora en Git. Versiona `cv.md`, los estilos y el PDF generado. Para actualizar el sitio publicado, usa el proceso habitual de despliegue después de generar el PDF (`npm run deploy`).
