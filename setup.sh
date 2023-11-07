mkdir src
cd src

git clone https://github.com/serene4uto/ros_gnssrtk.git 
pip3 install -r ros_gnssrtk/requirements.txt 

cd ..

colcon build