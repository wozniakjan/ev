__ev_prompt_command ()
{
    #TODO remember last version
    local active=`ev set 2> /dev/null`
    if [ "$active" != "" ]; then
        if [ "$active" != "$EV_ACTIVE" ]; then
            local repo=`ev global repo 2> /dev/null`
            local erlang_path="$repo/envs/$active/bin/"
            export EV_ACTIVE="$active"
            export EV_PATH_BACKUP="$PATH"
            export PATH="$erlang_path":"$PATH"
        fi
    else
        if [ "$EV_PATH_BACKUP" != "" ]; then
            export PATH="$EV_PATH_BACKUP"
            unset EV_PATH_BACKUP
            unset EV_ACTIVE
        fi
    fi
}

__ev_ps1 ()
{
    local active=`ev set 2> /dev/null`
    if [ "$active" != "" ]; then
        echo " (ev $active)"
    fi
}
