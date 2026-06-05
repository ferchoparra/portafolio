function Timeline({ items }) {
  return (
    <div className="timeline">
      {items.map((item) => (
        <article className="timeline-item" key={`${item.period}-${item.role}`}>
          <div className="timeline-marker" aria-hidden="true" />
          <div className="timeline-card">
            <p className="timeline-period">{item.period}</p>
            <h3>{item.role}</h3>
            <p className="timeline-org">{item.organization}</p>
            <p>{item.description}</p>
            <div className="tag-row">
              {item.highlights.map((highlight) => (
                <span className="tag" key={highlight}>
                  {highlight}
                </span>
              ))}
            </div>
          </div>
        </article>
      ))}
    </div>
  );
}

export default Timeline;
