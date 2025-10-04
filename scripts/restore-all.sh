#!/bin/bash
# Script untuk restore semua konfigurasi dan data
echo "🔄 Starting restore process..."
# Restore XFCE4 settings
echo "📁 Restoring XFCE4 settings..." if [ -d "backups/xfce4" ]; then 
    mkdir -p $HOME/.config/xfce4 cp -r backups/xfce4/* 
    $HOME/.config/xfce4/ echo "✅ XFCE4 settings restored"
else echo "⚠️ No XFCE4 backup found" fi
# Restore Firefox profile
echo "📁 Restoring Firefox profile..." if [ -d "backups/firefox" ]; then
    # Cari atau buat profile Firefox
    firefox -CreateProfile default 2>/dev/null PROFILE=$(find 
    $HOME/.mozilla/firefox -name "*.default*" -type d | head -n 1)
    
    if [ -n "$PROFILE" ]; then cp -r backups/firefox/* "$PROFILE/" 
        2>/dev/null echo "✅ Firefox profile restored"
    else echo "⚠️ Firefox profile not found" fi else echo "⚠️ No Firefox 
    backup found"
fi
# Restore LibreOffice
echo "📁 Restoring LibreOffice..." if [ -d "backups/libreoffice" ]; then 
    mkdir -p $HOME/.config/libreoffice/4/user cp -r 
    backups/libreoffice/template $HOME/.config/libreoffice/4/user/ 
    2>/dev/null cp -r backups/libreoffice/autotext 
    $HOME/.config/libreoffice/4/user/ 2>/dev/null echo "✅ LibreOffice 
    restored"
else echo "⚠️ No LibreOffice backup found" fi
# Restore GIMP
echo "📁 Restoring GIMP..." if [ -d "backups/gimp" ]; then mkdir -p 
    $HOME/.config/GIMP cp -r backups/gimp/2.10 $HOME/.config/GIMP/ 
    2>/dev/null echo "✅ GIMP settings restored"
else echo "⚠️ No GIMP backup found" fi
# Restore shell configs
echo "📁 Restoring shell configs..." if [ -d "backups/shell" ]; then cp 
    backups/shell/.bashrc $HOME/ 2>/dev/null cp 
    backups/shell/.bash_aliases $HOME/ 2>/dev/null cp 
    backups/shell/.bash_history $HOME/ 2>/dev/null echo "✅ Shell configs 
    restored"
fi
# Restore Desktop
echo "📁 Restoring Desktop..." if [ -d "backups/Desktop" ]; then mkdir -p 
    $HOME/Desktop cp -r backups/Desktop/* $HOME/Desktop/ 2>/dev/null echo 
    "✅ Desktop restored"
fi echo "" echo "✅ Restore completed!" echo "" echo "💡 Logout dan login 
lagi untuk melihat perubahan XFCE"
echo "   Atau restart XFCE: xfce4-session --logout"
