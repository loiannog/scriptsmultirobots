# scriptsmultirobots
tmux scripts to run multiple vehicles

## multi_setup.sh
Bash script run on Ground Station
#### What does it do?
1) Sets up tmux session
2) SSH into multiple robots
3) Runs run_robot.sh on each robot

## ssh_all.sh
Bash script to ssh into multiple robots for debugging purposes.


## run_robot.sh
Bash script run on the robot, it is called in a loop in setup.sh
#### What does it do?
1) Launches state_control_vehicle state_control.launch
2) Sets up tmux session for the robot


## setup.conf
Sets a few settings for the tmux session on the Ground Station
# dragonfly_scripts

## chrony.conf
The configuration file to install on each robot for clock synchronization

## instrictions_for_setup.txt
The order of operations you must perform to get each robot working in the swarm

## df_demo.sh
An example set of formations and commands that were preformed to demonstrate the swarm capabilities. This was performed in a large outdoor space

## indoor_demo.sh
Another example set of formations and commands that were performed in smaller indoor flying spaces
