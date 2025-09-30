#!/bin/bash

# Use: In ~/.zshrc, define alias focus="path/to/this/script.sh"

# AI WROTE THIS DON'T TRUST AT ALL******************************
# wait actually it's stupid simple ignore me ^^

# --- Dummy variables (replace as needed) ---
DEST_DIR="/Users/sethdavidkay/Library/Application Support/dev.focus-editor/projects"
WORKSPACE_PATH="$(pwd)"
APP_PATH="/Applications/Focus.app"
# ------------------------------------------------------

# Ensure destination directory exists
mkdir -p "$DEST_DIR"

# Default filename (basename of workspace)
NEW_FILENAME="$(basename "$WORKSPACE_PATH").focus-config"
DEST_FILE="$DEST_DIR/$NEW_FILENAME"

# Look for an existing file containing our workspace path
EXISTING_FILE="$(grep -l "$WORKSPACE_PATH" "$DEST_DIR"/*.focus-config 2>/dev/null | head -n 1)"

if [ -n "$EXISTING_FILE" ]; then
    DEST_FILE="$EXISTING_FILE"
else
    DEST_FILE="$DEST_DIR/$(basename "$WORKSPACE_PATH").focus-config"

    if [ -e "$DEST_FILE" ]; then
        DEST_FILE="$DEST_DIR/$(echo "$WORKSPACE_PATH" | tr '/' '_').focus-config"
    fi

    if [ ! -e "$DEST_FILE" ]; then
        cat > "$DEST_FILE" <<EOF
[16]  # Version number. Do not delete.

[[workspace]]
$WORKSPACE_PATH
EOF
        fi
fi

# Launch the application with the chosen file
open "$APP_PATH" --args "$DEST_FILE"
