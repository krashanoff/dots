function abu
echo "" >> $XDG_CONFIG_HOME/fish/config.fish
echo "aa $argv" >> $XDG_CONFIG_HOME/fish/config.fish
abbr --add $argv
end
