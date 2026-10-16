function bak
    if test (count $argv) -eq 0
        echo "Usage: bak FILE_OR_DIRECTORY [...]"
        return 2
    end

    set -l stamp (date +%Y%m%d-%H%M%S)

    for source in $argv
        command cp -a -- "$source" "$source.$stamp.bak"; or return
    end
end
