#pragma once

#include <format>
#include <string>

#include "cuda_utils.cuh"

inline void cudaCheckError(const cudaError_t error, const char* source_file,
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

inline void cudaCheckError(const char* source_file, const int source_line) {
    const cudaError_t error = cudaGetLastError();

    cudaCheckError(error, source_file, source_line);
}
