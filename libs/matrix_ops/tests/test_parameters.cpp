#include "test_parameters.hpp"

#include <cstddef>
#include <utility>

static consteval std::size_t pow2(const std::size_t x) {
    return x * x;
};

static constexpr std::pair<std::size_t, std::size_t>
square(const std::size_t len) {
    return { len, len };
};

static constexpr std::pair<std::size_t, std::size_t> rect(const std::size_t y,
                                                          const std::size_t x) {
    return { y, x };
}

const testing::internal::ParamGenerator<MatrixOperTestParams> TEST_MATRICES =
    ::testing::ValuesIn<MatrixOperTestParams>(
        { { square(1), { 1 }, { 1 } },
          { square(3), std::vector(pow2(3), 1), std::vector(pow2(3), 2) },
          { square(10), std::vector(pow2(10), 10), std::vector(pow2(10), 10) },
          { rect(1, 3), { 1, 2, 3 }, { 1, 2, 3 } },
          { rect(3, 1), { 1, 2, 3 }, { 1, 2, 3 } },
          { rect(3, 2), { 1, 2, 3, 4, 5, 6 }, { 6, 5, 4, 3, 2, 1 } } });
