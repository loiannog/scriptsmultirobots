#!/bin/bash

# Don't forget to source the setup.bash file.
source ~/catkin_ws/devel/setup.bash

SPACING=1.5

alias motors='rosservice call /multi_mav_services/motors'
alias takeoff='rosservice call /multi_mav_services/takeoff'
alias line='    rosservice call /multi_mav_services/goFormLine "{roll: 0.0, pitch: 0.0, yaw: 0.0, center: [0.0, 0.0, 1.0], spacing: $SPACING}"'
alias line1='   rosservice call /multi_mav_services/goFormLine "{roll: 0.0, pitch: 0.0, yaw: 1.6, center: [0.0, -1.0, 1.5], spacing: $SPACING}"'
alias circle='  rosservice call /multi_mav_services/goFormCircle "{roll: 0.0, pitch: 0.0, yaw: 0.0, center: [0.0, 0.0, 1.0], spacing: $SPACING}"'
alias land='rosservice call /multi_mav_services/land'
alias eland='rosservice call /multi_mav_services/eland'
alias estop='rosservice call /multi_mav_services/estop'

read -p "Press [Enter] to turn on motors"
rosservice call /multi_mav_services/motors true
sleep 1

read -p "Press [Enter] to takeoff"
rosservice call /multi_mav_services/takeoff
sleep 1

read -p "Press [Enter] to form circle"
rosservice call /multi_mav_services/goFormCircle "{roll: 0.0, pitch: 0.0, yaw: 0.0, center: [0.0, 0.0, 1.0], spacing: $SPACING}"
sleep 1

read -p "Press [Enter] to expand circle"
rosservice call /multi_mav_services/goFormCircle "{roll: 0.0, pitch: 0.0, yaw: 0.0, center: [0.0, 0.0, 1.0], spacing: 2.5}"
sleep 1

read -p "Press [Enter] to move circle forward 2m"
rosservice call /multi_mav_services/goFormCircle "{roll: 0.0, pitch: 0.3, yaw: 0.0, center: [3.0, 0.0, 3.0], spacing: $SPACING}"
sleep 1

read -p "Press [Enter] to change to rectangle and come back"
rosservice call /multi_mav_services/goFormRect "{roll: 0.0, pitch: -0.3, yaw: 0.0, center: [-3.0, 0.0, 1.5], spacing: $SPACING}"
sleep 1

read -p "Press [Enter] to change to line"
rosservice call /multi_mav_services/goFormLine "{roll: 0.0, pitch: 0.1, yaw: 0.5, center: [0.0, 0.0, 2.5], spacing: $SPACING}"
sleep 1

read -p "Press [Enter] to change to line"
rosservice call /multi_mav_services/goFormLine "{roll: 0.0, pitch: 0.1, yaw: -0.5, center: [0.0, 0.0, 3.5], spacing: $SPACING}"
sleep 1

read -p "Press [Enter] to form circle"
rosservice call /multi_mav_services/goFormCircle "{roll: 0.0, pitch: 0.0, yaw: 0.0, center: [0.0, 0.0, 3.5], spacing: $SPACING}"
sleep 1

read -p "Press [Enter] to form rectangle close to start pos"
rosservice call /multi_mav_services/goFormRect "{roll: 0.0, pitch: 0.0, yaw: 0.0, center: [-1.5, 0.0, 1.0], spacing: 1.5}"
sleep 1

read -p "Press [Enter] to land"
rosservice call /multi_mav_services/land
sleep 1

read -p "Press [Enter] to turn off motors"
rosservice call /multi_mav_services/motors false
sleep 1
