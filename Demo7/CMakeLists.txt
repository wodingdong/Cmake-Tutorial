# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo7)

# 添加源文件
aux_source_directory(. DIR_SRCS)

# 包含头文件路径
include_directories(../Demo5/)

# 链接库的目录路径
link_directories(../Demo5/build)

# 指定生成目标
add_executable(demo ${DIR_SRCS})

# 需要链接库的名称
target_link_libraries(demo myaddfun)



