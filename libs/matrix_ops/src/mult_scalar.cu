#include <cstddef>
#include <matrix_ops/ops.hpp>

#include "array.hpp"
#include "cuda_utils.cuh"

__global__ void mult_scalar_kernel(int* out, const int* a, const int k) {
    const std::size_t index = blockDim.x * blockIdx.x + threadIdx.x;

    out[index] = a[index] * k;
}

namespace matrix_ops {

    matrix<int> mult(const matrix<int>& a, const int k) {
        const std::size_t y_len = a.size1();
        const std::size_t x_len = a.size2();
        const std::size_t total_size = x_len * y_len;

        int* device_a = matrix_to_cuda_1d(a);
        int* device_out = initialize_cuda_1d_array<int>(total_size);

        mult_scalar_kernel<<<1, total_size>>>(device_out, device_a, k);

        matrix<int> result = cuda_1d_to_matrix(device_out, x_len, y_len);

        cudaFree(device_out);
        cudaFree(device_a);

        return result;
    }
} // namespace matrix_ops
