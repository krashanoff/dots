function git_branchstack
set show_n 5
if count $argv >/dev/null
set -f show_n $argv[1]
end
git reflog | sed -n "s|^.*checkout: moving from \(.*\) to \(.*\)\$|\1 -> \2|p" | head -n$show_n
end
