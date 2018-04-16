cmake_minimum_required(VERSION 2.8)

project(hello)

include_directories(. $ENV{AXIS2C_HOME}/include/axis2-1.6.0/)

# Source files to be used in the library
file (GLOB svc_SOURCES *.c)

set (axis_LIBS "")
set (LIBS axutil axis2_axiom axis2_parser axis2_engine axis2_http_sender axis2_http_receiver)
foreach(e ${LIBS})
    find_library(found_LIBS NAMES ${e} PATHS $ENV{AXIS2C_HOME}/lib)
    list(APPEND ${found_LIBS})
endforeach()

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

add_library(hello SHARED ${svc_SOURCES})
target_link_libraries(hello ${axis_LIBS} Threads::Threads)
