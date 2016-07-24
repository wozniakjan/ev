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
