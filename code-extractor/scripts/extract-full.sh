#!/bin/bash
# Extract full repository source code using repomix
# Usage: bash extract-full.sh [directory] [output-format]
# Defaults: directory=. output-format=xml

set -e

# Parse arguments
DIRECTORY="${1:-.}"
FORMAT="${2:-xml}"
OUTPUT_FILE="repomix-output.${FORMAT}"

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

echo "🔍 Extracting code from: $DIRECTORY"
echo "📄 Output format: $FORMAT"
echo "💾 Output file: $OUTPUT_FILE"
echo ""

# Run repomix
repomix "$DIRECTORY" \
    --style "$FORMAT" \
    --output "$OUTPUT_FILE" \
    --no-security-check

echo ""
echo "✅ Extraction complete: $OUTPUT_FILE"
