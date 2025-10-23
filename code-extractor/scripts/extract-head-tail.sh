#!/bin/bash
# Extract first N and last N lines of repository code using repomix
# Useful for quick codebase overview without processing full repository
#
# Usage: bash extract-head-tail.sh [directory] [head-lines] [tail-lines] [format]
#
# Parameters:
#   directory (optional): Target directory, defaults to current directory
#   head-lines (optional): Lines from start, defaults to 3000
#   tail-lines (optional): Lines from end, defaults to 3000
#   format (optional): xml, markdown, or plain, defaults to xml
#
# Examples:
#   bash extract-head-tail.sh                   # 3000+3000 lines, XML
#   bash extract-head-tail.sh . 5000 2000       # 5000+2000 lines, XML
#   bash extract-head-tail.sh . 3000 3000 markdown  # 3000+3000, Markdown

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
    echo "❌ Error: Invalid format '$FORMAT'"
    echo "   Must be one of: xml, markdown, plain"
    exit 1
fi

# Validate line numbers
if ! [[ "$HEAD_LINES" =~ ^[0-9]+$ ]] || ! [[ "$TAIL_LINES" =~ ^[0-9]+$ ]]; then
    echo "❌ Error: Line counts must be positive integers"
    echo "   HEAD_LINES: $HEAD_LINES, TAIL_LINES: $TAIL_LINES"
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
echo "  Code Extraction - Head & Tail"
echo "═══════════════════════════════════════════════════"
echo ""
echo "📂 Source directory: $DIRECTORY"
echo "📊 Extraction scope: First $HEAD_LINES + Last $TAIL_LINES lines"
echo "📄 Output format:    $FORMAT"
echo "💾 Output file:      $OUTPUT_FILE"
echo ""
echo "💡 Why head/tail extraction?"
echo "   • Faster than full extraction"
echo "   • Captures entry points (head) and core logic (tail)"
echo "   • Perfect for quick codebase overview"
echo ""
echo "⏳ Step 1/2: Generating full extraction (temp)..."
echo ""

# Step 1: Generate full output to temp file
repomix "$DIRECTORY" \
    --style "$FORMAT" \
    --output "$TEMP_FILE" \
    --no-security-check \
    --quiet

echo "⏳ Step 2/2: Extracting head and tail sections..."
echo ""

# Get total line count
TOTAL_LINES=$(wc -l < "$TEMP_FILE" | tr -d ' ')

# Create output with head lines
head -n "$HEAD_LINES" "$TEMP_FILE" > "$OUTPUT_FILE"

# Calculate omitted lines
OMITTED_LINES=$((TOTAL_LINES - HEAD_LINES - TAIL_LINES))

# Add separator
echo "" >> "$OUTPUT_FILE"
if [ $OMITTED_LINES -gt 0 ]; then
    echo "═══════════════════════════════════════════════════" >> "$OUTPUT_FILE"
    echo " [MIDDLE SECTION OMITTED: $OMITTED_LINES lines]" >> "$OUTPUT_FILE"
    echo "═══════════════════════════════════════════════════" >> "$OUTPUT_FILE"
else
    echo "[No omitted content - file smaller than head+tail]" >> "$OUTPUT_FILE"
fi
echo "" >> "$OUTPUT_FILE"

# Append tail lines
tail -n "$TAIL_LINES" "$TEMP_FILE" >> "$OUTPUT_FILE"

# Cleanup temp file
rm "$TEMP_FILE"

# Calculate final size
FINAL_LINES=$(wc -l < "$OUTPUT_FILE" | tr -d ' ')

echo "═══════════════════════════════════════════════════"
echo "✅ Extraction complete!"
echo "═══════════════════════════════════════════════════"
echo ""
echo "📁 Output file:    $OUTPUT_FILE"
echo "📊 Total lines:    $FINAL_LINES (from $TOTAL_LINES original)"
echo "📉 Reduction:      $OMITTED_LINES lines omitted"
echo ""
echo "📖 Content structure:"
echo "   ├─ Head section: First $HEAD_LINES lines"
echo "   ├─ Separator:    Omitted content marker"
echo "   └─ Tail section: Last $TAIL_LINES lines"
echo ""
echo "💡 Next steps:"
echo "   • Review file for codebase overview"
echo "   • Adjust line counts if needed"
echo "   • Use full extraction for complete analysis"
echo ""
