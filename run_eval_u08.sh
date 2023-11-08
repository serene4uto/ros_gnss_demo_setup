docker start ros_gnss
docker exec -it ros_gnss bash -c "cd ~/ros_gnss_ws && source ./install/setup.bash \
        && ros2 run gnss_eval gnss_eval --ros-args -p ground_truth:=u08 -p log_path:=/home/gnss_log"