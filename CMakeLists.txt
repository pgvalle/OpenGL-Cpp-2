cmake_minimum_required(VERSION 3.10)
project(Ninekraft)

set(BUILD_SHARED_LIBS off)

include_directories("${CMAKE_SOURCE_DIR}/vendor")

file(GLOB SOURCES "source/*.cpp")
add_executable(9kraft "${SOURCES}")

######### GLFW #########

set(GLFW_DIR "${CMAKE_SOURCE_DIR}/vendor/glfw")
set(GLFW_BUILD_EXAMPLES off)
set(GLFW_BUILD_TESTS off)
set(GLFW_BUILD_DOCS off)

add_subdirectory("${GLFW_DIR}")
target_link_libraries(9kraft PRIVATE glfw GL)
target_include_directories(9kraft PRIVATE "${GLFW_DIR}/include")
