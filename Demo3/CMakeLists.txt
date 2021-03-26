cmake_minimum_required (VERSION 3.10)


project (Demo3)

aux_source_directory(. DIR_SRCS)
aux_source_directory(add DIR_SRCS)

include_directories(add)

add_executable(demo ${DIR_SRCS})

