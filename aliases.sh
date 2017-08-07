#!/bin/bash

source ~/catkin_ws/devel/setup.bash

SPACING=1.5

alias motors='  rosservice call /multi_mav_services/motors'
alias takeoff=' rosservice call /multi_mav_services/takeoff'
alias land='    rosservice call /multi_mav_services/land'
alias hover='   rosservice call /multi_mav_services/hover'
alias eland='   rosservice call /multi_mav_services/eland'
alias estop='   rosservice call /multi_mav_services/estop'
alias goTo='    rosservice call /multi_mav_services/goTo'
alias line='    rosservice call /multi_mav_services/goFormLine "{roll: 0.0, pitch: 0.0, yaw: 0.0, center: [0.0, 0.0, 1.0], spacing: $SPACING}"'
alias line1='   rosservice call /multi_mav_services/goFormLine "{roll: 0.0, pitch: 0.0, yaw: 1.6, center: [0.0, -1.0, 1.5], spacing: $SPACING}"'
alias circle='  rosservice call /multi_mav_services/goFormCircle "{roll: 0.0, pitch: 0.0, yaw: 0.0, center: [0.0, 0.0, 1.0], spacing: $SPACING}"'
alias stop='land && sleep 1 && motors false'

echo "loaded aliases for /multi_mav_services/"
echo "motors, takeoff, land, hover, eland, estop, goTo, line, line1, circle"

alias kill='tmux kill-session'
