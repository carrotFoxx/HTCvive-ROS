#!/bin/bash -eu
. /root/catkin_ws/devel/setup.bash
screen -dmS ln bash -c "ln -s /root/.steam/steam/linux64 /root/.steam/sdk64"
sleep 1
screen -dmS vive_server bash -c ". /root/catkin_ws/devel/setup.bash && roslaunch vive_ros server_vr.launch"
sleep 1
roslaunch vive_ros vive.launch

