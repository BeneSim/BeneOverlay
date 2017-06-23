cmake_minimum_required(VERSION 3.0.0)

project(BeneOverlay)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5Qml)
find_package(Qt5Widgets)
find_package(Qt5Quick)
find_package(Qt5WebChannel)
find_package(Qt5WebSockets)

set(SRC_FILES
  src/dataref.cpp
  src/datarefmanager.cpp
  #src/flightsimconnector.cpp
  src/main.cpp
  src/updatemanager.cpp
  src/websocketclientwrapper.cpp
  src/websockettransport.cpp
  )

set(RCC_FILES
  data_resources.qrc
  qml/qml_resources.qrc
  )

set(HDR_FILES
  include/dataref.h
  include/datarefmanager.h
  include/updatemanager.h
  include/version.h
  include/websocketclientwrapper.h
  include/websockettransport.h
  )


add_executable(BeneOverlay ${SRC_FILES} ${HDR_FILES} ${RCC_FILES})

target_include_directories(BeneOverlay PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

target_link_libraries(BeneOverlay Qt5::Widgets Qt5::Qml Qt5::Quick Qt5::WebChannel Qt5::WebSockets)

add_definitions(-DTEST_MODE)
