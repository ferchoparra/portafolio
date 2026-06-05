function SkillCard({ group }) {
  return (
    <article className="skill-card">
      <h3>{group.title}</h3>
      <div className="tag-row">
        {group.skills.map((skill) => (
          <span className="tag" key={skill}>
            {skill}
          </span>
        ))}
      </div>
    </article>
  );
}

export default SkillCard;
