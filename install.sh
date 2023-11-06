docker run -it --rm \
    --name ros_gnss \
    --net host \
    --privileged \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev:/dev \
    serene4utobot/gpsrtk:galactic-ubuntu20.04

docker start ros_gnss
docker exec -it ros_gnss bash -c "cd ~ && mkdir -p ros_gnss_ws/src \
    && cd ros_gnss_ws/src \
    && git clone https://github.com/serene4uto/rtcm_provider_ros.git \
    && pip3 install -r rtcm_provider_ros/requirements.txt \
    && git clone https://github.com/serene4uto/ublox_gnss_ros.git \
    && pip3 install -r ublox_gnss_ros/requirements.txt \
    && cd .. \
    && colcon build "

exit 0