import { ArrowUpRight } from "lucide-react";
import { Link } from "react-router-dom";
import blogPosts from "../data/blogPosts";
import routes from "../routes";
import usePageTitle from "../utils/usePageTitle";

function Blog() {
  usePageTitle("Blog Tecnico | Luis Fernando Parra");

  return (
    <section className="section-shell page-block">
      <div className="section-heading">
        <p className="eyebrow">Blog tecnico</p>
        <h1>Notas sobre estadistica, ML, GIS y Big Data</h1>
        <p>
          Articulos en Markdown pensados para documentar criterios tecnicos, decisiones de
          modelamiento y aprendizajes profesionales.
        </p>
      </div>
      <div className="blog-list">
        {blogPosts.map((post) => (
          <article className="blog-card" key={post.slug}>
            <div>
              <p className="card-kicker">
                {post.date} · {post.readTime}
              </p>
              <h2>{post.title}</h2>
              <p>{post.excerpt}</p>
              <div className="tag-row">
                {post.tags.map((tag) => (
                  <span className="tag" key={tag}>
                    {tag}
                  </span>
                ))}
              </div>
            </div>
            <Link className="text-link" to={routes.blogDetail(post.slug)}>
              Leer articulo <ArrowUpRight size={16} />
            </Link>
          </article>
        ))}
      </div>
    </section>
  );
}

export default Blog;
