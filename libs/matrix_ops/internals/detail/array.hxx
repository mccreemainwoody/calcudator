#pragma once

#include <cstddef>
#include <format>

#include "array.hpp"

template <typename T>
constexpr std::size_t bytes_size(const std::size_t size) {
    return size * sizeof(T);
}

template <typename T>
inline void check_matrice_same_size(const matrix_ops::matrix<T>& a,
                                    const matrix_ops::matrix<T>& b) {
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
