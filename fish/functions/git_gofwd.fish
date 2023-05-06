function git_gofwd
set -l currentBranch (git branch --show-current)
set -l nextBranch (git reflog | sed -n "s|^.*checkout: moving from \(.*\) to $currentBranch\$|\1|p" | grep -v $currentBranch | head -n1)
echo "Moving from $currentBranch to $nextBranch"
git checkout $nextBranch
end
