cmake_minimum_required(VERSION 4.2.1)

target_sources(matrix_ops
   PRIVATE add.cu dot.cu mult.cu sub.cu
)
