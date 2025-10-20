# Common Filter Patterns

This reference provides commonly used file patterns for different technology stacks and use cases.

## Frontend Frameworks

### React / Next.js
```bash
# All React source files
"*.jsx,*.tsx,*.ts,*.js,*.css,*.scss,*.sass"

# React components only
"*.jsx,*.tsx"

# Styles only
"*.css,*.scss,*.sass,*.module.css"
```

### Vue.js
```bash
# All Vue source files
"*.vue,*.ts,*.js,*.css,*.scss"

# Vue components only
"*.vue"
```

### Angular
```bash
# All Angular source files
"*.ts,*.html,*.css,*.scss"

# Components and services
"*.component.ts,*.service.ts"
```

### Svelte
```bash
# All Svelte source files
"*.svelte,*.ts,*.js,*.css"
```

## Backend Frameworks

### Node.js / Express
```bash
# All Node.js source files
"*.js,*.ts,*.mjs"

# Server files only
"*.js,*.ts,!*.test.js,!*.spec.js"
```

### Python / Django / Flask
```bash
# All Python source files
"*.py,*.pyi"

# Python excluding tests
"*.py,!test_*.py,!*_test.py"

# Django specific
"*.py,*.html,*.css"
```

### Ruby / Rails
```bash
# All Ruby source files
"*.rb,*.erb,*.haml"

# Rails models and controllers
"**/models/*.rb,**/controllers/*.rb"
```

### Java / Spring
```bash
# All Java source files
"*.java,*.xml,*.properties,*.yml"

# Java source only
"*.java"
```

### Go
```bash
# All Go source files
"*.go"

# Go excluding tests
"*.go,!*_test.go"
```

### Rust
```bash
# All Rust source files
"*.rs,Cargo.toml,Cargo.lock"

# Rust source only
"*.rs"
```

## Mobile Development

### React Native
```bash
# All React Native files
"*.jsx,*.tsx,*.ts,*.js,*.json"

# Mobile specific
"*.ios.js,*.android.js,*.native.js"
```

### Flutter / Dart
```bash
# All Flutter files
"*.dart,pubspec.yaml"

# Dart source only
"*.dart"
```

### Swift / iOS
```bash
# All Swift files
"*.swift,*.m,*.h"

# Swift only
"*.swift"
```

### Kotlin / Android
```bash
# All Kotlin files
"*.kt,*.kts,*.xml"

# Kotlin source only
"*.kt"
```

## Configuration & Infrastructure

### Docker
```bash
"Dockerfile,docker-compose.yml,*.dockerfile"
```

### Kubernetes
```bash
"*.yaml,*.yml,*.json"
```

### Terraform
```bash
"*.tf,*.tfvars"
```

### CI/CD
```bash
# GitHub Actions
".github/workflows/*.yml,.github/workflows/*.yaml"

# GitLab CI
".gitlab-ci.yml"

# Jenkins
"Jenkinsfile,*.groovy"
```

## Documentation

### Markdown
```bash
"*.md,*.mdx"
```

### API Documentation
```bash
"*.md,*.yaml,*.yml,*.json,openapi.json,swagger.json"
```

## Database

### SQL
```bash
"*.sql,*.mysql,*.pgsql"
```

### Migrations
```bash
# Sequelize
"**/migrations/*.js"

# Django
"**/migrations/*.py"

# Rails
"**/migrate/*.rb"
```

## Common Exclusion Patterns

### Build Artifacts
```bash
--ignore "dist/**,build/**,out/**,target/**"
```

### Dependencies
```bash
--ignore "node_modules/**,vendor/**,venv/**,.venv/**"
```

### Test Files
```bash
--ignore "*.test.js,*.spec.js,*.test.ts,*.spec.ts,**/__tests__/**,**/test/**"
```

### Generated Files
```bash
--ignore "*.generated.ts,*.g.dart,*.pb.go"
```

### IDE & Editor
```bash
--ignore ".vscode/**,.idea/**,*.swp,*.swo"
```

### Logs & Temp Files
```bash
--ignore "*.log,tmp/**,temp/**,.cache/**"
```

## Combined Patterns by Use Case

### Code Review (Minimal)
```bash
# Include only main source files, exclude tests and configs
"*.ts,*.tsx,*.js,*.jsx" --ignore "*.test.*,*.spec.*,*.config.*"
```

### AI Analysis (Full Stack)
```bash
# Include all source and config, exclude dependencies
"*.ts,*.tsx,*.js,*.jsx,*.css,*.scss,*.json,*.yaml,*.yml" \
--ignore "node_modules/**,dist/**,build/**"
```

### Security Audit
```bash
# Include all code and configs, exclude vendor
"*.ts,*.js,*.py,*.rb,*.java,*.go,*.yaml,*.json,Dockerfile" \
--ignore "vendor/**,node_modules/**"
```

### Documentation Extraction
```bash
# Include docs and READMEs only
"*.md,*.mdx,README*,CHANGELOG*,LICENSE*,docs/**"
```

### Migration Analysis
```bash
# Include only migration files and schemas
"**/migrations/**,**/schema/**,*.sql,*.prisma"
```

## Tips for Pattern Matching

1. **Glob Syntax**: Use `*` for any characters, `**` for any directories
2. **Multiple Patterns**: Separate with commas: `"*.ts,*.js"`
3. **Negation**: Use `!` prefix: `"*.ts,!*.test.ts"`
4. **Directories**: Add `/**` suffix: `"src/**/*.ts"`
5. **Exact Names**: No wildcards: `"Dockerfile,Makefile"`

## Testing Patterns

To test if your patterns work correctly:

```bash
# Dry run: check what files will be included
repomix . --include "your-patterns" --no-files --verbose

# Quick test with small output
repomix . --include "your-patterns" --style plain --output test.txt
```
