#include <cstddef>
#include <matrix_ops/ops.hpp>

#include "cuda_utils.cuh"

__global__ void div_value_kernel(int* out, const int* a, const int* b) {
    const std::size_t index = blockDim.x * blockIdx.x + threadIdx.x;

    out[index] = a[index] / b[index];
}

namespace matrix_ops {

    matrix<int> div(const matrix<int>& a, const matrix<int>& b) {
        return perform_operation(a, b, div_value_kernel);
    }
} // namespace matrix_ops
