mkdir src
cd src

git clone https://github.com/serene4uto/rtcm_provider_ros.git
pip3 install -r rtcm_provider_ros/requirements.txt

git clone https://github.com/serene4uto/ublox_gnss_ros.git
pip3 install -r ublox_gnss_ros/requirements.txt


cd ..

colcon build