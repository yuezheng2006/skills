#!/bin/bash
# Extract full repository source code using repomix
# Automatically excludes non-code files (dependencies, build artifacts, configs)
#
# Usage: bash extract-full.sh [directory] [format] [options]
#
# Parameters:
#   directory (optional): Target directory, defaults to current directory
#   format (optional): xml, markdown, or plain, defaults to xml
#   options (optional): Additional repomix flags (e.g., --compress --remove-comments)
#
# Examples:
#   bash extract-full.sh                        # Current dir, XML format
#   bash extract-full.sh . markdown             # Current dir, Markdown
#   bash extract-full.sh ./backend xml          # Backend dir, XML
#   bash extract-full.sh . markdown --compress  # With compression

set -e

# Parse arguments
DIRECTORY="${1:-.}"
FORMAT="${2:-xml}"
shift 2 2>/dev/null || shift $# # Remove first 2 args, keep rest as options
EXTRA_OPTIONS="$@"

# Output filename
OUTPUT_FILE="repomix-output.${FORMAT}"

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
echo "  Code Extraction - Full Repository"
echo "═══════════════════════════════════════════════════"
echo ""
echo "📂 Source directory: $DIRECTORY"
echo "📄 Output format:    $FORMAT"
echo "💾 Output file:      $OUTPUT_FILE"
if [ -n "$EXTRA_OPTIONS" ]; then
    echo "⚙️  Extra options:    $EXTRA_OPTIONS"
fi
echo ""
echo "🔧 Automatic exclusions:"
echo "   ├─ Dependencies (node_modules, vendor, .venv)"
echo "   ├─ Build outputs (dist, build, out, target)"
echo "   ├─ IDE configs (.vscode, .idea)"
echo "   └─ Version control (.git, .svn)"
echo ""
echo "⏳ Extracting code..."
echo ""

# Run repomix with all options
repomix "$DIRECTORY" \
    --style "$FORMAT" \
    --output "$OUTPUT_FILE" \
    --no-security-check \
    $EXTRA_OPTIONS

echo ""
echo "═══════════════════════════════════════════════════"
echo "✅ Extraction complete!"
echo "═══════════════════════════════════════════════════"
echo ""
echo "📁 Output file: $OUTPUT_FILE"
echo ""
echo "💡 Next steps:"
echo "   • Review file summary for token count"
echo "   • Check directory structure for completeness"
echo "   • Use for AI analysis or documentation"
echo ""
echo "🔧 Advanced options:"
echo "   --compress             Reduce token count (30-50%)"
echo "   --remove-comments      Strip code comments"
echo "   --remove-empty-lines   Remove blank lines"
echo "   --copy                 Copy to clipboard"
echo ""
