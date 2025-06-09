cmake_minimum_required(VERSION 3.10)
project(kivsee_proto_nanopb C)

set(CMAKE_CXX_STANDARD 99)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


set(nanopb_BUILD_GENERATOR OFF CACHE BOOL "Don't build nanopb generator")
include(FetchContent)
FetchContent_Declare(
    nanopb
    GIT_REPOSITORY https://github.com/nanopb/nanopb.git
    GIT_TAG nanopb-0.4.9
)
FetchContent_MakeAvailable(nanopb)

file(GLOB NANOPB_SRC
    "${CMAKE_CURRENT_SOURCE_DIR}/gen/nanopb/kivsee/proto/render/v1/*.c"
)

add_library(kivsee_proto_nanopb STATIC ${NANOPB_SRC})

# set the include directories for consumers
# so they can #include <kivsee/proto/render/v1/xxx.pb.h>
target_include_directories(kivsee_proto_nanopb PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/gen/nanopb
    ${nanopb_SOURCE_DIR}
)
target_link_libraries(kivsee_proto_nanopb PUBLIC protobuf-nanopb-static)
