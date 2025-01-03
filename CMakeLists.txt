cmake_minimum_required(VERSION 3.10)
project(Project)

set(EXEC executable)
set(BUILD_SHARED_LIBS off)

include_directories(${CMAKE_SOURCE_DIR}/vendor)

file(GLOB SOURCES source/*.cpp)
add_executable(${EXEC} ${SOURCES})

######### GLFW #########

set(GLFW_DIR ${CMAKE_SOURCE_DIR}/vendor/glfw)
set(GLFW_BUILD_EXAMPLES off)
set(GLFW_BUILD_TESTS off)
set(GLFW_BUILD_DOCS off)

add_subdirectory(${GLFW_DIR})
target_link_libraries(${EXEC} PRIVATE glfw)
target_include_directories(${EXEC} PRIVATE ${GLFW_DIR}/include)
