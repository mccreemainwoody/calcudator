#pragma once

#include <gtest/gtest.h>
#include <matrix_ops/matrix.hpp>
#include <utility>
#include <vector>

#include "gtest/gtest.h"

struct MatrixOperTestParams {
    using matrix_shape_t = std::pair<std::size_t, std::size_t>;
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

class MatrixOperTest : public ::testing::TestWithParam<MatrixOperTestParams> {};

extern const testing::internal::ParamGenerator<MatrixOperTestParams>
    TEST_MATRICES;
