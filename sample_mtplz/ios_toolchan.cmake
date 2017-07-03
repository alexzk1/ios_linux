include(${CMAKE_CURRENT_LIST_DIR}/ios_arch.cmake)
#please, manually set path to folder which initially contains "make_cross_compiler" script
SET(IOS_BASE_TOOLS "/home/alex/Work/cross_ios")
SET(IOS_TOOLS "${IOS_BASE_TOOLS}/iostools/usr")


SET(CMAKE_SYSTEM_NAME Darwin)
SET(CMAKE_CROSSCOMPILING TRUE)


#very important, otherwise it uses host compiler
#sysroot will be prependend for searching all libs as well, so libs must be put/linked there to compiler folder
set(CMAKE_SYSROOT "${IOS_TOOLS}/SDK")
SET(CMAKE_CXX_COMPILER "${IOS_TOOLS}/bin/arm-apple-darwin11-clang")
SET(CMAKE_C_COMPILER ${CMAKE_CXX_COMPILER} )


#bugfix, like that https://bugreports.qt.io/browse/QTBUG-54666
get_property(cxx_features GLOBAL PROPERTY CMAKE_CXX_KNOWN_FEATURES)
set(CMAKE_CXX_COMPILE_FEATURES ${cxx_features})

add_compile_options(-arch ${IOS_ARCH} -stdlib=libc++)

#bugfix for linker, otherwise cmake uses native
set(CROSS_LINKER_FLAGS "-lc++ -arch ${IOS_ARCH} -v")
set(CMAKE_EXE_LINKER_FLAGS ${CROSS_LINKER_FLAGS} CACHE INTERNAL "")

#we have static compiled boost
SET(Boost_USE_STATIC_LIBS ON)

#next just excludes -mt from searched name
set(Boost_USE_MULTITHREADED OFF) 

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
