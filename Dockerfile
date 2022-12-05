FROM ubuntu:focal-20221019

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
		cmake \
		build-essential \
		curl \
		wget \
		gnupg2 \
		lsb-release \
		ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

RUN apt-get update && \
    apt-get install -y --no-install-recommends ros-noetic-desktop-full

# Dependencies for building packages
RUN apt-get install -y  --no-install-recommends \
      python3-rosdep \
      python3-rosinstall \
      python3-rosinstall-generator  \
      python3-wstool  \
      build-essential

# Initialize rosdep
RUN rosdep init && \
    rosdep fix-permissions && \
    rosdep update

## Install dependencies for Lola2 ##
RUN apt-get install -y  --no-install-recommends \
      ros-noetic-spatio-temporal-voxel-layer  \
      ros-noetic-navigation

RUN apt-get install -y  --no-install-recommends \
      ros-noetic-joy \
      ros-noetic-realsense2-camera \
      python3-pip

RUN pip install pyserial
#RUN pip install -r requirements.txt

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# RUN source ~/.bashrc