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
SCRIPTS_DIR="/home/$USER/ros_gnss_demo_setup"

# Loop through each Bash script in the directory
for file in "$SCRIPTS_DIR"/*.sh; do

    # Get the name of the script file without the extension
    name=$(basename "${file%.sh}")

    if [ "$name" = "run_gnss" ] || [ "$name" = "run_eval_u08" ] || [ "$name" = "run_eval_u0736" ]; then

      # Set the name of the desktop launcher file
      desktop_file="$name.desktop"
  
      # Set the command to execute the script in a new terminal window
      command="gnome-terminal -- bash -c 'bash $file; exec bash'"
  
      # Create the desktop launcher file
      echo "[Desktop Entry]" > "$desktop_file"
      echo "Type=Application" >> "$desktop_file"
      echo "Name=$name" >> "$desktop_file"
      # echo "Icon=/home/$USER/guidebot_setup/app_icon/guidebot_app_icon.jpg" >> "$desktop_file"
      echo "Exec=$command" >> "$desktop_file"
      echo "Terminal=true" >> "$desktop_file"
  
      # Make the desktop launcher file executable
      chmod +x "$desktop_file"
  
      # Move the desktop launcher file to the desktop directory
      mv "$desktop_file" ~/Desktop/
    fi

done

sleep 2

# Make desktop app launchable
cd /home/$USER/Desktop

APP_DIR="/home/$USER/Desktop"

# Loop through each app in the directory
for file in "$APP_DIR"/*.desktop; do
    # Get the name of the script file without the extension
    name=$(basename "${file%.desktop}")

    desktop_file="$name.desktop"

    gio set "$desktop_file" metadata::trusted true

    chmod a+x "$desktop_file"
done

# Create guidebot_data symlink
ln -s  /home/$USER/guidebot_data /home/$USER/Desktop

