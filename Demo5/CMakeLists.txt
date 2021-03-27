# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo4)

# 添加源文件
aux_source_directory(. DIR_LIB_SRCS)

# 生成动态库文件
add_library(myaddfun SHARED ${DIR_LIB_SRCS})


