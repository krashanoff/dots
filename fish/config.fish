set fish_greeting

# Config
set -Ux XDG_CONFIG_HOME $HOME/.config

# Homebrew
if test (uname) = "Darwin"
	eval (/opt/homebrew/bin/brew shellenv)
end

# Rust
set -Ux fish_user_paths $HOME/.cargo/bin

# Vars
set -Ux EDITOR nvim
source /opt/homebrew/opt/asdf/libexec/asdf.fish

test -f ~/.kubectl_aliases.fish && source ~/.kubectl_aliases.fish
glab completion -s fish | source

# Abbreviations
function aa
	abbr --add $argv
end
aa kx kubectx
aa kcx kubectx
aa kns kubens
aa ks kubens
aa kn kubens

aa hl helm list
aa hla helm list --all
aa hrb helm rollback
aa hs helm show
aa hse helm search
aa hh helm history

# Need to add handlers to the config file instead of autoload
function kube_change --on-event kubectx_postexec
	echo -ns (/opt/homebrew/bin/kubectx -c) > $HOME/.current_kubectx
	echo -ns (/opt/homebrew/bin/kubens -c) > $HOME/.current_kubens
end

