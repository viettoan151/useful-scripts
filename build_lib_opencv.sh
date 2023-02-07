#!/bin/bash
echo "This script help to build Opencv to library. Detail build options:"
echo "https://docs.opencv.org/3.4.16/d7/d9f/tutorial_linux_install.html"

echo "Please download opencv version 3.4.16 from source and unzip:"
echo "https://github.com/opencv/opencv/releases/tag/3.4.16"
echo "wget https://github.com/opencv/opencv/archive/refs/tags/3.4.16.zip"

echo "Please download opencv_contrib version 3.4.16 from source and unzip:"
echo "https://github.com/opencv/opencv_contrib/releases/tag/3.4.16"
echo "wget https://github.com/opencv/opencv_contrib/archive/refs/tags/3.4.16.zip"


read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'

ncore=$(nproc)
echo "Total ${ncore} cores"
if [ $ncore -gt 4 ]; then
    ncore=$(($ncore - 4))
else
    ncore=1
fi
echo "Build processing on ${ncore} cores"
cd opencv-3.4.16
mkdir build
mkdir install
cd build
cmake -D CMAKE_BUILD_TYPE=Release \
        -D CMAKE_INSTALL_PREFIX=../install \
        -D INSTALL_C_EXAMPLES=OFF \
        -D BUILD_TESTS=OFF \
        -D INSTALL_PYTHON_EXAMPLES=OFF \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.4.16/modules \
        -D BUILD_EXAMPLES=OFF \
        -D WITH_LIBV4L=ON \
        -D WITH_V4L=ON \
        -DWITH_GSTREAMER=ON \
        -DVIDEOIO_PLUGIN_LIST=gstreamer \
        -DWITH_MSMF=ON -DWITH_VFW=ON -DWITH_FFMPEG=ON \
        -D WITH_VTK=OFF -D WITH_GTK=ON -D WITH_GTK_2_X=ON \
        -D ENABLE_PRECOMPILED_HEADERS=OFF BUILD_PROTOBUF=ON \
        ..

make -j$ncore
make install