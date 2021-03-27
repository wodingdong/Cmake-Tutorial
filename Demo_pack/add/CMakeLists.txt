# 添加源文件
aux_source_directory(. DIR_LIB_SRCS)

# 生成静态库
add_library(myaddfun STATIC ${DIR_LIB_SRCS})

# 指定 add 库的安装路径
install (TARGETS myaddfun DESTINATION lib)
install (FILES add.h DESTINATION include)