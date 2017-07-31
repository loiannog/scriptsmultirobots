#!/bin/bash

UAV_NAME=$1

echo "uav name is ${UAV_NAME}"

sleep 1
echo "stopping snav"
sudo stop snav; 

sleep 2
sudo start snav

sleep 2
sudo -s << SCRIPT
source ~/catkin_ws/devel/setup.bash
roslaunch state_control_vehicle mav_manager_vio_qc.launch model:=${UAV_NAME}
SCRIPT

exit

clear
