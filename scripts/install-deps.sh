#!/usr/bin/env bash
# Install Neovim config dependencies
#
# Usage:
#   ./scripts/install-deps.sh                  # Core + recommended only
#   ./scripts/install-deps.sh --all            # Everything including all toolchains
#   ./scripts/install-deps.sh --help

set -euo pipefail

INSTALL_ALL=false
for arg in "$@"; do
  case $arg in
    --all)   INSTALL_ALL=true ;;
    --help)
      echo "Usage: $0 [--all]"
      echo ""
      echo "  (no flags)  Install core dependencies only"
      echo "  --all       Also install all language toolchains"
      exit 0
      ;;
  esac
done

# ── Helpers ──────────────────────────────────────────────────────────────────

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${GREEN}[+]${NC} $*"; }
warn()    { echo -e "${YELLOW}[!]${NC} $*"; }
section() { echo ""; echo -e "${GREEN}━━━ $* ━━━${NC}"; }

has() { command -v "$1" &>/dev/null; }

# Detect package manager
if has apt-get; then
  PM="apt"
elif has dnf; then
  PM="dnf"
elif has pacman; then
  PM="pacman"
elif has brew; then
  PM="brew"
else
  echo -e "${RED}[!] Unsupported package manager. Install dependencies manually.${NC}"
  exit 1
fi

pkg_install() {
  case $PM in
    apt)    sudo apt-get install -y "$@" ;;
    dnf)    sudo dnf install -y "$@" ;;
    pacman) sudo pacman -S --noconfirm "$@" ;;
    brew)   brew install "$@" ;;
  esac
}

# ── Neovim ────────────────────────────────────────────────────────────────────

section "Neovim"
if has nvim; then
  NVIM_VER=$(nvim --version | head -1)
  warn "Neovim already installed: $NVIM_VER"
  warn "This config requires 0.10+. Upgrade if needed:"
  warn "  https://github.com/neovim/neovim/releases/latest"
else
  info "Installing Neovim..."
  case $PM in
    apt)
      # Use AppImage for latest stable on Ubuntu/Debian
      curl -fsSL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage \
        -o /tmp/nvim.appimage
      chmod +x /tmp/nvim.appimage
      sudo mv /tmp/nvim.appimage /usr/local/bin/nvim
      ;;
    dnf)     sudo dnf install -y neovim ;;
    pacman)  sudo pacman -S --noconfirm neovim ;;
    brew)    brew install neovim ;;
  esac
  info "Neovim installed: $(nvim --version | head -1)"
fi

# ── Core dependencies ─────────────────────────────────────────────────────────

section "Core Dependencies"

install_core() {
  case $PM in
    apt)
      sudo apt-get update -q
      pkg_install git ripgrep fd-find curl unzip wget
      # fd is installed as fdfind on Debian/Ubuntu — symlink if needed
      if has fdfind && ! has fd; then
        sudo ln -sf "$(which fdfind)" /usr/local/bin/fd
        info "Symlinked fdfind -> fd"
      fi
      ;;
    dnf)    pkg_install git ripgrep fd-find curl unzip wget ;;
    pacman) pkg_install git ripgrep fd curl unzip wget ;;
    brew)   pkg_install git ripgrep fd curl ;;
  esac
}

for dep in git rg fd curl unzip; do
  if has "$dep"; then
    info "$dep already installed"
  else
    warn "$dep not found — will be installed below"
  fi
done

install_core
info "Core dependencies installed"

# ── Node.js ───────────────────────────────────────────────────────────────────

section "Node.js (required for Copilot and many LSPs)"
if has node; then
  info "Node.js already installed: $(node --version)"
else
  info "Installing Node.js via nvm..."
  # NOTE: Pin this to the latest nvm release. Check https://github.com/nvm-sh/nvm/releases
  # and update the version below periodically.
  NVM_VERSION="v0.39.7"
  curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
  export NVM_DIR="$HOME/.nvm"
  # shellcheck source=/dev/null
  source "$NVM_DIR/nvm.sh"
  nvm install --lts
  nvm use --lts
  info "Node.js installed: $(node --version)"
fi

# ── Python ────────────────────────────────────────────────────────────────────

section "Python"
if has python3; then
  info "Python already installed: $(python3 --version)"
else
  case $PM in
    apt)    pkg_install python3 python3-pip python3-venv ;;
    dnf)    pkg_install python3 python3-pip ;;
    pacman) pkg_install python python-pip ;;
    brew)   pkg_install python ;;
  esac
  info "Python installed: $(python3 --version)"
fi

# Python neovim package (required for some plugins)
if has pip3; then
  pip3 install --user --quiet pynvim
  info "pynvim installed"
elif has pip; then
  pip install --user --quiet pynvim
  info "pynvim installed"
fi

# ── Nerd Font ─────────────────────────────────────────────────────────────────

section "Nerd Font (JetBrainsMono)"
FONT_DIR="$HOME/.local/share/fonts"
if fc-list | grep -qi "JetBrainsMono"; then
  info "JetBrainsMono Nerd Font already installed"
else
  info "Installing JetBrainsMono Nerd Font..."
  mkdir -p "$FONT_DIR"
  curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" \
    -o /tmp/JetBrainsMono.zip
  unzip -q /tmp/JetBrainsMono.zip -d "$FONT_DIR/JetBrainsMono"
  rm /tmp/JetBrainsMono.zip
  fc-cache -f "$FONT_DIR"
  info "JetBrainsMono Nerd Font installed (set it in your terminal)"
fi

# ── Optional: sqlite (NeoComposer macros) ─────────────────────────────────────

section "SQLite (optional — for NeoComposer macro recording)"
if has sqlite3; then
  info "sqlite3 already installed"
else
  case $PM in
    apt)    pkg_install libsqlite3-dev ;;
    dnf)    pkg_install sqlite-devel ;;
    pacman) pkg_install sqlite ;;
    brew)   pkg_install sqlite ;;
  esac
  info "sqlite3 installed"
fi

# ── Optional: yazi (file manager) ────────────────────────────────────────────

section "Yazi (optional — terminal file manager)"
if has yazi; then
  info "yazi already installed"
else
  case $PM in
    apt|dnf)
      info "Installing yazi via cargo..."
      if has cargo; then
        cargo install --locked yazi-fm
        info "yazi installed"
      else
        warn "cargo not found — install Rust first or see: https://yazi-rs.github.io/docs/installation"
      fi
      ;;
    pacman) pkg_install yazi ;;
    brew)   pkg_install yazi ;;
  esac
fi

# ── Language toolchains (--all only) ─────────────────────────────────────────

if [[ "$INSTALL_ALL" == "true" ]]; then

  section "Go"
  if has go; then
    info "Go already installed: $(go version)"
  else
    info "Installing Go..."
    case $PM in
      apt|dnf) pkg_install golang ;;
      pacman)  pkg_install go ;;
      brew)    pkg_install go ;;
    esac
  fi

  section "Rust"
  if has cargo; then
    info "Rust already installed: $(rustc --version)"
  else
    info "Installing Rust via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # shellcheck source=/dev/null
    source "$HOME/.cargo/env"
    info "Rust installed: $(rustc --version)"
  fi

  section "Java"
  if has java; then
    info "Java already installed: $(java --version 2>&1 | head -1)"
  else
    case $PM in
      apt)    pkg_install default-jdk ;;
      dnf)    pkg_install java-latest-openjdk ;;
      pacman) pkg_install jdk-openjdk ;;
      brew)   pkg_install openjdk ;;
    esac
  fi

  section ".NET (C#)"
  if has dotnet; then
    info ".NET already installed: $(dotnet --version)"
  else
    case $PM in
      apt)
        pkg_install dotnet-sdk-8.0 || \
          warn ".NET not in apt — see: https://learn.microsoft.com/dotnet/core/install/linux"
        ;;
      dnf)    pkg_install dotnet-sdk-8.0 ;;
      pacman) pkg_install dotnet-sdk ;;
      brew)   pkg_install dotnet ;;
    esac
  fi

  section "GCC / Clang (C, C++, CUDA)"
  case $PM in
    apt)    pkg_install gcc g++ clang clang-format cmake ;;
    dnf)    pkg_install gcc gcc-c++ clang clang-tools-extra cmake ;;
    pacman) pkg_install gcc clang cmake ;;
    brew)   pkg_install llvm cmake ;;
  esac
  info "C/C++ toolchain installed"

  section "Zig"
  if has zig; then
    info "Zig already installed: $(zig version)"
  else
    case $PM in
      apt|dnf) warn "Zig not in package manager — see: https://ziglang.org/download/" ;;
      pacman)  pkg_install zig ;;
      brew)    pkg_install zig ;;
    esac
  fi

  section "Haskell (GHCup)"
  if has ghcup; then
    info "GHCup already installed"
  else
    info "Installing GHCup..."
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
  fi

  section "OCaml (opam)"
  if has opam; then
    info "opam already installed"
  else
    case $PM in
      apt)    pkg_install opam ;;
      dnf)    pkg_install opam ;;
      pacman) pkg_install opam ;;
      brew)   pkg_install opam ;;
    esac
  fi

  section "Ruby"
  if has ruby; then
    info "Ruby already installed: $(ruby --version)"
  else
    case $PM in
      apt)    pkg_install ruby ruby-dev ;;
      dnf)    pkg_install ruby ruby-devel ;;
      pacman) pkg_install ruby ;;
      brew)   pkg_install ruby ;;
    esac
  fi

  section "Elixir"
  if has elixir; then
    info "Elixir already installed: $(elixir --version | head -1)"
  else
    case $PM in
      apt)    pkg_install elixir ;;
      dnf)    pkg_install elixir ;;
      pacman) pkg_install elixir ;;
      brew)   pkg_install elixir ;;
    esac
  fi

  section "R"
  if has R; then
    info "R already installed: $(R --version | head -1)"
  else
    case $PM in
      apt)    pkg_install r-base ;;
      dnf)    pkg_install R ;;
      pacman) pkg_install r ;;
      brew)   pkg_install r ;;
    esac
  fi

  section "Terraform"
  if has terraform; then
    info "Terraform already installed: $(terraform --version | head -1)"
  else
    case $PM in
      apt)
        wget -qO- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
          | sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt-get update -q && pkg_install terraform
        ;;
      dnf)    pkg_install terraform ;;
      pacman) pkg_install terraform ;;
      brew)   pkg_install terraform ;;
    esac
  fi

fi  # --all

# ── Summary ───────────────────────────────────────────────────────────────────

section "Summary"
for dep in nvim git rg fd node python3 sqlite3 yazi; do
  if has "$dep"; then
    info "$dep ✓"
  else
    warn "$dep not found"
  fi
done

echo ""
info "Done! Next steps:"
echo "  1. Launch Neovim: nvim"
echo "  2. Wait for plugins to install (lazy.nvim will auto-install on first launch)"
echo "  3. Run :checkhealth config  to verify everything is working"
echo "  4. Run :Mason               to install LSP servers for your languages"
if [[ "$INSTALL_ALL" != "true" ]]; then
  echo ""
  warn "Run with --all to also install language toolchains (Go, Rust, Java, etc.)"
fi
