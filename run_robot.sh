#!/bin/bash

UAV_NAME=$1

echo "uav name is ${UAV_NAME}"


sleep 2
sudo -s << SCRIPT
source ~/catkin_ws/devel/setup.bash
stop snav
sleep 2
start snav
sleep 2
roslaunch state_control_vehicle mav_manager_vio_qc.launch model:=${UAV_NAME}
SCRIPT

exit

clear
