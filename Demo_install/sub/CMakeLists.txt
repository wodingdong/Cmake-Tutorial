# 添加源文件
aux_source_directory(. DIR_LIB_SRCS)

# 生成静态库
add_library(mysubfun STATIC ${DIR_LIB_SRCS})

# 指定 sub 库的安装路径
install (TARGETS mysubfun DESTINATION lib)
install (FILES sub.h DESTINATION include)
