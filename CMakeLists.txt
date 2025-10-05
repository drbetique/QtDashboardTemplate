cmake_minimum_required(VERSION 3.16)
project(QtDashboardTemplate VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Find Qt6 components (including Charts)
find_package(Qt6 REQUIRED COMPONENTS Core Quick Charts)

qt_standard_project_setup()

add_executable(QtDashboardTemplate
    src/main.cpp
    src/backend/backend.cpp
    src/qml/main.qml
)

target_link_libraries(QtDashboardTemplate PRIVATE Qt6::Core Qt6::Quick Qt6::Charts)
target_include_directories(QtDashboardTemplate PRIVATE src/backend)
