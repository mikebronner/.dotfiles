#!/bin/bash

# set -e  # Exit immediately if a command exits with a non-zero status.

/bin/bash -c "$(curl -fsSL https://php.new/install/mac/8.4)"

php artisan app:install

# REPO_URL="https://github.com/mikebronner/.dotfiles.git"
# INSTALL_DIR="$HOME/.dotfiles"

# install_or_update_git() {
#     if ! command -v git &> /dev/null; then
#         echo "Git is not installed. Installing Git via Xcode Command Line Tools..."
#         xcode-select --install

#         # Wait for the installation to complete
#         echo "Please complete the Xcode Command Line Tools installation."
#         echo "Press any key when the installation is finished..."
#         read -n 1 -s

#         if command -v git &> /dev/null; then
#             echo "Git has been successfully installed."
#         else
#             echo "Git installation failed. Please install Git manually and run this script again."
#             exit 1
#         fi
#     else
#         echo "Git is already installed. Xcode Command Line Tools manages updates automatically."
#     fi
# }
# install_or_update_git

# configure_ssh_and_git() {
#     echo "Configuring SSH keys and Git..."

#     # Ensure .ssh directory exists
#     mkdir -p "$HOME/.ssh"

#     # Add all SSH keys to Apple Keychain
#     for key in "$HOME/.ssh"/*; do
#         if [[ -f "$key" && "$key" != *.pub ]]; then
#             ssh-add --apple-use-keychain "$key"
#             echo "Added SSH key: $key to Apple Keychain"
#         fi
#     done

#     # Configure SSH to use Apple Keychain
#     if ! grep -q "UseKeychain yes" "$HOME/.ssh/config" 2>/dev/null; then
#         echo "UseKeychain yes" >> "$HOME/.ssh/config"
#         echo "AddKeysToAgent yes" >> "$HOME/.ssh/config"
#         echo "Updated ~/.ssh/config to use Apple Keychain"
#     fi

#     # Configure Git to use SSH with Apple Keychain
#     git config --global credential.helper osxkeychain
#     echo "Configured Git to use Apple Keychain for credentials"

#     # Configure Git user information if not already set
#     if [ -z "$(git config --global user.name)" ]; then
#         read -p "Enter your Git username: " git_username
#         git config --global user.name "$git_username"
#     fi

#     if [ -z "$(git config --global user.email)" ]; then
#         read -p "Enter your Git email: " git_email
#         git config --global user.email "$git_email"
#     fi

#     echo "Git configuration complete"
# }
# configure_ssh_and_git

# # Clone the repository if it doesn't exist
# if [ ! -d "$INSTALL_DIR" ]; then
#     echo "Cloning repository..."
#     git clone "$REPO_URL" "$INSTALL_DIR"
#     cd "$INSTALL_DIR"
# else
#     echo "Repository already exists. Updating..."
#     cd "$INSTALL_DIR"
#     git pull
# fi

# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# # Check if zsh is already the default shell
# if [[ $SHELL != */zsh ]]; then
#     echo "Changing default shell to zsh. You may be prompted for your password."
#     chsh -s $(which zsh)
# fi

# # Install Oh My Zsh if not already installed
# if [ ! -d "$HOME/.oh-my-zsh" ]; then
#     echo "Installing Oh My Zsh..."
#     RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
#     # The above command will:
#     # RUNZSH=no : Prevent running zsh after installation
#     # CHSH=no : Prevent changing the default shell
#     # --unattended : Run the installation script in unattended mode
# else
#     echo "Oh My Zsh is already installed"
# fi

# # Function to install a plugin if it's not already installed
# install_plugin() {
#     local repo=$1
#     local dir=$2
#     if [ ! -d "$dir" ]; then
#         echo "Installing $repo"
#         if git clone --depth=1 "https://github.com/$repo.git" "$dir"; then
#             echo "$repo installed successfully"
#         else
#             echo "Failed to install $repo"
#             return 1
#         fi
#     else
#         echo "$repo is already installed"
#     fi
# }
# install_plugin "romkatv/powerlevel10k" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
# install_plugin "zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
# install_plugin "zsh-users/zsh-syntax-highlighting" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
# install_plugin "MichaelAquilina/zsh-you-should-use" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use"
# install_plugin "jessarcher/zsh-artisan" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/artisan"
# # sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
# # sed -i '' 's/^plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use artisan)/' "$HOME/.zshrc"

# # Backup and symlink zsh files
# for file in .zshrc .p10k.zsh; do
#     if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
#         mv "$HOME/$file" "$HOME/${file}.bak.$(date +%Y%m%d%H%M%S)"
#     fi
#     ln -sf "$SCRIPT_DIR/terminal/$file" "$HOME/$file"
# done

# # install MesloLGS fonts
# install_meslo_fonts() {
#     echo "Installing MesloLGS NF fonts..."
#     local font_dir="$HOME/Library/Fonts"
#     mkdir -p "$font_dir"

#     local base_url="https://github.com/romkatv/powerlevel10k-media/raw/master"
#     local fonts=(
#         "MesloLGS NF Regular.ttf"
#         "MesloLGS NF Bold.ttf"
#         "MesloLGS NF Italic.ttf"
#         "MesloLGS NF Bold Italic.ttf"
#     )

#     for font in "${fonts[@]}"; do
#         if [ ! -f "$font_dir/$font" ]; then
#             curl -L "$base_url/${font// /%20}" -o "$font_dir/$font"
#             echo "$font installed."
#         else
#             echo "$font already installed."
#         fi
#     done
#     echo "Please restart your terminal and configure it to use one of the MesloLGS NF fonts."
# }
# install_meslo_fonts

# configure_terminal_app() {
#     echo "Configuring Terminal.app to use MesloLGS NF font and Earthsong theme..."
#     local theme_path="$SCRIPT_DIR/terminal/themes/earthsong.terminal"

#     if [ ! -f "$theme_path" ]; then
#         echo "Earthsong theme file not found at $theme_path. Skipping theme configuration."
#         return
#     fi

#     open "$theme_path"

#     # Import the theme
#     osascript <<EOD
# tell application "Terminal"
#     try
#         set themeName to "Earthsong"
#         set themePath to POSIX file "$theme_path"

#         -- Import the theme if it doesn't exist
#         if not (exists settings set themeName) then
#             try
#                 set newSettings to (read file themePath as «class UTF8»)
#                 set settings set themeName to newSettings
#             on error errMsg
#                 log "Error importing theme: " & errMsg
#                 error "Failed to import theme. Error: " & errMsg
#             end try
#         end if

#         set earthsongSettings to settings set themeName

#         -- Set as default and startup
#         set default settings to earthsongSettings
#         set startup settings to earthsongSettings

#         -- Configure font
#         set font name of earthsongSettings to "MesloLGS NF"
#         set font size of earthsongSettings to 16

#         -- Apply to current windows
#         repeat with w in every window
#             set current settings of tabs of w to earthsongSettings
#         end repeat

#         -- Save changes
#         do shell script "defaults write com.apple.Terminal 'Default Window Settings' -string " & themeName
#         do shell script "defaults write com.apple.Terminal 'Startup Window Settings' -string " & themeName

#         log "Terminal settings updated successfully"
#     on error errMsg
#         log "Error configuring Terminal: " & errMsg
#         error "Failed to configure Terminal. Error: " & errMsg
#     end try
# end tell
# EOD

#     if [ $? -eq 0 ]; then
#         echo "Terminal.app configuration completed successfully."
#     else
#         echo "Error occurred while configuring Terminal.app. Please check the system log for details."
#     fi

#     # Verify the settings
#     echo "Verifying Terminal settings..."
#     osascript <<EOD
# tell application "Terminal"
#     try
#         log "Default settings: " & (name of default settings)
#         log "Startup settings: " & (name of startup settings)
#     on error errMsg
#         log "Error verifying settings: " & errMsg
#     end try
# end tell
# EOD
# }
# configure_terminal_app

# configure_vscode() {
#     echo "Configuring Visual Studio Code..."
#     local vscode_settings="$HOME/Library/Application Support/Code/User/settings.json"

#     # Ensure the directory exists
#     mkdir -p "$(dirname "$vscode_settings")"

#     # If settings.json doesn't exist, create it
#     if [ ! -f "$vscode_settings" ]; then
#         echo "{}" > "$vscode_settings"
#     fi

#     # Use jq to modify or add the required settings
#     if command -v jq >/dev/null 2>&1; then
#         jq '.["terminal.integrated.fontFamily"] = "MesloLGS NF" |
#             .["terminal.integrated.fontSize"] = 16' "$vscode_settings" > "${vscode_settings}.tmp" &&
#         mv "${vscode_settings}.tmp" "$vscode_settings"
#         echo "VS Code settings updated."
#     else
#         echo "jq is not installed. Please install jq or manually update VS Code settings."
#     fi
# }
# configure_vscode

# echo "Installation complete. Please run 'source ~/.zshrc' to apply the changes."
