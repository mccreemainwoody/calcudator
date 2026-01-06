#pragma once

#include <concepts>
#include <cstddef>
#include <matrix_ops/matrix.hpp>
#include <type_traits>

#define CUDA_CHECK_ERROR(error) ::cudaCheckError(__FILE__, __LINE__)

inline void cudaCheckError(const cudaError_t error, const char* source_file,
                           const int source_line);

inline void cudaCheckError(const char* source_file, const int source_line);

namespace matrix_ops {

    template <typename T>
    concept kernel_t = requires(T kernel, int* out, const int* a, const int* b,
                                std::size_t n_blocks, std::size_t n_threads) {
        { kernel(out, a, b) } -> std::same_as<void>;
        kernel<<<n_blocks, n_threads>>>(out, a, b);
    };

    template <typename T>
    T* initialize_cuda_1d_array(const std::size_t size);

    template <typename T>
    int* matrix_to_cuda_1d(const matrix<T>& matrix);

    template <typename T>
    matrix<T> cuda_1d_to_matrix(const T* device_matrix, const std::size_t x_len,
                                const std::size_t y_len);

    template <kernel_t T>
    inline matrix<int> perform_operation(const matrix<int>& a,
                                         const matrix<int>& b, T operation);
} // namespace matrix_ops

#include "detail/cuda_utils/core.hxx"
