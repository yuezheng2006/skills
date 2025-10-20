#!/bin/bash
# Extract first N and last N lines of repository code using repomix
# Usage: bash extract-head-tail.sh [directory] [head-lines] [tail-lines] [output-format]
# Defaults: directory=. head-lines=3000 tail-lines=3000 output-format=xml

set -e

# Parse arguments
DIRECTORY="${1:-.}"
HEAD_LINES="${2:-3000}"
TAIL_LINES="${3:-3000}"
FORMAT="${4:-xml}"
TEMP_FILE="repomix-temp-full.$FORMAT"
OUTPUT_FILE="repomix-head-tail.${FORMAT}"

# Validate format
if [[ ! "$FORMAT" =~ ^(xml|markdown|plain)$ ]]; then
    echo "Error: Invalid format '$FORMAT'. Must be one of: xml, markdown, plain"
    exit 1
fi

# Validate line numbers
if ! [[ "$HEAD_LINES" =~ ^[0-9]+$ ]] || ! [[ "$TAIL_LINES" =~ ^[0-9]+$ ]]; then
    echo "Error: Line counts must be positive integers"
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
echo "📊 First $HEAD_LINES lines + Last $TAIL_LINES lines"
echo "📄 Output format: $FORMAT"
echo "💾 Output file: $OUTPUT_FILE"
echo ""

# Step 1: Generate full output to temp file
echo "Step 1/2: Generating full extraction..."
repomix "$DIRECTORY" \
    --style "$FORMAT" \
    --output "$TEMP_FILE" \
    --no-security-check \
    --quiet

# Step 2: Extract head and tail
echo "Step 2/2: Extracting head ($HEAD_LINES) and tail ($TAIL_LINES) lines..."

# Create output with head lines
head -n "$HEAD_LINES" "$TEMP_FILE" > "$OUTPUT_FILE"

# Add separator
echo "" >> "$OUTPUT_FILE"
echo "... [middle section omitted] ..." >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Append tail lines
tail -n "$TAIL_LINES" "$TEMP_FILE" >> "$OUTPUT_FILE"

# Cleanup temp file
rm "$TEMP_FILE"

echo ""
echo "✅ Extraction complete: $OUTPUT_FILE"
echo "   Contains first $HEAD_LINES and last $TAIL_LINES lines"
