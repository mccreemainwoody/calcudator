#include <boost/numeric/ublas/matrix.hpp>
#include <cstddef>
#include <matrix_ops/ops.hpp>

#include "cuda_utils.cuh"

__global__ void div_scalar_kernel(int* out, const int* a, const int k) {
    const std::size_t index = blockDim.x * blockIdx.x + threadIdx.x;

    out[index] = a[index] * k;
}

namespace matrix_ops {

    matrix<int> div(const matrix<int>& a, const int k) {
        return perform_operation(a, k, div_scalar_kernel);
    }
} // namespace matrix_ops
