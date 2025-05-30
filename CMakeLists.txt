# CMakeLists.txt for kivsee-proto nanopb generated sources

cmake_minimum_required(VERSION 3.10)
project(kivsee_proto_nanopb C)

set(nanopb_BUILD_GENERATOR OFF CACHE BOOL "Don't build nanopb generator")
include(FetchContent)
FetchContent_Declare(
    nanopb
    GIT_REPOSITORY https://github.com/nanopb/nanopb.git
    GIT_TAG nanopb-0.4.9
)
FetchContent_MakeAvailable(nanopb)

# Collect all .c and .h files in gen/nanopb
file(GLOB NANOPB_SRC
    "${CMAKE_CURRENT_SOURCE_DIR}/gen/nanopb/kivsee/proto/render/v1/*.c"
)
file(GLOB NANOPB_HDR
    "${CMAKE_CURRENT_SOURCE_DIR}/gen/nanopb/kivsee/proto/render/v1/*.h"
)

add_library(kivsee_proto_nanopb STATIC ${NANOPB_SRC})

# set the include directories for consumers
# so they can #include <kivsee/proto/render/v1/xxx.pb.h>
target_include_directories(kivsee_proto_nanopb PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/gen/nanopb
    ${nanopb_SOURCE_DIR}
)

# set C standard
set_target_properties(kivsee_proto_nanopb PROPERTIES
    C_STANDARD 99
    C_STANDARD_REQUIRED YES
)

install(TARGETS kivsee_proto_nanopb
    EXPORT kivsee_proto_nanopbTargets
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION include
)

install(EXPORT kivsee_proto_nanopbTargets
    FILE kivsee_proto_nanopbTargets.cmake
    NAMESPACE kivsee::
    DESTINATION lib/cmake/kivsee_proto_nanopb
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/gen/nanopb/
    DESTINATION include
)