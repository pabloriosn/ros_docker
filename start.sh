#!/bin/bash

docker run -ti 	--rm --net=host --privileged \
		--name lola2 \
		--device=/dev/ttyUSB0 \
		-v /dev:/dev \
		-v $(pwd):/app \
		-w /app/lola2/catkin_lola2 \
		ros_noetic bash
