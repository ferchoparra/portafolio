function parseInline(text) {
  return text
    .replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>")
    .replace(/`([^`]+)`/g, "<code>$1</code>");
}

function MarkdownRenderer({ content }) {
  const lines = content.split("\n");
  const html = [];
  let listItems = [];

  const flushList = () => {
    if (listItems.length > 0) {
      html.push(`<ul>${listItems.map((item) => `<li>${parseInline(item)}</li>`).join("")}</ul>`);
      listItems = [];
    }
  };

  lines.forEach((line) => {
    const trimmed = line.trim();
    if (!trimmed) {
      flushList();
      return;
    }
    if (trimmed.startsWith("- ")) {
      listItems.push(trimmed.slice(2));
      return;
    }
    flushList();
    if (trimmed.startsWith("### ")) html.push(`<h3>${parseInline(trimmed.slice(4))}</h3>`);
    else if (trimmed.startsWith("## ")) html.push(`<h2>${parseInline(trimmed.slice(3))}</h2>`);
    else if (trimmed.startsWith("# ")) html.push(`<h1>${parseInline(trimmed.slice(2))}</h1>`);
    else html.push(`<p>${parseInline(trimmed)}</p>`);
  });
  flushList();

  return <div className="markdown" dangerouslySetInnerHTML={{ __html: html.join("") }} />;
}

export default MarkdownRenderer;
