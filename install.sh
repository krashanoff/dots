#!/bin/sh
#
# TODO: nvm, rustup, rclone, python3, bat, delta
#

REQUIREMENTS_DARWIN="fish neovim rclone"
DRY=""

# Log an error message to stderr.
Logerr() {
  echo "$@" >&2
}

# Run a command. If the dry run option is set, then just
# print it to stdout.
Run() {
  if [ ! -z $DRY ];
  then
    echo "$@"
  else
    $@
  fi
}

# Nvm is weird
InstallNvm() {
  Logerr "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | sh
}

InstallRustup() {
  curl https://sh.rustup.rs -sSf | sh -s
}

InstallDepsLinux() {
  # Ubuntu
  if command -v lsb_release >/dev/null
  then
    # Ubuntu stuff is always outdated, so we have to install a lot
    # of things manually.
    Logerr "Selected Ubuntu"
    Run sudo apt install -y "build-essential"

    # Fish
    Run sudo apt-add-repository ppa:fish-shell/release-3
    Run sudo apt update
    Run sudo apt install fish

    # rclone
    curl https://rclone.org/install.sh | sudo bash

    return
  fi

  Logerr "Failed to select a distribution. Aborting."
  exit 1
}

InstallDepsDarwin() {
  Logerr "Installing Xcode tools."
  Run xcode-select --install

  # Homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  for req in "$REQUIREMENTS_DARWIN"
  do
    Run brew install "$req"
  done
}

# Bootstrap the system with fish shell.
Bootstrap() {
  Logerr "Detecting your platform..."
  case "$(uname)" in
    Darwin)
      Logerr "Selected Darwin"
      InstallDepsDarwin
      ;;
    Linux)
      Logerr "Selected Linux. Investigating distro."
      InstallDepsLinux
      ;;
    *)
      Logerr "Unsupported uname. Aborting."
      exit 1
  esac
}

# Install extra stuff (nvm, rustup, ...)
InstallExtra() {
  Logerr "Installing extra stuff (submodules, etc.)"
  InstallNvm
  InstallRustup

  Logerr "Updating submodules..."
  Run git submodule update --recursive

  Logerr "Installing bass..."
  Run cd fish/bass
  Run make install
}

while [ $# -gt 0 ]
do
  case $1 in
    "-d" | "--dry-run")
      DRY="true"
      ;;
    "--help" | "-h" | *)
      echo "Usage: install.sh [-h]"
      exit 0
      ;;
  esac
  shift
done

Bootstrap
InstallExtra
