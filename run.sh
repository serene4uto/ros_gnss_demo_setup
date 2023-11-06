docker start ros_gnss
docker exec -it ros_gnss bash -c "cd ~/ros_gnss_ws && source ./install/setup.bash \
        && ros2 launch gnssrtk_ros gnssrtk_pub"