#!/bin/bash

set -e

this_dir="$(dirname "$0")"
source $this_dir/robot.sh


card_no=12
small_sleep=0.1


function run_drill {
    ## Org-drill should be running at this point, so give three answers
    ## with a score of file
    sleep_big

    for i in `seq 1 $card_no`;
    do
        echo Answer: $i
        send_answer
    done

    ## Press any key to continue
    echo press any key to continue
    retn
    sleep_small

    echo Save file
    key y
}

launch_emacs $this_dir/all-card-run.el $card_no

{
    sleep 1
    find_bot

    ## Run once with default options
    run_drill


    wait_emacs
} || cat robot/failure.txt
