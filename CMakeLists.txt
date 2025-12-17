cmake_minimum_required(VERSION 4.2.1)
project(calcudator
    LANGUAGES CXX)

add_executable(calcudator)

set_target_properties(calcudator PROPERTIES
    CXX_STANDARD 23
)

target_compile_options(calcudator PRIVATE
    -Werror
    -Wall
    -Wextra
    -pedantic
)

add_subdirectory(libs)
add_subdirectory(src)
