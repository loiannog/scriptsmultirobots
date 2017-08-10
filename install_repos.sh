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
ssh -t $ROBOT@$ROBOT << EOF

  ### Install scriptsmultirobots
  #cd ~/
  #git clone https://github.com/loiannog/scriptsmultirobots.git
  #git checkout aaron_formation
  
  ## Quadrotor Control
  #cd ~/catkin_ws/src
  cd ~/test
  git clone https://github.com/KumarRobotics/quadrotor_control.git
  git submodule init
  git submodule update
  git checkout multi_qc_dragonfly
  
  ## Install master_discovery_fkie
  sudo apt-get install ros-indigo-master-discovery-fkie
  
  ## Install quadrotor_ukf
  git clone https://github.com/loiannog/quadrotor_ukf.git
  
  ## Install state_control_vehicle
  git clone https://github.com/loiannog/state_control_vehicle.git
  git checkout aaron_formation
  
  ## Install vio_qc
  git clone https://github.com/loiannog/vio_qc.git
  git checkout version_10_0
  

  #
  ### Set up chrony
  #sudo apt-get install chrony
  #rm /etc/chrony/chrony.conf
  ##copy /etc/chrony/chrony.conf from another robot
  #
  ### Configure wifi
edit /etc/wpa_supplicant.conf
add mrsl_ubnt_5g network
sudo -s
wpa_cli
status
reconfigure
list_networks

## Compile ros stuff
cd ~/catkin_ws
catkin_make

## Reset ipfirewall on my computer for chrony to work
sudo iptables -F

ssh-copy-id dragonflyx@dragonflyx
EOF
