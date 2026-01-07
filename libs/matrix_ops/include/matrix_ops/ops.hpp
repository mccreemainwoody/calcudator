#pragma once

#include <matrix_ops/matrix.hpp>

namespace matrix_ops {

    matrix<int> add(const matrix<int>& a, const matrix<int>& b);

    matrix<int> sub(const matrix<int>& a, const matrix<int>& b);

    matrix<int> mult(const matrix<int>& a, const matrix<int>& b);

    matrix<int> mult(const matrix<int>& a, const int k);

    matrix<int> dot(const matrix<int>& a, const matrix<int>& b);

    matrix<int> inv(const matrix<int>& a, const matrix<int>& b);

    matrix<int> pow_mult(const matrix<int>& a, const matrix<int>& b);

    matrix<int> pow_dot(const matrix<int>& a, const matrix<int>& b);
} // namespace matrix_ops
