#!/bin/bash

set -e

BINARY_NAME="gub"
INSTALL_DIR="$HOME/.local/bin"
BINARY_URL="https://github.com/kayesFerdous/test/releases/download/v1.0.0/$BINARY_NAME"

echo "📦 Downloading $BINARY_NAME from GitHub..."
mkdir -p "$INSTALL_DIR"
curl -L "$BINARY_URL" -o "$INSTALL_DIR/$BINARY_NAME"

echo "🔧 Making it executable..."
chmod +x "$INSTALL_DIR/$BINARY_NAME"

# Check if INSTALL_DIR is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "➕ $INSTALL_DIR is not in your PATH."
    SHELL_NAME=$(basename "$SHELL")
    if [ "$SHELL_NAME" = "zsh" ]; then
        SHELL_RC="$HOME/.zshrc"
    else
        SHELL_RC="$HOME/.bashrc"
    fi

    echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$SHELL_RC"
    echo "✅ Added $INSTALL_DIR to PATH in $SHELL_RC"
    echo "👉 Please restart your terminal or run: source $SHELL_RC"
else
    echo "✅ $INSTALL_DIR is already in your PATH"
fi

echo "🚀 Done! Now you can run: $BINARY_NAME"
