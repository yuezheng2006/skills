#!/bin/bash
# Extract repository code with pattern-based filtering using repomix
# Focus on specific file types, directories, or patterns
#
# Usage: bash extract-filtered.sh [directory] [include-patterns] [format] [ignore-patterns]
#
# Parameters:
#   directory (optional): Target directory, defaults to current directory
#   include-patterns (optional): Comma-separated glob patterns to include
#   format (optional): xml, markdown, or plain, defaults to xml
#   ignore-patterns (optional): Additional patterns to exclude
#
# Examples:
#   # TypeScript/React files only
#   bash extract-filtered.sh . "*.ts,*.tsx,*.jsx" markdown
#
#   # Python files, exclude tests
#   bash extract-filtered.sh . "*.py" xml "test_*.py,*_test.py"
#
#   # Specific directory only
#   bash extract-filtered.sh ./src "*.java" markdown
#
#   # All JavaScript with exclusions
#   bash extract-filtered.sh . "*.js,*.jsx" xml "*.test.js,*.spec.js"

set -e

# Parse arguments
DIRECTORY="${1:-.}"
INCLUDE_PATTERNS="${2:-}"
FORMAT="${3:-xml}"
IGNORE_PATTERNS="${4:-}"
OUTPUT_FILE="repomix-filtered.${FORMAT}"

# Validate format
if [[ ! "$FORMAT" =~ ^(xml|markdown|plain)$ ]]; then
    echo "❌ Error: Invalid format '$FORMAT'"
    echo "   Must be one of: xml, markdown, plain"
    exit 1
fi

# Check if repomix is installed
if ! command -v repomix &> /dev/null; then
    echo "❌ Error: repomix is not installed"
    echo ""
    echo "📦 Install repomix:"
    echo "   npm install -g repomix"
    echo ""
    echo "Or use npx (no installation needed):"
    echo "   npx repomix@latest"
    exit 1
fi

# Check if directory exists
if [ ! -d "$DIRECTORY" ]; then
    echo "❌ Error: Directory '$DIRECTORY' does not exist"
    exit 1
fi

# Display extraction info
echo "═══════════════════════════════════════════════════"
echo "  Code Extraction - Pattern Filtered"
echo "═══════════════════════════════════════════════════"
echo ""
echo "📂 Source directory: $DIRECTORY"
if [ -n "$INCLUDE_PATTERNS" ]; then
    echo "✅ Include patterns: $INCLUDE_PATTERNS"
else
    echo "✅ Include patterns: (all files)"
fi
if [ -n "$IGNORE_PATTERNS" ]; then
    echo "❌ Ignore patterns:  $IGNORE_PATTERNS"
fi
echo "📄 Output format:    $FORMAT"
echo "💾 Output file:      $OUTPUT_FILE"
echo ""
echo "💡 Pattern filtering benefits:"
echo "   • Focus on relevant code only"
echo "   • Reduce token count significantly"
echo "   • Faster extraction and analysis"
echo "   • See references/filter-patterns.md for examples"
echo ""
echo "⏳ Extracting filtered code..."
echo ""

# Build repomix command
CMD="repomix \"$DIRECTORY\" --style \"$FORMAT\" --output \"$OUTPUT_FILE\" --no-security-check"

# Add include patterns if provided
if [ -n "$INCLUDE_PATTERNS" ]; then
    CMD="$CMD --include \"$INCLUDE_PATTERNS\""
fi

# Add ignore patterns if provided
if [ -n "$IGNORE_PATTERNS" ]; then
    CMD="$CMD --ignore \"$IGNORE_PATTERNS\""
fi

# Execute command
eval $CMD

echo ""
echo "═══════════════════════════════════════════════════"
echo "✅ Filtered extraction complete!"
echo "═══════════════════════════════════════════════════"
echo ""
echo "📁 Output file: $OUTPUT_FILE"
echo ""
echo "💡 Common pattern examples:"
echo "   Frontend:  \"*.ts,*.tsx,*.jsx,*.css\""
echo "   Backend:   \"*.py,*.sql\" or \"*.go\" or \"*.java\""
echo "   Docs:      \"*.md,*.mdx\""
echo "   Config:    \"*.json,*.yaml,*.yml,*.toml\""
echo ""
echo "🔍 Troubleshooting:"
echo "   • No files? Check pattern syntax (use quotes!)"
echo "   • Too many files? Add ignore patterns"
echo "   • See references/filter-patterns.md for more"
echo ""
