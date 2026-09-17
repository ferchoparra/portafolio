const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { pathToFileURL } = require('node:url');

const root = path.resolve(__dirname, '..');
const output = path.join(root, 'cv', 'generated');
const previewOnly = process.argv.includes('--html');
const escape = (text) => text.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');

const inline = (text) => escape(text).replace(/\*\*(\S(?:[^*]*?\S)?)\*\*/g, '<strong>$1</strong>');

// Deliberately small Markdown subset: headings, paragraphs, bold, bullet lists and page breaks.
function renderPage(source) {
  let isProfile = false;
  return source.trim().split(/\r?\n\s*\r?\n/).map((block) => {
    const heading = block.match(/^(#{1,3}) (.+)$/);
    if (heading) {
      if (heading[1].length <= 2) isProfile = heading[2].trim().toLowerCase() === 'perfil profesional';
      return `<h${heading[1].length}>${inline(heading[2])}</h${heading[1].length}>`;
    }
    const lines = block.split(/\r?\n/);
    if (lines.every((line) => line.startsWith('- '))) {
      return `<ul>${lines.map((line) => `<li>${inline(line.slice(2))}</li>`).join('')}</ul>`;
    }
    return `<p${isProfile ? ' class="profile-text"' : ''}>${inline(lines.join(' '))}</p>`;
  }).join('\n');
}

function findBrowser() {
  if (process.env.CV_BROWSER) {
    if (!fs.existsSync(process.env.CV_BROWSER)) throw new Error('CV_BROWSER no apunta a un ejecutable existente.');
    return process.env.CV_BROWSER;
  }
  const candidates = process.platform === 'win32'
    ? [process.env.PROGRAMFILES, process.env['PROGRAMFILES(X86)'], process.env.LOCALAPPDATA]
      .filter(Boolean).flatMap((base) => [
        path.join(base, 'Google', 'Chrome', 'Application', 'chrome.exe'),
        path.join(base, 'Microsoft', 'Edge', 'Application', 'msedge.exe'),
      ])
    : process.platform === 'darwin'
      ? ['/Applications/Google Chrome.app/Contents/MacOS/Google Chrome', '/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge']
      : ['/usr/bin/google-chrome', '/usr/bin/google-chrome-stable', '/usr/bin/chromium', '/usr/bin/chromium-browser', '/usr/bin/microsoft-edge'];
  const browser = candidates.find((candidate) => fs.existsSync(candidate));
  if (!browser) throw new Error('Instala Chrome o Edge, o define CV_BROWSER con la ruta de su ejecutable. También puedes imprimir cv/generated/cv.html manualmente.');
  return browser;
}

function main() {
  const source = fs.readFileSync(path.join(root, 'cv', 'cv.md'), 'utf8');
  const style = fs.readFileSync(path.join(root, 'cv', 'style.css'), 'utf8');
  const pages = source.split(/<!--\s*pagebreak\s*-->/).filter((page) => page.trim());
  const html = `<!doctype html>
<html lang="es"><head><meta charset="utf-8"><title>Luis Fernando Parra — CV</title><meta name="viewport" content="width=device-width, initial-scale=1"><style>${style}</style></head>
<body><div class="toolbar">Vista previa del CV<button onclick="window.print()">Imprimir / Guardar PDF</button></div><main>${pages.map((page) => `<section class="page">${renderPage(page)}</section>`).join('\n')}</main></body></html>`;
  fs.mkdirSync(output, { recursive: true });
  const htmlPath = path.join(output, 'cv.html');
  fs.writeFileSync(htmlPath, html);
  console.log(`Vista previa: ${htmlPath}`);
  if (previewOnly) return;

  const browser = findBrowser();
  const temp = fs.mkdtempSync(path.join(os.tmpdir(), 'portafolio-cv-'));
  try {
    const pdfPath = path.join(temp, 'cv.pdf');
    const result = spawnSync(browser, [
      '--headless', '--disable-gpu', '--no-first-run', '--no-default-browser-check',
      '--disable-extensions', '--disable-background-networking',
      `--user-data-dir=${path.join(temp, 'profile')}`,
      '--no-pdf-header-footer', `--print-to-pdf=${pdfPath}`, pathToFileURL(htmlPath).href,
    ], { timeout: 60000, encoding: 'utf8', windowsHide: true });
    if (result.error || result.status !== 0 || !fs.existsSync(pdfPath)) {
      throw new Error(`No se pudo generar el PDF: ${result.error?.message || result.stderr || 'el navegador no produjo un archivo'}`);
    }
    const pdf = fs.readFileSync(pdfPath);
    if (pdf.subarray(0, 5).toString() !== '%PDF-') throw new Error('El navegador produjo un archivo PDF inválido.');
    const generatedPdf = path.join(output, 'luis-fernando-parra-cv.pdf');
    fs.copyFileSync(pdfPath, generatedPdf);
    console.log(`Copia generada: ${generatedPdf}`);
    const destination = path.join(root, 'public', 'assets', 'cv', 'luis-fernando-parra-cv.pdf');
    try { fs.copyFileSync(pdfPath, destination); }
    catch (error) {
      if (['EBUSY', 'EPERM', 'EACCES'].includes(error.code)) {
        throw new Error(`No se pudo actualizar el PDF del portafolio (${error.code}). Cierra el PDF si está abierto y ejecuta de nuevo npm run cv:pdf. La versión nueva está en ${generatedPdf}`);
      }
      throw error;
    }
    console.log(`PDF generado: ${destination}`);
  } finally {
    try { fs.rmSync(temp, { recursive: true, force: true, maxRetries: 3, retryDelay: 200 }); }
    catch { console.warn(`No se pudo limpiar el directorio temporal: ${temp}`); }
  }
}

try { main(); }
catch (error) { console.error(error.message); process.exitCode = 1; }
