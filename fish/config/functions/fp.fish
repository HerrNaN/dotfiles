function fp --wraps='cd (find ~/proj -maxdepth 1 -mindepth 1 -type d | fzf)' --description 'cd into a recent project dir via fzf (newest first)'
    set -l dir (find ~/proj -maxdepth 1 -mindepth 1 -type d -printf '%T@\t%p\0' \
            | sort -zrn \
            | cut -z -f2- \
            | fzf --read0)
    test -n "$dir"; and cd "$dir"
end
