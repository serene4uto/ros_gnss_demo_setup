docker run -itd \
    --name ros_gnss \
    -e DISPLAY=host.docker.internal:0.0 \
    --net=host \
    --privileged \
    -v /dev:/dev \
    serene4utobot/gpsrtk:galactic-ubuntu20.04 

docker exec -it ros_gnss bash -c "cd ~ && apt remove python3-pip -y \
    && apt install wget -y \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && pip install pyopenssl --upgrade \
    && mkdir -p ros_gnss_ws/src \
    && cd ros_gnss_ws/src \
    && git clone -b eval https://github.com/serene4uto/ros_gnssrtk.git\
    && pip3 install -r ros_gnssrtk/requirements.txt \
    && cd .. \
    && colcon build \
    && exit"

