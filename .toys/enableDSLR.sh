#!bin/bash

# INFO: https://medium.com/nerdery/dslr-webcam-setup-for-linux-9b6d1b79ae22

sudo modprobe v4l2loopback exclusive_caps=1 max_buffers=2

gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video2
