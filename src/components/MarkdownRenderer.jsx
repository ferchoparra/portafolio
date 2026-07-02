import { useEffect, useMemo, useRef } from "react";

function escapeHtml(text) {
  return text
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

function parseInline(text) {
  return escapeHtml(text)
    .replace(/!\[([^\]]*)\]\(([^)]+)\)/g, '<img src="$2" alt="$1" />')
    .replace(/\[([^\]]+)\]\(([^)]+)\)/g, '<a href="$2" target="_blank" rel="noreferrer">$1</a>')
    .replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>")
    .replace(/`([^`]+)`/g, "<code>$1</code>");
}

function isTableDivider(line) {
  return /^\s*\|?[\s:-]+\|[\s|:-]*\s*$/.test(line);
}

function splitTableRow(line) {
  return line
    .trim()
    .replace(/^\|/, "")
    .replace(/\|$/, "")
    .split("|")
    .map((cell) => cell.trim());
}

function renderTable(lines) {
  const [headerLine, , ...bodyLines] = lines;
  const headers = splitTableRow(headerLine);
  const rows = bodyLines.map(splitTableRow);

  return `
    <div class="markdown-table-wrap">
      <table>
        <thead>
          <tr>${headers.map((header) => `<th>${parseInline(header)}</th>`).join("")}</tr>
        </thead>
        <tbody>
          ${rows
            .map((row) => `<tr>${row.map((cell) => `<td>${parseInline(cell)}</td>`).join("")}</tr>`)
            .join("")}
        </tbody>
      </table>
    </div>
  `;
}

function renderMarkdown(content) {
  const lines = content.split("\n");
  const html = [];
  let listItems = [];

  const flushList = () => {
    if (listItems.length > 0) {
      html.push(`<ul>${listItems.map((item) => `<li>${parseInline(item)}</li>`).join("")}</ul>`);
      listItems = [];
    }
  };

  for (let index = 0; index < lines.length; index += 1) {
    const line = lines[index];
    const trimmed = line.trim();
    if (!trimmed) {
      flushList();
      continue;
    }
    if (trimmed.startsWith("- ")) {
      listItems.push(trimmed.slice(2));
      continue;
    }
    if (trimmed === "$$") {
      const mathLines = [];
      index += 1;
      while (index < lines.length && lines[index].trim() !== "$$") {
        mathLines.push(lines[index]);
        index += 1;
      }
      flushList();
      html.push(`<div class="math-display">\\[${escapeHtml(mathLines.join("\n"))}\\]</div>`);
      continue;
    }
    if (trimmed.includes("|") && lines[index + 1] && isTableDivider(lines[index + 1])) {
      const tableLines = [line, lines[index + 1]];
      index += 2;
      while (lines[index] && lines[index].trim().includes("|")) {
        tableLines.push(lines[index]);
        index += 1;
      }
      index -= 1;
      flushList();
      html.push(renderTable(tableLines));
      continue;
    }
    flushList();
    if (trimmed.startsWith("### ")) html.push(`<h3>${parseInline(trimmed.slice(4))}</h3>`);
    else if (trimmed.startsWith("## ")) html.push(`<h2>${parseInline(trimmed.slice(3))}</h2>`);
    else if (trimmed.startsWith("# ")) html.push(`<h1>${parseInline(trimmed.slice(2))}</h1>`);
    else html.push(`<p>${parseInline(trimmed)}</p>`);
  }
  flushList();

  return html.join("");
}

function MarkdownRenderer({ content }) {
  const containerRef = useRef(null);
  const html = useMemo(() => renderMarkdown(content), [content]);

  useEffect(() => {
    let attempts = 0;
    let timerId;

    const typesetMath = () => {
      attempts += 1;
      const mathJax = window.MathJax;
      if (mathJax?.typesetPromise && containerRef.current) {
        mathJax.typesetClear?.([containerRef.current]);
        mathJax.typesetPromise([containerRef.current]).catch(() => {});
        return true;
      }
      return attempts >= 20;
    };

    if (!typesetMath()) {
      timerId = window.setInterval(() => {
        if (typesetMath()) window.clearInterval(timerId);
      }, 250);
    }

    return () => {
      if (timerId) window.clearInterval(timerId);
    };
  }, [html]);

  return <div ref={containerRef} className="markdown" dangerouslySetInnerHTML={{ __html: html }} />;
}

export default MarkdownRenderer;
