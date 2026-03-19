# mermaid-diagrams

A Claude Code skill for generating and rendering [Mermaid](https://mermaid.js.org/) diagrams inside your projects.

Diagrams are saved to `docs/diagrams/` in your project. They render natively in VS Code, GitHub, and Obsidian — no image export needed for those surfaces.

## Install

The repo root **is** the skill directory. Clone it directly into `.claude/skills/`:

### Project skill (shared with your team via git)

```bash
git clone https://github.com/klaudekevin/mermaid-diagrams .claude/skills/mermaid-diagrams
```

Commit `.claude/skills/mermaid-diagrams/` to your repo so teammates get it automatically.

### Personal skill (available across all your projects)

```bash
git clone https://github.com/klaudekevin/mermaid-diagrams ~/.claude/skills/mermaid-diagrams
```

That's it — Claude Code auto-discovers skills in both locations.

## Update

```bash
cd .claude/skills/mermaid-diagrams && git pull
# or for personal install:
cd ~/.claude/skills/mermaid-diagrams && git pull
```

## Usage

**Generate a diagram** — just ask Claude Code naturally:

> "Create a sequence diagram for our auth flow"
> "Draw an ER diagram for the users and orders tables"
> "Make a flowchart of the deployment process"

Claude saves the `.mmd` file to `docs/diagrams/` and shows it inline in the response.

**Render to an image** — ask Claude to render it, or it will do it automatically if you ask for a PNG/SVG:

> "Render the auth flow diagram to a PNG"

Requires Node.js. `mmdc` is auto-fetched via `npx` on first use, or install globally:

```bash
npm install -g @mermaid-js/mermaid-cli
```

## Supported Diagram Types

Flowchart, Sequence, ER, Class, State, Gantt, Git graph, Mindmap, C4 Context
