#include <algorithm>
#include <gtest/gtest.h>
#include <matrix_ops/ops.hpp>

#include "test_parameters.hpp"

TEST_P(MatrixScalarOperTest, multiplication_scalar) {
    const MatrixScalarOperTestParams param = GetParam();
    const MatrixScalarOperTestParams::matrix_t& a = param.a;
    const int k = param.k;

    const MatrixScalarOperTestParams::matrix_t expected = a * k;
    const MatrixScalarOperTestParams::matrix_t actual = matrix_ops::mult(a, k);

    ASSERT_TRUE(std::ranges::equal(expected.data(), actual.data()));
}
