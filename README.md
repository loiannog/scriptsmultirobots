# scriptsmultirobots
tmux scripts to run multiple vehicles

## setup.sh
Bash script run on Ground Station
#### What does it do?
1) Sets up tmux session
2) SSH into multiple robots
3) Runs run_robot.sh on each robot


## run_robot.sh
Bash script run on the robot, it is called in a loop in setup.sh
#### What does it do?
1) Launches state_control_vehicle state_control.launch
2) Sets up tmux session for the robot


## setup_kill.sh
Bash script run on Ground Station to shut down all robots


## setup.conf
Sets a few settings for the tmux session on the Ground Station
