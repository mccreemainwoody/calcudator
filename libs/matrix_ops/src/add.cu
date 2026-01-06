#include <matrix_ops/matrix.hpp>
#include <matrix_ops/ops.hpp>

#include "cuda_utils.cuh"

__global__ void add_kernel(int* out, const int* a, const int* b) {
    const std::size_t index = blockDim.x * blockIdx.x + threadIdx.x;

    out[index] = a[index] + b[index];
}

namespace matrix_ops {

    matrix<int> add(const matrix<int>& a, const matrix<int>& b) {
        return perform_operation(a, b, add_kernel);
    }
} // namespace matrix_ops
