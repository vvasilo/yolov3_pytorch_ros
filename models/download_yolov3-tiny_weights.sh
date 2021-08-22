#!/bin/bash

fname="yolov3-tiny.weights"
# get weights
if [ ! -f "./$fname" ]; then
  echo "$fname doesnt exist, downloading now..."
  wget https://pjreddie.com/media/files/$fname
else
  echo "$fname exists, skipping downloading"
fi
