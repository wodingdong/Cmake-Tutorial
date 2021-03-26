cmake_minimum_required (VERSION 3.10)


project (Demo6)

aux_source_directory(. DIR_SRCS)

include_directories(../Demo4/)

link_directories(../Demo4/build)

add_executable(demo ${DIR_SRCS})

target_link_libraries(demo myaddfun)



