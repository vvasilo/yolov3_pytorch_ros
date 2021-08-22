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

install(DIRECTORY classes
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

# add something that depends on above script so it runs
add_custom_target(
  DownloadWeights ALL)

# download yolov3 weights
add_custom_command(TARGET DownloadWeights
  PRE_BUILD
  COMMAND sh ${CMAKE_CURRENT_SOURCE_DIR}/models/download_yolov3_weights.sh
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/models
  COMMENT "YOLOv3 weights")

# download yolov3-tiny weights
add_custom_command(TARGET DownloadWeights
  PRE_BUILD
  COMMAND sh ${CMAKE_CURRENT_SOURCE_DIR}/models/download_yolov3-tiny_weights.sh
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/models
  COMMENT "YOL0v3 tiny weights")