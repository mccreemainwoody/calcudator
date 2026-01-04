#include <matrix_ops/matrix.hpp>
#include <matrix_ops/ops.hpp>

#include "array.hpp"
#include "cuda_utils.cuh"

__global__ void add_kernel(int* out, const int* a, const int* b) {
    const std::size_t index = blockDim.x * blockIdx.x + threadIdx.x;

    out[index] = a[index] + b[index];
}

namespace matrix_ops {

    matrix<int> add(const matrix<int>& a, const matrix<int>& b) {
        check_matrice_same_size(a, b);

        const std::size_t y_len = a.size1();
        const std::size_t x_len = a.size2();
        const std::size_t total_size = x_len * y_len;

        int* device_a = matrix_to_cuda_1d(a);
        int* device_b = matrix_to_cuda_1d(b);
        int* device_out = initialize_cuda_1d_array<int>(total_size);

        add_kernel<<<1, total_size>>>(device_out, device_a, device_b);

        cudaDeviceSynchronize();

        CUDA_CHECK_ERROR();

        matrix<int> result = cuda_1d_to_matrix(device_out, x_len, y_len);

        cudaFree(device_out);
        cudaFree(device_b);
        cudaFree(device_a);

        return result;
    }
} // namespace matrix_ops
