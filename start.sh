#!/usr/bin/env bash

set -e

function log {
    echo `date` $ME - $@
}

function checkrancher {
    log "checking rancher network..."
    
    a="`ip a s dev eth0 &> /dev/null; echo $?`"
    while  [ $a -eq 1 ];
    do
        a="`ip a s dev eth0 &> /dev/null; echo $?`"
        sleep 1
    done

    b="`ping -c 1 rancher-metadata &> /dev/null; echo $?`"
    while [ $b -eq 1 ];
    do
        b="`ping -c 1 rancher-metadata &> /dev/null; echo $?`"
        sleep 1
    done
}

function saveconfig {
    log "Saving config into ${SERVER_WORK_DIR} directory..."
    
    if [ ! -d "${SERVER_WORK_DIR}/config" ]; then
        mkdir -p ${SERVER_WORK_DIR}/config
    fi

    if [ -d "${GOCD_HOME}/config" ]; then
        if [ ! -L "$LINK_OR_DIR" ]; then
            rm -rf ${GOCD_HOME}/config
            ln -s ${SERVER_WORK_DIR}/config ${GOCD_HOME}/config
        fi
    fi
}

checkrancher
saveconfig

log "[ Starting gocd server... ]"
/opt/go-server/server.sh
