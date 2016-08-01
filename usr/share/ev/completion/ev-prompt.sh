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

_ev_global ()
{
    if [ "$COMP_CWORD" -eq 2 ]; then
        _ev_compreply '' 'repo build'
        return 0
    fi

    local cmd=${COMP_WORDS[COMP_CWORD-1]}
    case "$cmd" in
        repo)  _ev_compreply "`ev global repo`" '' ;;
        build) _ev_compreply "todo" "" ;;
    esac
}

_ev ()
{
    local cur command
    local cur=${COMP_WORDS[COMP_CWORD]}
    
    if [ "$COMP_CWORD" -eq 1 ]; then
        _ev_compreply 'init status list' 'set global'
        return 0
    fi
   
    COMPREPLY=()
    local cmd=${COMP_WORDS[1]}
    case "$cmd" in
        init)   ;;
        set)    _ev_compreply "`ev list`" '' ;;
        status) ;;
        list)   ;; 
        global) _ev_global ;;
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
            local erlang_path="$repo/evs/$active/bin/"
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
        echo "$1(ev $active)$2"
    fi
}


complete -o bashdefault -o default -o nospace -F _ev ev 2>/dev/null \
		|| complete -o default -o nospace -F _ev ev
