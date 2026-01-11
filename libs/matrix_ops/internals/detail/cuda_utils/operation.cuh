#pragma once

#include <cmath>
#include <cstddef>
#include <iostream>
#include <matrix_ops/ops.hpp>

#include "array.hpp"
#include "cuda_utils.cuh"

#define THREADS_PER_BLOCK 64

constexpr int determine_blocks(const int elements) {
    return std::ceil(static_cast<double>(elements) / THREADS_PER_BLOCK);
}

constexpr int determine_threads_per_block(const int elements) {
    return std::max(elements, THREADS_PER_BLOCK);
}

namespace matrix_ops {

    template <kernel_t T>
    inline matrix<int> perform_operation(const matrix<int>& a,
                                         const matrix<int>& b, T operation) {
        check_matrice_same_size(a, b);

        const std::size_t y_len = a.size1();
        const std::size_t x_len = a.size2();
        const std::size_t total_size = x_len * y_len;

        int* device_a = matrix_to_cuda_1d(a);
        int* device_b = matrix_to_cuda_1d(b);
        int* device_out = initialize_cuda_1d_array<int>(total_size);

        const int blocks = determine_blocks(total_size);
        const int threads = determine_threads_per_block(total_size);

        operation<<<blocks, threads>>>(device_out, device_a, device_b);

        cudaDeviceSynchronize();

        CUDA_CHECK_ERROR();

        matrix<int> result = cuda_1d_to_matrix(device_out, x_len, y_len);

        cudaFree(device_out);
        cudaFree(device_b);
        cudaFree(device_a);

        return result;
    }

    template <kernel_scalar_t T>
    inline matrix<int> perform_operation(const matrix<int>& a, const int k,
                                         T operation) {
        const std::size_t y_len = a.size1();
        const std::size_t x_len = a.size2();
        const std::size_t total_size = x_len * y_len;

        int* device_a = matrix_to_cuda_1d(a);
        int* device_out = initialize_cuda_1d_array<int>(total_size);

        const int blocks = determine_blocks(total_size);
        const int threads = determine_threads_per_block(total_size);

        operation<<<blocks, threads>>>(device_out, device_a, k);

        cudaDeviceSynchronize();

        CUDA_CHECK_ERROR();

        matrix<int> result = cuda_1d_to_matrix(device_out, x_len, y_len);

        cudaFree(device_out);
        cudaFree(device_a);

        return result;
    }
} // namespace matrix_ops
