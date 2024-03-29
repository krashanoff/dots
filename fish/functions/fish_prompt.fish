function fish_prompt
    set -l cyan (set_color -o cyan)
    set -l yellow (set_color -o yellow)
    set -l red (set_color -o red)
    set -l green (set_color -o green)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)

    set -l is_root (id -u)
    if test $is_root = 0
        set arrow "$arrow_color# "
    end

    set -l cwd $cyan(string shorten -m 45 (prompt_pwd -d 1))

    set -l k8info
    if test -e $HOME/.current_kubectx; and test -e $HOME/.current_kubens
        set -l k8nsinfo
        set -l k8info "["$blue(string shorten --left --max 40 (string split '_' (cat $HOME/.current_kubectx))[-1])$normal
        set -l k8nsinfo (string join '-' (string split '-' (cat $HOME/.current_kubens))[-3..-1])
        set -l k8info $k8info"/"$green(string shorten --left --max 30 $k8nsinfo)$normal"]"
        echo -s $k8info $repo_info
    end

    switch $HOST_TYPE
        case "debian"
            set hostname_parts (string split . (hostname))
        case '*'
            set hostname_parts (string split . (hostname))
    end
    set -l whoami_part $cyan(whoami)
    set user_part $whoami_part$normal@$blue$hostname_parts[1]

    set -l prompt $user_part$normal':'$green$cwd
    if set -q $k8info
        set prompt "$prompt $repo_info"
    end
    set prompt $prompt$normal ' '
    echo -n -s $prompt
end
