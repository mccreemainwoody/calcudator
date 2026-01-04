#pragma once

#include <cstddef>
#include <matrix_ops/matrix.hpp>

template <typename T>
constexpr std::size_t bytes_size(const std::size_t size);

template <typename T>
inline void check_matrice_same_size(const ::matrix_ops::matrix<T>& a,
                                    const ::matrix_ops::matrix<T>& b);

#include "detail/array.hxx"
