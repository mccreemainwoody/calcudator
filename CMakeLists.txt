cmake_minimum_required(VERSION 4.2.1)
project(calcudator
    LANGUAGES CXX)

add_compile_options(
    -Werror
    -Wall
    -Wextra
    -pedantic
)

add_executable(calcudator)

add_subdirectory(src)
