#!/bin/bash
cp /root/catkin_ws/src/vive_ros/60-HTC-Vive-perms.rules /etc/udev/rules.d
service udev restart
udevadm control --reload-rules && sudo udevadm trigger
