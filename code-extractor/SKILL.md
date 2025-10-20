---
name: code-extractor
description: Extract source code from repositories using repomix CLI. Use this skill when users need to export codebase content in AI-friendly formats (XML, Markdown), extract specific portions (first/last N lines), or filter code by file patterns. Automatically excludes non-source directories like node_modules.
---

# Code Extractor

## Overview

Extract and package source code from repositories into single AI-friendly files using repomix. Supports full codebase export, partial extraction (head/tail lines), pattern-based filtering, and multiple output formats (XML, Markdown, Plain).

## Quick Start

To extract code, follow these steps:
1. Determine extraction scope (full, partial, or filtered)
2. Choose output format (XML, Markdown, or Plain)
3. Run appropriate extraction script from `scripts/`
4. Review and share the generated output file

## Extraction Methods

### 1. Full Repository Export (Default)

Extract all source code, automatically excluding non-source directories:

```bash
bash scripts/extract-full.sh [directory] [output-format]
```

**Parameters:**
- `directory` (optional): Target directory, defaults to current directory
- `output-format` (optional): `xml`, `markdown`, or `plain`, defaults to `xml`

**Example:**
```bash
# Extract current directory as XML
bash scripts/extract-full.sh

# Extract specific directory as Markdown
bash scripts/extract-full.sh ./my-project markdown
```

**What it excludes by default:**
- node_modules, vendor, .git directories
- Build artifacts (dist, build, out)
- IDE configurations (.vscode, .idea)
- See `references/filter-patterns.md` for full list

### 2. Head and Tail Extraction

Extract first N and last N lines of code:

```bash
bash scripts/extract-head-tail.sh [directory] [head-lines] [tail-lines] [output-format]
```

**Parameters:**
- `directory` (optional): Target directory, defaults to current directory
- `head-lines` (optional): Number of lines from start, defaults to 3000
- `tail-lines` (optional): Number of lines from end, defaults to 3000
- `output-format` (optional): `xml`, `markdown`, or `plain`, defaults to `xml`

**Example:**
```bash
# Extract first 3000 and last 3000 lines
bash scripts/extract-head-tail.sh . 3000 3000 markdown

# Extract first 5000 and last 2000 lines
bash scripts/extract-head-tail.sh ./src 5000 2000 xml
```

**Implementation:**
Uses full extraction then pipes through `head` and `tail` commands to extract specified portions.

### 3. Pattern-Based Filtering

Extract only files matching specific patterns:

```bash
bash scripts/extract-filtered.sh [directory] [include-patterns] [output-format]
```

**Parameters:**
- `directory` (optional): Target directory, defaults to current directory
- `include-patterns` (optional): Comma-separated glob patterns, defaults to all files
- `output-format` (optional): `xml`, `markdown`, or `plain`, defaults to `xml`

**Example:**
```bash
# Extract only TypeScript and React files
bash scripts/extract-filtered.sh . "*.ts,*.tsx,*.jsx" markdown

# Extract Python files only
bash scripts/extract-filtered.sh ./backend "*.py" xml

# Extract documentation
bash scripts/extract-filtered.sh . "*.md,*.mdx" markdown
```

**Additional ignore patterns:**
Pass extra ignore patterns to exclude specific files:
```bash
# Extract TypeScript but ignore test files
bash scripts/extract-filtered.sh . "*.ts,*.tsx" xml "*.test.ts,*.spec.ts"
```

## Output Formats

### XML (Default)
Best for structured parsing and AI consumption:
```xml
<file path="src/index.ts">
  <content>
    // code here
  </content>
</file>
```

### Markdown
Human-readable format with syntax highlighting:
````markdown
## File: src/index.ts
```typescript
// code here
```
````

### Plain
Simple concatenated text without formatting.

## Common Use Cases

### Extract Frontend Project
```bash
bash scripts/extract-filtered.sh . "*.ts,*.tsx,*.jsx,*.css,*.scss" markdown
```

### Extract Backend API
```bash
bash scripts/extract-filtered.sh ./backend "*.py,*.sql" xml
```

### Extract Configuration Files
```bash
bash scripts/extract-filtered.sh . "*.json,*.yaml,*.yml,*.toml" plain
```

### Quick Code Review (Head + Tail)
```bash
bash scripts/extract-head-tail.sh . 2000 2000 markdown
```

## Advanced Options

### Custom Exclusions
To add custom ignore patterns beyond defaults:
```bash
# Edit .repomixignore in target directory
echo "custom-dir/" >> .repomixignore
echo "*.private.ts" >> .repomixignore
```

### Include Line Numbers
Modify scripts to add `--output-show-line-numbers` flag for debugging.

### Remove Comments
Add `--remove-comments` flag to strip code comments.

### Compress Output
Add `--compress` flag to use tree-sitter smart code extraction.

## Resources

### scripts/
- `extract-full.sh` - Full repository extraction with automatic exclusions
- `extract-head-tail.sh` - Extract first N and last N lines
- `extract-filtered.sh` - Pattern-based file filtering

### references/
- `filter-patterns.md` - Common file patterns for different tech stacks

## Requirements

**Required:** repomix CLI (Node.js ≥ 20.0.0)

Install if not present:
```bash
npm install -g repomix
# or
npx repomix@latest
```

Verify installation:
```bash
repomix --version
```

## Troubleshooting

**"repomix: command not found"**
- Install repomix globally: `npm install -g repomix`
- Or use npx: `npx repomix@latest`

**Output file is too large**
- Use pattern filtering to include only necessary files
- Use `--compress` flag for token reduction
- Extract head/tail portions instead of full codebase

**Missing files in output**
- Check `.repomixignore` and `.gitignore` for exclusion patterns
- Use `--verbose` flag to see which files are being processed
- Verify include patterns are correct
