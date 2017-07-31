#!/bin/bash

SESSION_NAME=dragonfly_multi_robot
UAV_NAME=$SESSION_NAME

declare -a ROBOTS=("dragonfly11"
                  )

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
  VEHICLE_COMMAND="ssh -t $robot_i@$robot_i sudo ./scriptsmultirobots/run_robot.sh ${robot_i}"

  tmux new-window -t ${SESSION_NAME}:$(($i+10)) -n ${ROBOTS[$i]}
  tmux send-keys -t ${SESSION_NAME}:$(($i+10)) "ssh -t $robot_i@$robot_i" Enter
  sleep 1
  tmux send-keys -t ${SESSION_NAME}:$(($i+10)) "./scriptsmultirobots/run_robot.sh ${robot_i}" Enter
done

sleep 1

tmux select-window -t $SESSION_NAME:1
tmux -2 attach-session -t $SESSION_NAME

clear
