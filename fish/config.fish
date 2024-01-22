# Config
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux EDITOR nvim

# Try our best to ID the host
set -g HOST_TYPE "idk"
if test (uname) = "Darwin"
    set -g HOST_TYPE "mac"
else if test -e /etc/debian_version
    set -g HOST_TYPE "debian"
end

# Homebrew
if [ "$HOST_TYPE" = "mac" ]
    eval (/opt/homebrew/bin/brew shellenv)
end

# Toolchain miscellanea
fish_add_path -Up $HOME/.cargo/bin
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/leo/.ghcup/bin $PATH # ghcup-env

if not test -e $HOME/.asdf/asdf.fish
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
end
source $HOME/.asdf/asdf.fish
mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions >/dev/null 2>&1

# pnpm
if [ "$HOST_TYPE" = 'mac' ]
    set -Ux PNPM_HOME "/Users/leo/Library/pnpm"
else
    set -Ux PNPM_HOME "~/.pnpm"
end
if not string match -q -- $PNPM_HOME $PATH
  fish_add_path -Up "$PNPM_HOME"
end

# Vars
test -f ~/.config/fish/kuebctl_aliases.fish && source ~/.config/fish/kuebctl_aliases.fish

# Abbreviations are useful :)
function aa
    abbr --add $argv
end

aa lsal ls -al

# git stuff
aa lg lazygit
aa g git status
aa ga git add
aa gaa git add --all
aa gb git branch
aa gbm git branch -m
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
aa gpunv git push --no-verify
aa gpnv git push --no-verify
aa gpufnv git push --force --no-verify
aa gra git remote add
aa gmc git merge --continue
aa gmcnv git merge --continue --no-verify
aa gcnv git commit --no-verify
aa grbiom git rebase -i origin/master
aa gcamm git commit --amend
aa grbom git rebase origin/master
aa gcpc git cherry-pick --continue

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
aa nvd neovide --multigrid
aa gpfo git push --force origin

# Need to add handlers to the config file instead of autoload
function kube_change --on-event kubectx_postexec
    echo -ns (/opt/homebrew/bin/kubectx -c) > $HOME/.current_kubectx
    echo -ns (/opt/homebrew/bin/kubens -c) > $HOME/.current_kubens
end

# kubectl stuff that isn't normally there.
aa kgjo kubectl get jobs
aa kgjob kubectl get jobs
aa kgjobs kubectl get jobs
aa kgpooname kubectl get pods -o=name
aa gcauadsqp gcloud auth application-default set-quota-project
aa gc gcloud

aa win whatsin

