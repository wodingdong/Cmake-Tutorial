
aux_source_directory(. DIR_LIB_SRCS)

add_library(myaddfun STATIC ${DIR_LIB_SRCS})

install (TARGETS myaddfun DESTINATION lib)
install (FILES add.h DESTINATION include)
