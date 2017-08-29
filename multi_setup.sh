#!/bin/bash

SESSION_NAME=dragonfly_multi_robot
UAV_NAME=$SESSION_NAME

#declare -a ROBOTS=( "dragonfly1" 
#                    "dragonfly2"
#                    "dragonfly3"
#                    "dragonfly4"
#                    "dragonfly5"
#                    "dragonfly6" 
#                    "dragonfly7" 
#                    "dragonfly8" 
#                    "dragonfly10" 
#                    "dragonfly11" 
#                    "dragonfly13" 
#                    "dragonfly14" )
declare -a ROBOTS=("dragonfly13")

if [ -z ${TMUX} ];
then
  TMUX= tmux new-session -s $SESSION_NAME -d
  echo "Starting new session."
else
  SESSION_NAME="$(tmux display-message -p '#S')"
fi

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

tmux new-window -t $SESSION_NAME:3 -n "Multi Mav Manager"
tmux send-keys "roslaunch multi_mav_manager multi_dragonfly.launch" C-m

tmux select-window -t $SESSION_NAME:2
tmux rename-window -t $SESSION_NAME:2 -n "Command Central"
tmux send-keys "source aliases.sh" C-m
tmux send-keys "./df_demo.sh"

tmux split-window -h
tmux send-keys "source aliases.sh" C-m
tmux send-keys "kill"

tmux split-window -v
tmux send-keys "cd bags" C-m
tmux send-keys "rosbag record -a"

tmux select-pane -t 0
tmux split-window -v
tmux send-keys "source aliases.sh" C-m
tmux send-keys "estop"

tmux -2 attach-session -t $SESSION_NAME
clear
