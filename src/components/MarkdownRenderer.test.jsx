import { render, screen, within } from "@testing-library/react";
import MarkdownRenderer from "./MarkdownRenderer";

test.each([2, 4])("keeps layers nested with %i spaces of indentation", (spaces) => {
  const layers = [
    "Áreas homogéneas de tierra",
    "Disponibilidad de agua",
    "Influencia vial",
    "Normatividad de uso",
    "Uso actual.",
  ];
  render(<MarkdownRenderer content={[
    "- Capas de variables:",
    ...layers.map((layer) => `${" ".repeat(spaces)}- ${layer}`),
    "- Intersección inicial de las variables.",
  ].join("\n")} />);

  const [outerList, nestedList] = screen.getAllByRole("list");
  expect(outerList.children).toHaveLength(2);
  expect(outerList.children[0]).toContainElement(nestedList);
  expect(within(nestedList).getAllByRole("listitem").map((item) => item.textContent)).toEqual(layers);
  expect(outerList.children[1]).toHaveTextContent("Intersección inicial de las variables.");
});

test("returns to parent levels and closes the list before the next section", () => {
  render(<MarkdownRenderer content={[
    "- Principal",
    "  - Capa",
    "    - **Detalle**",
    "  - Otra capa",
    "- Siguiente",
    "",
    "## Metodología",
  ].join("\n")} />);

  const [outer, nested, deepest] = screen.getAllByRole("list");
  expect(outer.children).toHaveLength(2);
  expect(nested.children).toHaveLength(2);
  expect(nested.children[0]).toContainElement(deepest);
  expect(deepest.querySelector("strong")).toHaveTextContent("Detalle");
  expect(outer).not.toContainElement(screen.getByRole("heading"));
});
