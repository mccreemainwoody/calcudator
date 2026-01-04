#pragma once

#include <algorithm>
#include <boost/numeric/ublas/storage.hpp>
#include <cstddef>
#include <matrix_ops/matrix.hpp>
#include <stdexcept>
#include <vector>

#include "array.hpp"
#include "cuda_utils.cuh"

namespace matrix_ops {

    template <typename T>
    int* matrix_to_cuda_1d(const matrix<T>& matrix) {
        const std::size_t total_size = matrix.data().size();
        const std::size_t total_bytes_size = total_size * sizeof(T);

        const auto matrix_data = matrix.data();
        auto host_array = std::unique_ptr<T[]>(new T[total_size]);
        int* device_array;

        std::ranges::copy(matrix_data, host_array.get());

        assert(std::equal(matrix_data.begin(), matrix_data.end(),
                          host_array.get()));

        cudaMalloc(&device_array, total_bytes_size);
        cudaMemcpy(device_array, host_array.get(), total_bytes_size,
                   cudaMemcpyHostToDevice);

        return device_array;
    }

    template <typename T>
    matrix<T> cuda_1d_to_matrix(const T* device_matrix, const std::size_t x_len,
                                const std::size_t y_len) {
        using ::boost::numeric::ublas::unbounded_array;

        const std::size_t total_len = x_len * y_len;

        auto host_matrix_data = unbounded_array<T>(total_len, 0);

        cudaMemcpy(&host_matrix_data[0], device_matrix, total_len * sizeof(T),
                   cudaMemcpyDeviceToHost);

        auto host_matrix = matrix<int>(y_len, x_len, host_matrix_data);

        return host_matrix;
    }

    template <typename T>
    T* initialize_cuda_1d_array(const std::size_t size) {
        int* device_out;

        cudaMalloc(&device_out, bytes_size<T>(size));
        cudaMemset(device_out, 0, bytes_size<T>(size));

        return device_out;
    }
} // namespace matrix_ops
