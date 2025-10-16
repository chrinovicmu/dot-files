#!/bin/bash
# File: test_lsp.sh
# Run this script to diagnose LSP issues

echo "=== LSP Diagnostic Script ==="
echo ""

echo "1. Checking if clangd is installed..."
if command -v clangd &>/dev/null; then
    echo "   ✓ clangd found at: $(which clangd)"
    clangd --version | head -1
else
    echo "   ✗ clangd NOT FOUND"
    echo "   Install with: sudo apt install clangd (or use :Mason in Neovim)"
fi
echo ""

echo "2. Checking current directory for root markers..."
for marker in .clangd .clang-tidy .clang-format compile_commands.json compile_flags.txt .git; do
    if [ -e "$marker" ]; then
        echo "   ✓ Found: $marker"
    else
        echo "   ✗ Missing: $marker"
    fi
done
echo ""

echo "3. Checking Neovim LSP config..."
if [ -f "$HOME/.config/nvim/lua/plugins/lsp.lua" ]; then
    echo "   ✓ LSP config exists"
else
    echo "   ✗ LSP config not found"
fi
echo ""

echo "=== Recommendations ==="
echo "If clangd is not installed: run :Mason in Neovim and install clangd"
echo "If no root markers found: run 'git init' or 'touch .clangd' in your project"
