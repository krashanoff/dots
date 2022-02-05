#!/bin/sh
#
# TODO: nvm, rustup, rclone, python3
#

REQUIREMENTS_UBUNTU="build-essential fish neovim"
REQUIREMENTS_DARWIN="fish neovim"
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

InstallDepsLinux() {
  # Ubuntu
  if command -v lsb_release >/dev/null
  then
    Logerr "Selected Ubuntu"
    Run sudo apt install -y "$REQUIREMENTS_DARWIN"
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

InstallDeps() {
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

InstallExtra() {
  Logerr "Installing extra stuff (submodules, etc.)"

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

InstallDeps
InstallExtra
