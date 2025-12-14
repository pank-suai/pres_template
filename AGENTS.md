# Agent Guidelines for GUAP Presentation Template

## Build Commands
- **Compile**: `typst compile main.typ` (outputs main.pdf)
- **Watch mode**: `typst watch main.typ` (auto-recompile on changes)
- **No linting/testing**: This is a Typst document project

## Code Style

### Typst Conventions
- **Language**: Russian (lang: "ru")
- **Font**: Arial, 20pt base size
- **Imports**: Use named imports from lib/guap-template.typ
- **Color palette**: Use predefined GUAP colors (guap-blue, guap-dark-blue, guap-cyan, guap-magenta, guap-red)
- **Spacing**: Use v() for vertical spacing, leading: 0.5em for paragraphs
- **Margins**: margin-x = 1.25cm, margin-top = 100pt, margin-bottom = 40pt

### Naming Conventions
- **Functions**: kebab-case (e.g., slide-text-image, final-slide)
- **Variables**: kebab-case (e.g., guap-blue, margin-x)
- **Files**: kebab-case for .typ files

### Formatting
- **Indentation**: 2 spaces
- **Comments**: Use // for single-line comments
- **Content blocks**: Use square brackets [...] for content parameters
