function cat
    if test -e /etc/debian_version
        batcat $argv
    else
        bat $argv
    end
end
