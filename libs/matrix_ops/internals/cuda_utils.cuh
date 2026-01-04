#pragma once

#include <matrix_ops/matrix.hpp>

#define CUDA_CHECK_ERROR(error) ::cudaCheckError(__FILE__, __LINE__)

inline void cudaCheckError(const cudaError_t error, const char* source_file,
                           const int source_line);

inline void cudaCheckError(const char* source_file, const int source_line);

namespace matrix_ops {

    template <typename T>
    T* initialize_cuda_1d_array(const std::size_t size);

    template <typename T>
    int* matrix_to_cuda_1d(const matrix<T>& matrix);

    template <typename T>
    matrix<T> cuda_1d_to_matrix(const T* device_matrix, const std::size_t x_len,
                                const std::size_t y_len);
} // namespace matrix_ops

#include "detail/cuda_utils/core.hxx"
