#!/bin/bash

UAV_NAME=$1

echo "uav name is ${UAV_NAME}"

tmux new-session -s ${UAV_NAME}
tmux send-keys -t ${UAV_NAME} "sudo stop snav; sleep 2; sudo start snav; sleep 2; roslaunch state_control_vehicle mav_manager_vio_qc.launch model:=${UAV_NAME}" C-m

sleep 2
#sudo -s << SCRIPT
#source ~/catkin_ws/devel/setup.bash
#roslaunch state_control_vehicle mav_manager_vio_qc.launch model:=${UAV_NAME}
#SCRIPT

exit

clear
