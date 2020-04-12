#!/usr/bin/env bash

set -e

this_dir="$(dirname "$0")"
source ${this_dir}/robot.sh

card_no=3

# cram mode doesn't modify the buffer so there is no save prompt
function run_drill_no_save {
  sleep_small

  for i in `seq 1 ${card_no}`;
  do
    echo Answer: "$i"
    send_answer
  done

  echo press any key to continue
  retn
}

function run_drill {
  run_drill_no_save
  echo Save file
  key y
}


launch_emacs ${this_dir}/cram-run.el

{
  find_bot
  run_drill
  retn
  run_drill_no_save
  wait_emacs
} || cat robot/failure.txt
