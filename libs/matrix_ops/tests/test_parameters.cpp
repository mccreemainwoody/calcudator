#include "test_parameters.hpp"

#include <cstddef>
#include <utility>
#include <vector>

#include "gtest/gtest.h"

static consteval std::size_t pow2(const std::size_t x) {
    return x * x;
};

static constexpr std::pair<std::size_t, std::size_t> rect(const std::size_t y,
                                                          const std::size_t x) {
    return { y, x };
}

static constexpr std::pair<std::size_t, std::size_t>
square(const std::size_t len) {
    return rect(len, len);
};

const testing::internal::ParamGenerator<MatrixOperTestParams>
    TEST_INTER_MATRICES = ::testing::ValuesIn<MatrixOperTestParams>(
        { { square(1), { 1 }, { 1 } },
          { square(3), std::vector(pow2(3), 1), std::vector(pow2(3), 2) },
          { square(10), std::vector(pow2(10), 10), std::vector(pow2(10), 10) },
          { rect(1, 3), { 1, 2, 3 }, { 1, 2, 3 } },
          { rect(3, 1), { 1, 2, 3 }, { 1, 2, 3 } },
          { rect(3, 2), { 1, 2, 3, 4, 5, 6 }, { 6, 5, 4, 3, 2, 1 } } });

extern const testing::internal::ParamGenerator<MatrixScalarOperTestParams>
    TEST_SCALAR_MATRICES = ::testing::ValuesIn<MatrixScalarOperTestParams>({
        { square(1), { 1 }, 1 },
        { square(3), { 1, 1, 1, 1, 1, 1, 1, 1, 1 }, 10 },
        { square(10), std::vector(pow2(10), 5), 100 },
        { rect(5, 1), { 1, 2, 3, 4, 5 }, 2 },
        { rect(1, 5), { 1, 2, 3, 4, 5 }, 5 },
    });

INSTANTIATE_TEST_SUITE_P(MatrixOperationTest, MatrixInterOperTest,
                         TEST_INTER_MATRICES);

INSTANTIATE_TEST_SUITE_P(MatrixScalarOperationTest, MatrixScalarOperTest,
                         TEST_SCALAR_MATRICES);
