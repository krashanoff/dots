function proj
    switch (uname)
        case Darwin
            cd $HOME/project
        case Linux
            cd $HOME/project
        case '*'
            echo "Unsupported"
    end
end
