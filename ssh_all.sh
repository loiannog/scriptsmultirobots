#!/bin/bash

SESSION_NAME=ssh_all_dragonfly
UAV_NAME=$SESSION_NAME

declare -a ROBOTS=("dragonfly8" "dragonfly10" "dragonfly11" "dragonfly13")
#declare -a ROBOTS=("dragonfly8" "dragonfly10")

if [ -z ${TMUX} ];
then
  TMUX= tmux new-session -s $SESSION_NAME -d
  echo "Starting new session."
else
  SESSION_NAME="$(tmux display-message -p '#S')"
fi

tmux source-file setup.conf
sleep 1

robot_indices=${!ROBOTS[*]}
for i in $robot_indices;
do
  robot_i=${ROBOTS[$i]}

  tmux new-window -t ${SESSION_NAME}:$(($i+10)) -n $robot_i
  tmux send-keys "ssh -t ${robot_i}@$robot_i" C-m
done

sleep 5
tmux -2 attach-session -t $SESSION_NAME
clear
