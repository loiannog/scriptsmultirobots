#!/bin/bash

SESSION_NAME=$USER
UAV_NAME=$SESSION_NAME

if [ -z ${TMUX} ];
then
  TMUX= tmux new-session -s $SESSION_NAME -d
  echo "Starting new session."
else
  SESSION_NAME="$(tmux display-message -p '#S')"
fi

# define commands
# 'name' 'command'
input=($USER 'sudo date --set="2017-03-03 23:31:59.990"; roslaunch state_control_vehicle state_control.launch')

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

sleep 4


# send commands
for ((i=0; i < ${#cmds[*]}; i++));
do
        tmux send-keys -t $SESSION_NAME:$(($i+10)) "${cmds[$i]}" C-m
done

sleep 4

tmux select-window -t $SESSION_NAME:1

clear