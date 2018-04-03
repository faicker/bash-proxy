#!/usr/bin/env bash

mydir=`dirname ${BASH_SOURCE[0]}`


site_list=()
cmd_list=()

__load_site_list() {
    if [[ -f $mydir/site_list ]]; then
        site_list=()
        while read line; do
            site_list+=("$line")
        done < $mydir/site_list
        touch $mydir/.ts
    fi
}

__load_cmd_list() {
    if [[ -f $mydir/cmd_list ]]; then
        cmd_list=()
        while read line; do
            cmd_list+=("$line")
        done < $mydir/cmd_list
        touch $mydir/.ts
    fi
}

__set_proxy() {
    export http_proxy=$myhttp_proxy
    export https_proxy=$myhttps_proxy
    __flag_proxy=1
}

__unset_proxy() {
    unset http_proxy
    unset https_proxy
    unset __flag_proxy
}

__reload_if() {
    if [[ $mydir/site_list -nt $mydir/.ts ]]; then
        __load_site_list
    fi

    if [[ $mydir/cmd_list -nt $mydir/.ts ]]; then
        __load_cmd_list
    fi
}

preexec() {
    # before command execute
    __reload_if
    if [[ -z $myhttp_proxy || -z $myhttps_proxy ]]; then
        return
    fi
    if [[ -n $http_proxy || -n $https_proxy || -n $HTTP_PROXY || -n $HTTPS_PROXY ]]; then
        return
    fi
    for name in "${site_list[@]}"; do
        if [[ $1 =~ $name ]]; then
            __set_proxy
            return
        fi
    done
    for name in "${cmd_list[@]}"; do
        re="^[[:space:]]*$name[[:space:]]+"
        if [[ $1 =~ $re ]]; then
            __set_proxy
            return
        fi
    done
}

precmd() {
    # before prompt display
    if [[ -n "$__flag_proxy" ]]; then
        __unset_proxy
    fi
}

__load_site_list
__load_cmd_list
