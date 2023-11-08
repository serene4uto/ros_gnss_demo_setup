ARCH=$(uname -m)

if [[ $ARCH == *"aarch64"* ]]; then
  echo "The architecture is ARM."
  DOCKER_IMG="serene4utobot/ros2_gnssrtk:galactic-ubuntu20.04"
elif [[ $ARCH == *"x86_64"* ]]; then
  echo "The architecture is AMD."
  DOCKER_IMG="serene4utobot/ros2_gnssrtk:galactic-ubuntu20.04-cuda"
else
  echo "The architecture is neither ARM nor AMD."
  exit 1
fi

docker run -itd \
    --name ros_gnss \
    -e DISPLAY=host.docker.internal:0.0 \
    --net=host \
    --privileged \
    -v /dev:/dev \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /home/pi/gnss_log:/home/gnss_log \
    $DOCKER_IMG

docker exec -it ros_gnss bash -c "cd ~ && mkdir -p ros_gnss_ws/src \
    && cd ros_gnss_ws/src \
    && git clone https://github.com/serene4uto/rtcm_provider_ros.git \
    && pip3 install -r rtcm_provider_ros/requirements.txt \
    && git clone -b gnss_eval https://github.com/serene4uto/ublox_gnss_ros.git \
    && pip3 install -r ublox_gnss_ros/requirements.txt \
    && cd .. \
    && colcon build \
    && exit"

# setup service


# setup icon

