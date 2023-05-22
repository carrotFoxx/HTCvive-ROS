FROM ros:noetic

SHELL ["/bin/bash", "-c", "-e"]

CMD ["--privileged", "command_to_run"]

ENV CMAKE_PREFIX_PATH=/opt/ros/ros-$VERSION:$CMAKE_PREFIX_PATH
ENV DEBIAN_FRONTEND=noninteractive

COPY scripts /root/scripts
COPY .config /root/.config

WORKDIR /root

RUN apt update -q && \
    apt install \
    udev \
    wget \
    git \
    usbutils \
    ros-noetic-image-transport \
    ros-noetic-cv-bridge \
    ros-noetic-tf \
    libglew-dev \
    screen -y &&\
    apt autoclean -y && apt-get autoremove -y && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd ~ && \
    mkdir libraries && \
    cd libraries && \
    git clone https://github.com/ValveSoftware/openvr.git -b v1.3.22 && \
    cd openvr && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release ../ && \
    make

RUN mkdir /root/catkin_ws && mkdir /root/catkin_ws/src && \
    cd /root/catkin_ws/src && \
    git clone https://github.com/robosavvy/vive_ros && \
    source /opt/ros/noetic/setup.bash && \
    cd /root/catkin_ws && \
    catkin_make

CMD /root/scripts/entrypoint.sh

