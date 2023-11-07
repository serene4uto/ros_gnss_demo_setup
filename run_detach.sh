docker start ros_gnss
docker exec  ros_gnss bash -c "cd ~/ros_gnss_ws && source ./install/setup.bash \
        && ros2 launch ublox_gnss gnssrtk.launch.py"