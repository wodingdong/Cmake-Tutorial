cmake_minimum_required (VERSION 3.10)


project (Demo7)

aux_source_directory(. DIR_SRCS)

include_directories(../Demo5/)

link_directories(../Demo5/build)

add_executable(demo ${DIR_SRCS})

target_link_libraries(demo myaddfun)



