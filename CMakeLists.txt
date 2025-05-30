# CMakeLists.txt for kivsee-proto nanopb generated sources

cmake_minimum_required(VERSION 3.10)
project(kivsee_proto_nanopb C)

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
)

# set C standard
set_target_properties(kivsee_proto_nanopb PROPERTIES
    C_STANDARD 99
    C_STANDARD_REQUIRED YES
)
