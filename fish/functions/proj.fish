function proj
    switch (uname)
        case Darwin
            cd ~/Documents/project
        case Linux
            cd ~/proj
        case '*'
            echo "Unsupported"
    end
end
