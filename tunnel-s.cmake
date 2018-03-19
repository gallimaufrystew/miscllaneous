cmake_minimum_required(VERSION 2.6)

project(tunnel-s)

#add_definitions(-D_HTTP_DISABLED)

include_directories(.)

# Source files to be used in the library
file (GLOB app_SOURCES *.cc)

add_executable(tunnel-s ${app_SOURCES})

find_library(110_ssl_LIBS NAMES ssl /usr/lib /usr/local/lib /opt/lib)
find_library(110_crypto_LIBS NAMES crypto /usr/lib /usr/local/lib /opt/lib)
find_library(BOOST_thread_LIBS NAMES boost_thread /usr/lib /usr/local/lib /opt/lib)
find_library(BOOST_system_LIBS NAMES boost_system /usr/lib /usr/local/lib /opt/lib)
find_library(pthread_LIBS NAMES pthread /usr/lib /usr/local/lib /opt/lib)

target_link_libraries(tunnel-s ${110_ssl_LIBS} ${110_crypto_LIBS}
                               ${BOOST_thread_LIBS} ${pthread_LIBS} 
                               ${BOOST_system_LIBS})
