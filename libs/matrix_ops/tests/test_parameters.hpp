#pragma once

#include <gtest/gtest.h>
#include <matrix_ops/matrix.hpp>
#include <utility>
#include <vector>

#include "gtest/gtest.h"

using matrix_shape_t = std::pair<std::size_t, std::size_t>;

struct MatrixOperTestParams {
    using matrix_data_t = std::vector<int>;
    using matrix_t = matrix_ops::matrix<int, boost::numeric::ublas::row_major,
                                        matrix_data_t>;

    matrix_t a;
    matrix_t b;

    MatrixOperTestParams(const matrix_shape_t shape, matrix_data_t a_data,
                         matrix_data_t b_data)
        : a(shape.first, shape.second, std::move(a_data))
        , b(shape.first, shape.second, std::move(b_data)) {
    }
};

struct MatrixScalarOperTestParams {
    using matrix_data_t = std::vector<int>;
    using matrix_t = matrix_ops::matrix<int, boost::numeric::ublas::row_major,
                                        matrix_data_t>;

    const int k;
    matrix_t a;

    MatrixScalarOperTestParams(const matrix_shape_t shape, matrix_data_t a_data,
                               const int k)
        : k(k)
        , a(shape.first, shape.second, std::move(a_data)) {
    }
};

class MatrixInterOperTest
    : public ::testing::TestWithParam<MatrixOperTestParams> {};

class MatrixScalarOperTest
    : public ::testing::TestWithParam<MatrixScalarOperTestParams> {};

extern const testing::internal::ParamGenerator<MatrixOperTestParams>
    TEST_INTER_MATRICES;

extern const testing::internal::ParamGenerator<MatrixScalarOperTestParams>
    TEST_SCALAR_MATRICES;
