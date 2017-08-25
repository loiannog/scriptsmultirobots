#!/bin/bash

SESSION_NAME=dragonfly_multi_robot
UAV_NAME=$SESSION_NAME

declare -a ROBOTS=( "dragonfly1" 
                    "dragonfly2"
                    "dragonfly3"
                    "dragonfly4"
                    "dragonfly6" 
                    "dragonfly7" 
                    "dragonfly8" 
                    "dragonfly10" 
                    "dragonfly11" )
#declare -a ROBOTS=("dragonfly5")

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
  tmux split-window -h
  tmux send-keys "ssh -t ${robot_i}@$robot_i" C-m
  tmux send-keys "sudo ~/scriptsmultirobots/run_robot.sh $robot_i" C-m
  tmux select-pane -t 0
done

sleep 5

tmux new-window -t $SESSION_NAME:2 -n "Multi Mav Manager"
tmux send-keys "roslaunch multi_mav_manager multi_dragonfly.launch" C-m

tmux select-window -t $SESSION_NAME:1
tmux rename-window -t $SESSION_NAME:1 -n "Command Central"
tmux send-keys "source aliases.sh" C-m

tmux split-window -h
tmux send-keys "source aliases.sh" C-m
tmux send-keys "kill"

tmux select-pane -t 0
tmux split-window -v
tmux send-keys "source aliases.sh" C-m
tmux send-keys "estop"

tmux select-pane -t 0

tmux -2 attach-session -t $SESSION_NAME
clear
