cmake_minimum_required (VERSION 3.10)


project (Demo4)

aux_source_directory(. DIR_LIB_SRCS)

add_library(myaddfun SHARED ${DIR_LIB_SRCS})


