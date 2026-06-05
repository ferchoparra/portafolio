import { ArrowLeft } from "lucide-react";
import { useEffect, useState } from "react";
import { Link, Navigate, useParams } from "react-router-dom";
import MarkdownRenderer from "../components/MarkdownRenderer";
import blogPosts from "../data/blogPosts";
import routes from "../routes";
import usePageTitle from "../utils/usePageTitle";

function BlogDetail() {
  const { slug } = useParams();
  const post = blogPosts.find((item) => item.slug === slug);
  const [content, setContent] = useState("");

  usePageTitle(post ? `${post.title} | Blog Tecnico` : "Articulo no encontrado");

  useEffect(() => {
    if (!post) return;
    fetch(`${process.env.PUBLIC_URL}/content/blog/${post.file}`)
      .then((response) => response.text())
      .then(setContent)
      .catch(() =>
        setContent("# Contenido no disponible\n\nRevisa que el archivo Markdown exista en public/content/blog/.")
      );
  }, [post]);

  if (!post) return <Navigate to={routes.blog} replace />;

  return (
    <article className="section-shell page-block article-page">
      <Link className="text-link back-link" to={routes.blog}>
        <ArrowLeft size={16} /> Volver al blog
      </Link>
      <header className="article-header">
        <p className="eyebrow">
          {post.date} · {post.readTime}
        </p>
        <h1>{post.title}</h1>
        <p>{post.excerpt}</p>
        <div className="tag-row">
          {post.tags.map((tag) => (
            <span className="tag" key={tag}>
              {tag}
            </span>
          ))}
        </div>
      </header>
      <MarkdownRenderer content={content} />
    </article>
  );
}

export default BlogDetail;
