cmake_minimum_required(VERSION 4.2.1)

enable_language(CUDA)

find_package(Boost REQUIRED)


add_library(matrix_ops SHARED)

set_target_properties(matrix_ops PROPERTIES
    CXX_STANDARD 23
    CUDA_STANDARD 23

    # NOTE: change me to all-major if I become a distributed library
    CUDA_ARCHITECTURES native
)

target_include_directories(matrix_ops
    PUBLIC include
    PRIVATE internals
)

target_link_libraries(matrix_ops
    PRIVATE Boost::boost)


add_subdirectory(src)

if (BUILD_TESTING)
    add_subdirectory(tests)
endif (BUILD_TESTING)
