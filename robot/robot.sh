#!/bin/bash

set -e

## call find_bot to init this
window_id=

## This is the small sleep between key presses. Change for debugging
## when you are not sure what is happening
small_sleep=0.1
big_sleep=1

emacs_process_pid=

function sleep_small {
    sleep $small_sleep
}

function sleep_big {
    sleep $big_sleep
}

function send_answer {
    retn
    sleep_small
    key 5
    sleep_small
}

function launch_emacs {
    echo Launching $EMACS -Q -l $* &

    $EMACS -Q -l $* &
    emacs_process_pid=$!
}

function kill_emacs {
    key alt+x
    command kill-emacs
    retn
}

function xdo {
    xdotool $1 --window $window_id $2 || {
        echo "Failed command: $1, $2";exit 1
    }
}
function key {
    xdo key $1
}

function command {
    xdo type $1
}

function retn {
    key Return
}

function wait_emacs {
    wait $emacs_process_pid
}

function find_bot {
    window_id=`xdotool search --name "emacs-bot"`
    if [ -z "$window_id" ]
    then
        echo "Could not find window ID for Emacs-bot"
        exit 1
    fi
}