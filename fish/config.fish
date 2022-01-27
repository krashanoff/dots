set fish_greeting

# Config
set -Ux XDG_CONFIG_HOME $HOME/.config

# Homebrew
if test (uname) = "Darwin"
	eval (/opt/homebrew/bin/brew shellenv)
end
set -Ux EDITOR nvim

# Rust
set -Ux fish_user_paths $HOME/.cargo/bin

