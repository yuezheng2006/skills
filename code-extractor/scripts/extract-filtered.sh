#!/bin/bash
# Extract repository code with pattern-based filtering using repomix
# Usage: bash extract-filtered.sh [directory] [include-patterns] [output-format] [ignore-patterns]
# Defaults: directory=. include-patterns="" output-format=xml ignore-patterns=""

set -e

# Parse arguments
DIRECTORY="${1:-.}"
INCLUDE_PATTERNS="${2:-}"
FORMAT="${3:-xml}"
IGNORE_PATTERNS="${4:-}"
OUTPUT_FILE="repomix-filtered.${FORMAT}"

# Validate format
if [[ ! "$FORMAT" =~ ^(xml|markdown|plain)$ ]]; then
    echo "Error: Invalid format '$FORMAT'. Must be one of: xml, markdown, plain"
    exit 1
fi

# Check if repomix is installed
if ! command -v repomix &> /dev/null; then
    echo "Error: repomix is not installed"
    echo "Install with: npm install -g repomix"
    echo "Or use: npx repomix@latest"
    exit 1
fi

# Check if directory exists
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory '$DIRECTORY' does not exist"
    exit 1
fi

echo "🔍 Extracting filtered code from: $DIRECTORY"
if [ -n "$INCLUDE_PATTERNS" ]; then
    echo "✅ Include patterns: $INCLUDE_PATTERNS"
fi
if [ -n "$IGNORE_PATTERNS" ]; then
    echo "❌ Ignore patterns: $IGNORE_PATTERNS"
fi
echo "📄 Output format: $FORMAT"
echo "💾 Output file: $OUTPUT_FILE"
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
echo "✅ Filtered extraction complete: $OUTPUT_FILE"
