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
        set k8nsinfo
        set k8info "["$blue(string shorten --left --max 40 (string split '_' (cat $HOME/.current_kubectx))[-1])$normal
        set  k8nsinfo (string join '-' (string split '-' (cat $HOME/.current_kubens))[-3..-1])
        set k8info $k8info"/"$green(string shorten --left --max 30 $k8nsinfo)$normal"]"
    end

    switch $HOST_TYPE
        case "debian"
            set hostname_parts (string split . (hostname))
        case '*'
            set hostname_parts (string split . (hostname))
    end
    set -l whoami_part $cyan(whoami)
    set user_part $whoami_part$normal@$blue$hostname_parts[1]

    if test -n $k8info
        echo -s $k8info
    end

    set -l repo_info (fish_git_information_status)
    if test -n $repo_info
        echo -s $repo_info
    end

    set -l prompt $user_part$normal':'$green$cwd
    set prompt $prompt$normal ' '
    echo -n -s $prompt
end
