#!/bin/bash

SESSION_NAME=dragonfly_multi_robot_kill
UAV_NAME=$SESSION_NAME

if [ -z ${TMUX} ];
then
  TMUX= tmux new-session -s $SESSION_NAME -d
  echo "Starting new session."
else
  SESSION_NAME="$(tmux display-message -p '#S')"
fi

# create arrays of names and commands
VEHICLE_NUMBER=2
for ((i=0; i < ${VEHICLE_NUMBER}; i++));
do
  VEHICLE_COMMAND[$i]="ssh -t dragonfly$((i+1))@dragonfly$((i+1)) sudo tmux kill-session"
 for ((j=2*i; j < 2*i+1; j++));
  do
  input[$j]="uav${i}"
  input[$((j+1))]=${VEHICLE_COMMAND[$i]}
 done
done

# create arrays of names and commands
for ((i=0; i < ${#input[*]}; i++));
do
  ((i%2==0)) && names[$i/2]="${input[$i]}" 
	((i%2==1)) && cmds[$i/2]="${input[$i]}"
done

# run tmux windows
for ((i=0; i < ${#names[*]}; i++));
do
	tmux new-window -t $SESSION_NAME:$(($i+10)) -n "${names[$i]}"
done

sleep 1

# send commands
for ((i=0; i < ${#cmds[*]}; i++));
do
	tmux send-keys -t $SESSION_NAME:$(($i+10)) "${cmds[$i]}" C-m
done

sleep 1

tmux select-window -t $SESSION_NAME:1
tmux -2 attach-session -t $SESSION_NAME

clear
