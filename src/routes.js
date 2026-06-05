const routes = {
  home: "/",
  projects: "/projects",
  projectDetail: (slug = ":slug") => `/projects/${slug}`,
  blog: "/blog",
  blogDetail: (slug = ":slug") => `/blog/${slug}`,
  contact: "/contact",
};

export default routes;
