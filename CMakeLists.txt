cmake_minimum_required(VERSION 3.16)
project(WeatherDashboard VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick)

qt_standard_project_setup()

add_executable(WeatherDashboard
    src/main.cpp
    src/backend/WeatherModel.cpp
    src/qml/main.qml

)

target_link_libraries(WeatherDashboard PRIVATE Qt6::Core Qt6::Quick)
target_include_directories(WeatherDashboard PRIVATE src/backend)
