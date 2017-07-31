#!/bin/bash

alias motors='  rosservice call /QuadrotorQc11/mav_services/motors'
alias takeoff=' rosservice call /QuadrotorQc11/mav_services/takeoff'
alias land='    rosservice call /QuadrotorQc11/mav_services/land'
alias hover='   rosservice call /QuadrotorQc11/mav_services/hover'
alias eland='   rosservice call /QuadrotorQc11/mav_services/eland'
alias estop='   rosservice call /QuadrotorQc11/mav_services/estop'
alias goTo='    rosservice call /QuadrotorQc11/mav_services/goTo'

alias stop='land && sleep 1 && motors false'

echo "loaded aliases for /QuadrotorQc11/mav_services/"
echo "motors, takeoff, land, hover, eland, estop, goTo"
