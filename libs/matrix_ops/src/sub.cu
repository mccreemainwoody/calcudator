#include <cstddef>
#include <matrix_ops/ops.hpp>

#include "array.hpp"
#include "cuda_utils.cuh"

__global__ void sub_kernel(int* out, const int* a, const int* b) {
    const std::size_t index = blockDim.x * blockIdx.x + threadIdx.x;

    out[index] = a[index] - b[index];
}

namespace matrix_ops {

    matrix<int> sub(const matrix<int>& a, const matrix<int>& b) {
        return perform_operation(a, b, sub_kernel);
    }
} // namespace matrix_ops
