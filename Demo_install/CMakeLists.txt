# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (DemoInstall)

# 包含头文件路径
include_directories(add)
include_directories(sub)

# 包含头文件路径
aux_source_directory(. DIR_SRCS)

# 添加add sub 子目录
add_subdirectory(add)
add_subdirectory(sub)

# 指定生成目标
add_executable(demo ${DIR_SRCS})

# 链接库文件
target_link_libraries(demo myaddfun mysubfun)

# 指定安装路径
install (TARGETS demo DESTINATION bin)

