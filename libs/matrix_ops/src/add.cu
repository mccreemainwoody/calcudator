#include <algorithm>
#include <boost/numeric/ublas/storage.hpp>
#include <format>
#include <matrix_ops/ops.hpp>
#include <stdexcept>
#include <string>
#include <vector>

template <typename T>
constexpr std::size_t bytes_size(const std::size_t size) {
    return size * sizeof(T);
}

void cudaCheckError(const cudaError_t error, const char* source_file,
                    const int source_line) {
    if (error == cudaSuccess) {
        return;
    }

    std::string error_message =
        std::format("error {} raised from CUDA kernel after check at {}:{}: {}",
                    static_cast<int>(error), source_file, source_line,
                    cudaGetErrorString(error));

    throw std::runtime_error(error_message);
}

void cudaCheckError(const char* source_file, const int source_line) {
    const cudaError_t error = cudaGetLastError();

    cudaCheckError(error, source_file, source_line);
}

#define CUDA_CHECK_ERROR(error) cudaCheckError(__FILE__, __LINE__)

__global__ void add_kernel(int* out, const int* a, const int* b) {
    const std::size_t index = blockDim.x * blockIdx.x + threadIdx.x;

    out[index] = a[index] + b[index];
}

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

    template <typename T>
    void check_matrice_same_size(const matrix<T>& a, const matrix<T>& b) {
        if (a.size1() != b.size1()) {
            const auto error_message = std::format(
                "expected a and b to have same column size. found {} and {}",
                a.size1(), b.size1());

            throw std::invalid_argument(error_message);
        }

        if (a.size2() != b.size2()) {
            const auto error_message = std::format(
                "expected a and b to have same row size. found {} and {}",
                a.size2(), b.size2());

            throw std::invalid_argument(error_message);
        }
    }

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
