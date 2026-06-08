---
name: mermaid-diagrams
description: Generate Mermaid diagrams as text that renders inline in Markdown (GitHub, Obsidian, VS Code) with no committed image. Use when the user explicitly asks for Mermaid, or wants a diagram embedded as a fenced ```mermaid code block in a Markdown / docs file. For standalone diagrams, charts, graphs, or anything going into a gallery, README, or visual showcase, prefer the excalidraw-diagrams skill — that is the default for diagrams. Covers flowchart, sequence, ER, class, state, Gantt, git graph, mindmap, and C4 diagrams; can also render or export a Mermaid diagram to a PNG or SVG image.
argument-hint: "[diagram type or description]"
allowed-tools: Read, Write, Edit, Bash
---

# Mermaid Diagrams

Generate Mermaid diagrams and optionally render them to images.

## Storage

**Always save diagrams inside the current project at `docs/diagrams/`** (create the directory if it doesn't exist). Never write to system directories, temp folders, or this skill's directory.

- Diagram source: `docs/diagrams/<name>.mmd`
- Rendered images: `docs/diagrams/<name>.png` or `docs/diagrams/<name>.svg`

## Supported Diagram Types

| Type | Opening keyword |
|------|----------------|
| Flowchart | `flowchart TD` / `graph LR` |
| Sequence | `sequenceDiagram` |
| Entity-Relationship | `erDiagram` |
| Class | `classDiagram` |
| State | `stateDiagram-v2` |
| Gantt | `gantt` |
| Git graph | `gitGraph` |
| Mindmap | `mindmap` |
| C4 Context | `C4Context` |

## Workflow

1. Understand what to visualize — ask if unclear
2. Choose the best diagram type
3. Write the Mermaid syntax and save to `docs/diagrams/<name>.mmd`
4. Show the diagram inline in your response as a fenced `mermaid` block (renders natively in VS Code, GitHub, Obsidian)
5. If the user asks for an image, run the render script:

```bash
bash "${CLAUDE_SKILL_DIR}/scripts/render.sh" docs/diagrams/<name>.mmd [docs/diagrams/<name>.svg]
```

## Examples

See [references/examples.md](references/examples.md) for complete examples of every diagram type.
