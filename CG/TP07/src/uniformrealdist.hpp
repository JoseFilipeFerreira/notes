#ifndef UNIFORM_REAL_DIST
#define UNIFORM_REAL_DIST

#include <random>

template <class T>
class UniformRealDist final {
   private:
    auto static inline m_rand_engine = std::mt19937{ std::random_device{}() };
    mutable std::uniform_real_distribution<T> m_uniform_dist;

   public:
    constexpr UniformRealDist(T min, T max) : m_uniform_dist{ min, max } {}

    auto constexpr operator()() const -> T { return m_uniform_dist(m_rand_engine); }
};

#endif  // UNIFORM_REAL_DIST
