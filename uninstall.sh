#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Starting uninstallation process..."

# Restore original zsh files
for file in .zshrc .p10k.zsh; do
    if [ -L "$HOME/$file" ]; then
        rm "$HOME/$file"
        echo "Removed symlink for $file"
    fi

    # Restore the most recent backup if it exists
    latest_backup=$(ls -t "$HOME/${file}.bak."* 2>/dev/null | head -n1)
    if [ -n "$latest_backup" ]; then
        mv "$latest_backup" "$HOME/$file"
        echo "Restored $file from backup"
    else
        echo "No backup found for $file"
    fi
done

# Remove installed zsh plugins
remove_plugin() {
    local dir=$1
    if [ -d "$dir" ]; then
        rm -rf "$dir"
        echo "Removed plugin: $dir"
    fi
}

remove_plugin "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/artisan"
remove_plugin "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
remove_plugin "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use"
remove_plugin "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

# Remove MesloLGS NF fonts
remove_meslo_fonts() {
    echo "Removing MesloLGS NF fonts..."
    local font_dir="$HOME/Library/Fonts"
    local fonts=(
        "MesloLGS NF Regular.ttf"
        "MesloLGS NF Bold.ttf"
        "MesloLGS NF Italic.ttf"
        "MesloLGS NF Bold Italic.ttf"
    )

    for font in "${fonts[@]}"; do
        if [ -f "$font_dir/$font" ]; then
            rm "$font_dir/$font"
            echo "$font removed."
        fi
    done
}
remove_meslo_fonts

# Restore Terminal.app settings
restore_terminal_app() {
    echo "Restoring default Terminal.app settings..."
    osascript <<EOD
tell application "Terminal"
    set default settings to settings set "Basic"
end tell
EOD
    echo "Terminal.app settings restored to default."
}
restore_terminal_app

# Restore VS Code settings
restore_vscode() {
    echo "Restoring Visual Studio Code settings..."
    local vscode_settings="$HOME/Library/Application Support/Code/User/settings.json"

    if [ -f "$vscode_settings" ]; then
        if command -v jq >/dev/null 2>&1; then
            jq 'del(.["terminal.integrated.fontFamily"], .["terminal.integrated.fontSize"])' "$vscode_settings" > "${vscode_settings}.tmp" &&
            mv "${vscode_settings}.tmp" "$vscode_settings"
            echo "VS Code settings restored."
        else
            echo "jq is not installed. Please manually remove 'terminal.integrated.fontFamily' and 'terminal.integrated.fontSize' from VS Code settings."
        fi
    else
        echo "VS Code settings file not found. No changes made."
    fi
}
restore_vscode

# Option to uninstall Oh My Zsh
read -p "Do you want to uninstall Oh My Zsh? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f "$HOME/.oh-my-zsh/tools/uninstall.sh" ]; then
        sh "$HOME/.oh-my-zsh/tools/uninstall.sh"
    else
        echo "Oh My Zsh uninstall script not found. Please uninstall manually if needed."
    fi
fi

echo "Uninstallation complete. Please restart your terminal for changes to take effect."
echo "Note: You may need to manually change your shell back to bash if you wish to do so."
