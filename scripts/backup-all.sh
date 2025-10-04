#!/bin/bash
# Script untuk backup semua konfigurasi dan data
echo "🔄 Starting backup process..."
# Backup XFCE4 settings
echo "📁 Backing up XFCE4 settings..." if [ -d "$HOME/.config/xfce4" ]; 
then
    mkdir -p backups/xfce4 cp -r $HOME/.config/xfce4/* backups/xfce4/ 
    echo "✅ XFCE4 settings backed up"
else echo "⚠️ XFCE4 config not found" fi
# Backup Firefox profile (tanpa cache dan temporary files)
echo "📁 Backing up Firefox profile..." if [ -d "$HOME/.mozilla/firefox" 
]; then
    mkdir -p backups/firefox
    # Cari profile default
    PROFILE=$(find $HOME/.mozilla/firefox -name "*.default*" -type d | 
    head -n 1) if [ -n "$PROFILE" ]; then
        # Backup hanya file penting, skip cache
        cp -r "$PROFILE/bookmarkbackups" backups/firefox/ 2>/dev/null cp 
        "$PROFILE/places.sqlite" backups/firefox/ 2>/dev/null cp 
        "$PROFILE/prefs.js" backups/firefox/ 2>/dev/null cp 
        "$PROFILE/extensions.json" backups/firefox/ 2>/dev/null echo "✅ 
        Firefox profile backed up"
    fi else echo "⚠️ Firefox profile not found" fi
# Backup LibreOffice templates dan settings
echo "📁 Backing up LibreOffice..." if [ -d "$HOME/.config/libreoffice" 
]; then
    mkdir -p backups/libreoffice cp -r 
    $HOME/.config/libreoffice/4/user/template backups/libreoffice/ 
    2>/dev/null cp -r $HOME/.config/libreoffice/4/user/autotext 
    backups/libreoffice/ 2>/dev/null echo "✅ LibreOffice backed up"
else echo "⚠️ LibreOffice config not found" fi
# Backup GIMP settings
echo "📁 Backing up GIMP..." if [ -d "$HOME/.config/GIMP" ]; then mkdir 
    -p backups/gimp cp -r $HOME/.config/GIMP/2.10 backups/gimp/ 
    2>/dev/null echo "✅ GIMP settings backed up"
else echo "⚠️ GIMP config not found" fi
# Backup bash history dan custom configs
echo "�� Backing up shell configs..." mkdir -p backups/shell cp 
$HOME/.bashrc backups/shell/ 2>/dev/null cp $HOME/.bash_aliases 
backups/shell/ 2>/dev/null cp $HOME/.bash_history backups/shell/ 
2>/dev/null
# Backup Desktop files
echo "📁 Backing up Desktop..." if [ -d "$HOME/Desktop" ]; then mkdir -p 
    backups/Desktop cp -r $HOME/Desktop/* backups/Desktop/ 2>/dev/null
fi echo "✅ Backup completed!" echo "" echo "📊 Backup Summary:" du -sh 
backups/* 2>/dev/null echo ""
echo "💡 Next step: git add backups/ && git commit -m 'Backup settings' && git push"
