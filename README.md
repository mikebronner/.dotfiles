# Mike Bronner's 👨‍💻 .dotfiles
Development configuration and terminal setup.

## Installation

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/mikebronner/.dotfiles/main/install.sh)"
```

## Features

Running the script will perform the following actions:
1. Install xcode-select tools if git is not installed on your system.
2. Set ZSH as your default shell, if it is not set.
3. Install OhMyZsh if it is not installed.
4. Install and enable the following OMZ plugins and theme:
  - Powerlevel10k theme
  - git plugin
  - autosuggestions plugin
  - syntax-highlighting plugin
  - you-should-use plugin
  - artisan plugin
5. Install the Earthsong terminal theme.
6. Install the MesloLGS terminal font.
7. Apply the terminal font configurations to VSCode.
