#pragma once

#include <boost/numeric/ublas/matrix.hpp>

namespace matrix_ops {
    using ::boost::numeric::ublas::matrix;

    matrix<int>* add(matrix<int>& a, matrix<int>& b);

    matrix<int>* sub(matrix<int>& a, matrix<int>& b);

    matrix<int>* mult(matrix<int>& a, matrix<int>& b);

    matrix<int>* dot(matrix<int>& a, matrix<int>& b);

    matrix<int>* inv(matrix<int>& a, matrix<int>& b);

    matrix<int>* pow_mult(matrix<int>& a, matrix<int>& b);

    matrix<int>* pow_dot(matrix<int>& a, matrix<int>& b);
} // namespace matrix_ops
