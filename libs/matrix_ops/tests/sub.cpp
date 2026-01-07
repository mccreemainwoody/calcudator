#include <algorithm>
#include <gtest/gtest.h>
#include <matrix_ops/ops.hpp>

#include "test_parameters.hpp"

TEST_P(MatrixInterOperTest, substraction) {
    const MatrixOperTestParams param = GetParam();
    const MatrixOperTestParams::matrix_t& a = param.a;
    const MatrixOperTestParams::matrix_t& b = param.b;

    const MatrixOperTestParams::matrix_t expected = a - b;
    const MatrixOperTestParams::matrix_t actual = matrix_ops::sub(a, b);

    ASSERT_TRUE(std::ranges::equal(expected.data(), actual.data()));
}
