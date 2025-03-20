# Mike Bronner's 👨‍💻 .dotfiles
One thing that has bugged me for years what keeping all my computers set up the same way for web
development. My goal with this project is to have a single command that will prep any mac for web
development, without me having to worry about getting everything set up.

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
8. Import all SSH keys into Apple Keychain for syncronization and automatic use.

## Other Consideration
- SSH keys are an integral part of any developer's daily routine. To make these sync seamlessly
between all my macs I import them into Apple Keychain and have git access them there automatically.
