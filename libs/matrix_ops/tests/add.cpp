#include <cstddef>
#include <cstdlib>
#include <gtest/gtest.h>
#include <matrix_ops/ops.hpp>

TEST(matrix_ops_test_add, one_with_one) {
    matrix_ops::matrix<int> a(1, 1);
    matrix_ops::matrix<int> b(1, 1);

    a(0, 0) = 1;
    b(0, 0) = 1;

    matrix_ops::matrix<int> result = matrix_ops::add(a, b);

    ASSERT_EQ(result(0, 0), 2);
}

TEST(matrix_ops_test_add, three_with_three) {
    const int X_LENGTH = 3;
    const int Y_LENGTH = 3;

    matrix_ops::matrix<int> a(X_LENGTH, Y_LENGTH);
    matrix_ops::matrix<int> b(X_LENGTH, Y_LENGTH);

    for (size_t y = 0; y < Y_LENGTH; y++) {
        for (size_t x = 0; x < X_LENGTH; x++) {
            a(x, y) = 1;
            b(x, y) = 2;
        }
    }

    matrix_ops::matrix<int> result = matrix_ops::add(a, b);

    for (size_t y = 0; y < Y_LENGTH; y++) {
        for (size_t x = 0; x < X_LENGTH; x++) {
            const int expected = a(x, y) + b(x, y);

            ASSERT_EQ(result(x, y), expected);
        }
    }
}

TEST(matrix_ops_test_add, horizontal_matrices) {
    const int X_LENGTH = 3;
    const int Y_LENGTH = 2;

    matrix_ops::matrix<int> a(X_LENGTH, Y_LENGTH);
    matrix_ops::matrix<int> b(X_LENGTH, Y_LENGTH);

    for (size_t y = 0; y < Y_LENGTH; y++) {
        for (size_t x = 0; x < X_LENGTH; x++) {
            a(x, y) = x + y;
            b(x, y) = x - y;
        }
    }

    matrix_ops::matrix<int> result = matrix_ops::add(a, b);

    for (size_t y = 0; y < Y_LENGTH; y++) {
        for (size_t x = 0; x < X_LENGTH; x++) {
            const int expected = a(x, y) + b(x, y);

            ASSERT_EQ(result(x, y), expected);
        }
    }
}
