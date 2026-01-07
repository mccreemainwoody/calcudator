#include <cstddef>
#include <gtest/gtest.h>
#include <matrix_ops/ops.hpp>

#include "test_parameters.hpp"

TEST_P(MatrixInterOperTest, multiplication_value) {
    const MatrixOperTestParams param = GetParam();
    const MatrixOperTestParams::matrix_t& a = param.a;
    const MatrixOperTestParams::matrix_t& b = param.b;

    const MatrixOperTestParams::matrix_t actual = matrix_ops::mult(a, b);

    for (std::size_t y = 0; y < actual.size1(); y++) {
        for (std::size_t x = 0; x < actual.size2(); x++) {
            const auto actual_value = a(y, x) * b(y, x);
            const auto expected_value = actual(y, x);

            ASSERT_EQ(expected_value, actual_value);
        }
    }
}
