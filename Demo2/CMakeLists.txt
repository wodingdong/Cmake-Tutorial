# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo2)

# first 第一种添加源文件的方式
#add_executable(demo add.h add.c main.c)

# second 第二种添加源文件的方式，推荐这种
aux_source_directory(. DIR_SRCS)

# 指定生成目标
add_executable(demo ${DIR_SRCS})

