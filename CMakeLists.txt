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

if (BUILD_TESTING)
    include(FetchContent)

    FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
    )

    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

    FetchContent_MakeAvailable(googletest)

    include(GoogleTest)

    add_executable(calcudator_test)

    set_target_properties(calcudator_test PROPERTIES
        CXX_STANDARD 23
    )

    target_compile_options(calcudator_test PRIVATE
        -Werror
        -Wall
        -Wextra
        -pedantic
        -fsanitize=address
    )

    target_link_options(calcudator_test PRIVATE
        -fsanitize=address
    )
ENDIF (BUILD_TESTING)

add_subdirectory(libs)
add_subdirectory(src)

if (BUILD_TESTING)
    target_link_libraries(calcudator_test PRIVATE
        matrix_ops)

    gtest_discover_tests(calcudator_test)
ENDIF (BUILD_TESTING)
