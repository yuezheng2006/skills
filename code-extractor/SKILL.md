---
name: code-extraction
description: Extract source code from repositories using repomix CLI for AI analysis and code review. Use this skill when users need to export codebase content in AI-friendly formats (XML, Markdown), extract specific portions (head/tail lines), filter by file patterns, or prepare code for documentation. Automatically excludes non-source files (node_modules, build artifacts, configs) to focus on actual implementation code.
---

# Code Extraction

Extract and package source code from repositories into single AI-friendly files using repomix CLI. Designed for AI analysis, code review, documentation, and codebase understanding.

## Capabilities

This skill provides comprehensive code extraction functionality:

- ✅ **Full codebase extraction** - Export entire repository with smart exclusions
- ✅ **Partial extraction** - Extract first N and/or last N lines for quick overview
- ✅ **Pattern-based filtering** - Include only specific file types or directories
- ✅ **Multiple output formats** - XML (structured), Markdown (readable), Plain (simple)
- ✅ **Smart exclusions** - Automatically skip non-code files (configs, dependencies, build artifacts)
- ✅ **Token optimization** - Compress output and remove comments/empty lines
- ✅ **Code-only focus** - Extract implementation code, not configuration files

## How to Use

### Basic Workflow

1. **Determine extraction scope**
   - Full codebase: Use `extract-full.sh`
   - Quick overview (head/tail): Use `extract-head-tail.sh`
   - Specific files: Use `extract-filtered.sh`

2. **Choose output format**
   - XML: For structured AI consumption
   - Markdown: For human readability
   - Plain: For simple concatenation

3. **Run extraction script**
   - Scripts in `scripts/` directory
   - All scripts auto-exclude non-code files

4. **Review generated output**
   - File saved in current directory
   - Ready for AI analysis or sharing

### Input Requirements

- Local directory with source code
- repomix CLI installed (Node.js ≥ 20.0.0)
- Read permissions on source files

### Output Format

All extraction methods produce:
- File summary with token counts
- Directory structure overview
- Source code content (formatted per selected style)
- Automatic exclusion of:
  - Dependencies (`node_modules`, `vendor`, `.venv`)
  - Build artifacts (`dist`, `build`, `out`, `target`)
  - IDE configs (`.vscode`, `.idea`)
  - Git internals (`.git`)

## Extraction Methods

### Method 1: Full Code Extraction

Extract all source code, automatically excluding non-code files.

**Script**: `bash scripts/extract-full.sh [directory] [format]`

**Parameters**:
- `directory` (optional): Target directory, defaults to `.`
- `format` (optional): `xml`, `markdown`, or `plain`, defaults to `xml`

**What gets excluded automatically**:
- Package dependencies (node_modules, vendor, etc.)
- Build outputs (dist, build, out, etc.)
- Configuration files (.env, *.config.js, etc.)
- IDE/editor files (.vscode, .idea, etc.)
- Version control (.git, .svn, etc.)

**Example**:
```bash
# Extract current directory as XML
bash scripts/extract-full.sh

# Extract specific directory as Markdown
bash scripts/extract-full.sh ./backend markdown
```

**Use when**: You need the complete codebase for comprehensive AI analysis or documentation.

### Method 2: Head and Tail Extraction

Extract first N and last N lines of code for quick overview without full codebase.

**Script**: `bash scripts/extract-head-tail.sh [directory] [head-lines] [tail-lines] [format]`

**Parameters**:
- `directory` (optional): Target directory, defaults to `.`
- `head-lines` (optional): Lines from start, defaults to `3000`
- `tail-lines` (optional): Lines from end, defaults to `3000`
- `format` (optional): `xml`, `markdown`, or `plain`, defaults to `xml`

**Example**:
```bash
# Extract first 3000 and last 3000 lines (default)
bash scripts/extract-head-tail.sh

# Extract first 5000 and last 2000 lines as Markdown
bash scripts/extract-head-tail.sh . 5000 2000 markdown
```

**Use when**: You need a quick code overview without processing the entire codebase.

### Method 3: Filtered Code Extraction

Extract only files matching specific patterns (by type, directory, or name).

**Script**: `bash scripts/extract-filtered.sh [directory] [include-patterns] [format] [ignore-patterns]`

**Parameters**:
- `directory` (optional): Target directory, defaults to `.`
- `include-patterns` (optional): Comma-separated globs, defaults to all files
- `format` (optional): `xml`, `markdown`, or `plain`, defaults to `xml`
- `ignore-patterns` (optional): Additional exclusions

**Example**:
```bash
# Extract only TypeScript/React files
bash scripts/extract-filtered.sh . "*.ts,*.tsx,*.jsx" markdown

# Extract Python files, exclude tests
bash scripts/extract-filtered.sh . "*.py" xml "test_*.py,*_test.py"

# Extract specific directory
bash scripts/extract-filtered.sh ./src "*.java" markdown
```

**Use when**: You need specific file types or want to focus on particular modules.

## Example Usage

### Use Case 1: Full Stack Code Review
```bash
# Extract frontend code
bash scripts/extract-filtered.sh ./frontend "*.ts,*.tsx,*.css" markdown

# Extract backend code
bash scripts/extract-filtered.sh ./backend "*.py,*.sql" xml
```

### Use Case 2: Quick Codebase Overview
```bash
# Get first 2000 and last 2000 lines
bash scripts/extract-head-tail.sh . 2000 2000 markdown
```

### Use Case 3: Documentation Generation
```bash
# Extract only documentation and config
bash scripts/extract-filtered.sh . "*.md,*.json,*.yaml" markdown
```

### Use Case 4: Language-Specific Analysis
```bash
# Extract all Go code
bash scripts/extract-filtered.sh . "*.go" xml "*_test.go"

# Extract all JavaScript/TypeScript
bash scripts/extract-filtered.sh . "*.js,*.ts,*.jsx,*.tsx" markdown
```

### Use Case 5: AI Training Data Preparation
```bash
# Extract with compression and no comments
# (Modify script to add --compress --remove-comments flags)
bash scripts/extract-full.sh . plain
```

## Best Practices

### 1. Start with Filtered Extraction
- Use `extract-filtered.sh` to focus on relevant code
- Reduces token count and processing time
- Makes AI analysis more effective

### 2. Choose the Right Format
- **XML**: Best for structured AI analysis and parsing
- **Markdown**: Best for human review and documentation
- **Plain**: Best for simple text processing

### 3. Use Head/Tail for Large Codebases
- First 3000 + last 3000 lines often capture:
  - Entry points and main logic (head)
  - Core implementations and exports (tail)
- Much faster than full extraction

### 4. Leverage Pattern Filtering
- See `references/filter-patterns.md` for common patterns
- Combine include and exclude patterns
- Use directory paths for module-specific extraction

### 5. Verify Output Before AI Analysis
- Check file summary for token count
- Review directory structure for completeness
- Ensure relevant files are included

### 6. Reuse Extraction for Multiple Tasks
- Save extracted files for repeated analysis
- Use descriptive output filenames
- Archive extractions for version comparison

## Advanced Options

### Custom Exclusions

Create `.repomixignore` in target directory:
```bash
# Add custom patterns
echo "legacy/" >> .repomixignore
echo "*.generated.ts" >> .repomixignore
```

### Token Optimization

Modify scripts to add:
- `--compress` - Smart code compression using tree-sitter
- `--remove-comments` - Strip code comments
- `--remove-empty-lines` - Remove blank lines
- `--output-show-line-numbers` - Add line numbers for debugging

### Output to Clipboard

Modify scripts to add:
- `--copy` - Copy output to system clipboard
- `--stdout` - Stream to stdout instead of file

## Scripts

This skill includes three extraction scripts:

### `scripts/extract-full.sh`
Full repository extraction with automatic non-code exclusions.

**Features**:
- Auto-excludes dependencies, builds, configs
- Respects `.gitignore` patterns
- Supports all output formats

### `scripts/extract-head-tail.sh`
Extracts first N and last N lines for quick code overview.

**Features**:
- Configurable line counts
- Maintains directory structure in summary
- Adds visual separator between head/tail

### `scripts/extract-filtered.sh`
Pattern-based file filtering for targeted extraction.

**Features**:
- Include patterns (comma-separated globs)
- Additional ignore patterns
- Supports nested directory patterns

## Resources

### `references/filter-patterns.md`
Comprehensive pattern library for common tech stacks:
- Frontend frameworks (React, Vue, Angular, Svelte)
- Backend frameworks (Node.js, Python, Go, Rust, Java)
- Mobile platforms (React Native, Flutter, iOS, Android)
- Infrastructure (Docker, Kubernetes, Terraform)
- Common exclusion patterns

## Requirements

### Required
- **repomix CLI** (v1.0.0+)
- **Node.js** ≥ 20.0.0

### Installation
```bash
# Global installation
npm install -g repomix

# Or use npx (no installation)
npx repomix@latest
```

### Verification
```bash
repomix --version
```

## Limitations

### 1. Requires repomix CLI
This skill is a wrapper around repomix. If repomix is not installed:
- Scripts will fail with clear error messages
- Install instructions are provided in error output
- Can use `npx repomix@latest` as fallback

### 2. Node.js Dependency
repomix requires Node.js ≥ 20.0.0. Older versions are not supported.

### 3. Large Repository Performance
- Very large repos (>100k files) may take 1-2 minutes
- Head/tail extraction is faster for quick overview
- Use filtering to reduce scope

### 4. Binary Files Excluded
Binary files (images, PDFs, executables) are automatically excluded by repomix.

### 5. Output Size Considerations
- Full extraction can produce large files (>10MB)
- Consider AI context limits when using output
- Use compression and filtering to reduce size

### 6. Line-Based Head/Tail Limitation
Head/tail extraction works on line count, not logical code blocks. May split:
- Function definitions
- Class declarations
- Comment blocks

Workaround: Adjust line counts or use filtered extraction.

## Troubleshooting

### Issue: "repomix: command not found"
**Solution**: Install repomix globally or use npx:
```bash
npm install -g repomix
# or
npx repomix@latest
```

### Issue: Output file is too large
**Solutions**:
- Use pattern filtering to include only necessary files
- Add `--compress` flag for token reduction
- Use head/tail extraction instead of full codebase
- Exclude test files and mocks

### Issue: Missing files in output
**Diagnostics**:
- Check `.repomixignore` and `.gitignore` for exclusion patterns
- Run with `--verbose` flag to see which files are processed
- Verify include patterns are correct (use glob tester)

### Issue: Generated file is empty
**Causes**:
- No files match include patterns
- All files excluded by ignore patterns
- Directory path incorrect

**Solution**: Run with `--verbose` to see processing details

## Token Efficiency Tips

1. **Use `--compress`** - Reduces output size by 30-50%
2. **Remove comments** - Use `--remove-comments` for code-only
3. **Filter aggressively** - Extract only what you need
4. **Exclude tests** - Add `*test*,*spec*` to ignore patterns
5. **Head/tail for overview** - 3000+3000 lines ≈ 10k tokens

## Version History

- **v1.0.0** (2025-10-23) - Initial release with full, head/tail, and filtered extraction
