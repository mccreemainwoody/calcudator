cmake_minimum_required(VERSION 4.2.1)

target_sources(matrix_ops
    PRIVATE
        add.cu sub.cu mult_value.cu mult_scalar.cu div_scalar.cu div_value.cu
        dot.cu
)
