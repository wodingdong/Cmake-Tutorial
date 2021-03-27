# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo3)

# 添加源文件
aux_source_directory(. DIR_SRCS)
# 将add目录下的源文件也包含进来
aux_source_directory(add DIR_SRCS)

# 头文件要包含的目录
include_directories(add)

# 指定生成目标
add_executable(demo ${DIR_SRCS})

