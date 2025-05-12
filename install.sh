#!/bin/bash

set -e

# ===== Nastavení =====
REPO_URL="git@gitlab.com:tvuj-ucet/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
PACKAGES=("nvim" "wezterm" "zsh" "tmux")

# ===== Funkce =====

install_stow() {
  if ! command -v stow &> /dev/null; then
    echo "⚙️ Installing stow via Homebrew..."
    brew install stow
  else
    echo "✅ stow already installed."
  fi
}

clone_repo() {
  if [ ! -d "$DOTFILES_DIR" ]; then
    echo "📦 Cloning dotfiles repo to $DOTFILES_DIR..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
  else
    echo "📂 Dotfiles repo already exists at $DOTFILES_DIR"
  fi
}

run_stow() {
  echo "🔗 Linking config files using stow..."
  cd "$DOTFILES_DIR"
  for package in "${PACKAGES[@]}"; do
    echo "  ➤ stow $package"
    stow "$package"
  done
}

# ===== Spuštění =====

install_stow
clone_repo
run_stow

echo "✅ Dotfiles installed!"

