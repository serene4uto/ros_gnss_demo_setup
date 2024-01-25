xhost +local:docker
export DISPLAY=:0
docker start ros_gnss
docker exec -it ros_gnss bash -c "cd ~/ros_gnss_ws && source ./install/setup.bash \
        && export DISPLAY=:0 && ros2 launch ublox_gnss mapviz.launch.py"