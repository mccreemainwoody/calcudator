cmake_minimum_required(VERSION 4.2.1)

target_sources(calcudator_test
    PRIVATE
        add.cpp sub.cpp mult_value.cpp mult_scalar.cpp div_scalar.cpp
        div_value.cpp test_parameters.cpp
)

target_link_libraries(calcudator_test
    PRIVATE matrix_ops)
