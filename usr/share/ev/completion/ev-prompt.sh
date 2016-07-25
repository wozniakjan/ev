_ev_compreply ()
{
    local terminal=("$1")
    local nonterminal=("$1")
    local all=("$1" "$2")
    
    COMPREPLY=( `compgen -W "${all[*]}" -- $cur` )
    local i=0
    for (( i=0; i<${#COMPREPLY[@]}; i++ )); do
        local k=${COMPREPLY[i]}
        local contains=""
        for c in ${nonterminal[@]}; do
            if [ "$k" == "$c" ]; then
                contains=true
            fi
        done
        if [ "$contains" != true ]; then
            COMPREPLY[i]="$k "
        fi
    done
}

_ev ()
{
    local cur command
    cur=${COMP_WORDS[COMP_CWORD]}
    command=${COMP_WORDS[COMP_CWORD-1]}
    
    if [ "$command" == "ev" ]; then
        _ev_compreply 'init status' 'set'
        return 0
    fi
    
    case "$command" in
    init)   COMPREPLY=() ;;
    set)    _ev_compreply 'default 1.8 1.9' '' ;;
    status) COMPREPLY=() ;;
    *)      COMPREPLY=() ;;
    esac
    
    return 0
}

__ev_prompt_command ()
{
    local active="`ev set 2> /dev/null`"
    if [ "$active" == default ]; then
        local active=""
    fi
    if [ "$active" != "$EV_ACTIVE" ]; then
        if [ "$active" != "" ]; then
            local repo="`ev global repo 2> /dev/null`"
            local erlang_path="$repo/envs/$active/bin/"
        fi
        __ev_update_path "$erlang_path"
    fi
    export EV_ACTIVE="$active"
}

__ev_update_path()
{
    local erlang_path="$1"
    if [ "$erlang_path" != "" ]; then
        if [ "$EV_PATH_BACKUP" == "" ]; then
            export EV_PATH_BACKUP="$PATH"
        fi
        export PATH="${erlang_path}:${EV_PATH_BACKUP}"
    else
        export PATH="$EV_PATH_BACKUP"
        unset EV_PATH_BACKUP
    fi
}

__ev_ps1 ()
{
    local active=`ev set 2> /dev/null`
    if [ "$active" != "" ]; then
        echo " (ev $active)"
    fi
}


complete -o bashdefault -o default -o nospace -F _ev ev 2>/dev/null \
		|| complete -o default -o nospace -F _ev ev
