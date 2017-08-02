#!/bin/bash

ROBOT="dragonfly13"
tmux new-session -s ${ROBOT}_tmux
echo "echoing: ssh -t $ROBOT@$ROBOT" C-m
tmux send-keys "ssh -t $ROBOT@$ROBOT" C-m
tmux send-keys "./scriptsmultirobots/run_robot.sh" C-m
