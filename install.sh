ARCH=$(uname -m)

if [[ $ARCH == *"aarch64"* ]]; then
  echo "The architecture is ARM."
  DOCKER_IMG="serene4utobot/gpsrtk:galactic-ubuntu20.04"
elif [[ $ARCH == *"x86_64"* ]]; then
  echo "The architecture is AMD."
  DOCKER_IMG="serene4utobot/gpsrtk:galactic-ubuntu20.04-cuda"
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
    $DOCKER_IMG

docker exec -it ros_gnss bash -c "cd ~ && mkdir -p ros_gnss_ws/src \
    && cd ros_gnss_ws/src \
    && git clone -b eval https://github.com/serene4uto/ros_gnssrtk.git \
    && pip3 install -r ros_gnssrtk/requirements.txt \
    && cd .. \
    && colcon build \
    && exit"

