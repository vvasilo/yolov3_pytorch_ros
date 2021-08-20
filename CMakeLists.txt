cmake_minimum_required(VERSION 2.8.12)
project(yolov3_pytorch_ros)

find_package(catkin REQUIRED
  COMPONENTS
    geometry_msgs
    sensor_msgs
    std_msgs
    message_generation)

catkin_python_setup()

add_message_files(
  FILES
    BoundingBox.msg
    BoundingBoxes.msg
)

generate_messages(
  DEPENDENCIES
    geometry_msgs
    sensor_msgs
    std_msgs
)

catkin_package()

catkin_install_python(
  PROGRAMS src/${PROJECT_NAME}/detector.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY src/${PROJECT_NAME}/models
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY src/${PROJECT_NAME}/utils
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY launch
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

install(DIRECTORY config
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

install(DIRECTORY models
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/models/yolov3.weights)
  message("YOLOv3 weights already downloaded!")
else()
  message("YOLOv3 weights are missing, downloading now...")
  # install model weights from script
  add_custom_command(OUTPUT yolov3.weights
    COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/models/download_weights.sh
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/models
  )

  # add something that depends on above script so it runs
  #  add_custom_target(
  #    DownloadWeights ALL
  #    DEPENDS yolov3.weights
  #  )
endif()
