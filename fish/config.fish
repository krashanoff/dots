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

test -f ~/.kubectl_aliases.fish && source ~/.kubectl_aliases.fish

if command -sq glab
	glab completion -s fish | source
end

# Abbreviations
function aa
	abbr --add $argv
end

# git stuff
aa lg lazygit
aa g git status
aa lsal ls -al
aa ga git add
aa gaa git add --all
aa gb git branch
aa gbm git branch -m
aa gc git commit
aa gca git commit -a
aa gcam git commit -am
aa gcamne git commit --amend --no-edit
aa gcamnea git commit --amend --no-edit -a
aa gcm git commit -m
aa gco git checkout
aa gcob git checkout -b
aa gcog git checkout --guess
aa gcom git checkout master
aa gcong git checkout --no-guess
aa gcp git cherry-pick
aa gd git diff
aa gdno git diff --name-only
aa gf git fetch
aa gl git log
aa glg git log --graph
aa gm git merge
aa gp git pull
aa gpu git push
aa gpuuo git push -u origin
aa gr git reset
aa grb git rebase
aa grbab git rebase --abort
aa grbc git rebase --continue
aa grbcne git rebase --continue --no-edit
aa grbi git rebase -i
aa gre git remote
aa gres git remote show
aa grf git reflog
aa grs git reset --soft
aa gs git status
aa gsm git submodule
aa gsmi git submodule init
aa gsmu git submodule update
aa gsmui git submodule update --init
aa gsmuir git submodule update --init --recursive
aa gss git status --short
aa gst git stash
aa gstp git stash pop
aa gw git whatchanged

# shortcuts that aren't added by kubectl_aliases
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

aa guivm neovide --multigrid

# Need to add handlers to the config file instead of autoload
function kube_change --on-event kubectx_postexec
	echo -ns (/opt/homebrew/bin/kubectx -c) > $HOME/.current_kubectx
	echo -ns (/opt/homebrew/bin/kubens -c) > $HOME/.current_kubens
end

source $HOME/.asdf/asdf.fish
mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions >/dev/null 2>&1

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/leo/.ghcup/bin $PATH # ghcup-env

aa --add gcom git checkout master

# pnpm
set -gx PNPM_HOME "/Users/leo/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
#pnpm end

