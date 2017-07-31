#!/bin/bash

SESSION_NAME=$USER
UAV_NAME=$1

if [ -z ${TMUX} ];
then
  TMUX= tmux new-session -s $SESSION_NAME -d
  echo "Starting new session."
else
  SESSION_NAME="$(tmux display-message -p '#S')"
fi

echo ${UAV_NAME}

# define commands
# 'name' 'command'
input=("$USER" "sudo stop snav; sleep 2; sudo start snav; sleep 2; roslaunch state_control_vehicle mav_manager_vio_qc.launch model:=${UAV_NAME}")

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
tmux -2 attach-session -t $SESSION_NAME

clear
