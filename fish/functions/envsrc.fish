function envsrc
  for line in (cat $argv | grep -v '^#' | grep -v '^\s*$')
    set item (string split -m 1 '=' $line)
    set -gx $item[1] (string trim --chars=\'\" $item[2])
    echo "Exported key $item[1]"
  end
end
