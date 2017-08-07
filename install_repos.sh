#!/bin/bash

# This script will guide you through and install the necessary repos on
# the dragonfly platform

# Change the name of this to be the robot you want
ROBOT=$1

if [ "$1" = "" ]; then
  echo "No robot name given. Which robot would you like to connect to?"
  read ROBOT
else 
  ROBOT=$1
fi

# SSH in to robot
echo "connecting to $ROBOT"
tmux send-keys "ssh -t $ROBOT@$ROBOT" C-m
read 
## Quadrotor Control
tmux send-keys "cd ~/catkin_ws/src" C-m
tmux send-keys "git clone https://github.com/KumarRobotics/quadrotor_control.git"
#git submodule init
#git submodule update
#git checkout multi_qc_dragonfly
