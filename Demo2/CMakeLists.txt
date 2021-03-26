cmake_minimum_required (VERSION 3.10)


project (Demo2)

# first
#add_executable(demo add.h add.c main.c)

# second
aux_source_directory(. DIR_SRCS)
add_executable(demo ${DIR_SRCS})

