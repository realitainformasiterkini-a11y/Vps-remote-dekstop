#!/bin/bash
# Auto-run after Codespace created
echo "🚀 Setting up environment..."
# Make scripts executable
chmod +x scripts/*.sh
# Restore all settings
bash scripts/restore-all.sh echo "" echo "✅ Environment ready!" echo "" 
echo "📝 Available commands:" echo " backup-all : bash 
scripts/backup-all.sh"
echo "   restore-all : bash scripts/restore-all.sh"
