cmake_minimum_required (VERSION 3.10)


project (Demo8)

include_directories(add)
include_directories(sub)

aux_source_directory(. DIR_SRCS)
add_subdirectory(add)
add_subdirectory(sub)

add_executable(demo ${DIR_SRCS})

target_link_libraries(demo myaddfun mysubfun)
