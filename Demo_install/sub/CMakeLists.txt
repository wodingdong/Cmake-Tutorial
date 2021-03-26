
aux_source_directory(. DIR_LIB_SRCS)

add_library(mysubfun STATIC ${DIR_LIB_SRCS})


install (TARGETS mysubfun DESTINATION lib)
install (FILES sub.h DESTINATION include)
