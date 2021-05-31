#ifndef POINT_H
#define POINT_H
#include <cmath>

class Vector {
  private:
    float _x, _y, _z;

  public:
    Vector(float x, float y, float z): _x(x), _y(y), _z(z) {}
    auto constexpr x() const noexcept -> float { return _x; }
    auto constexpr y() const noexcept -> float { return _y; }
    auto constexpr z() const noexcept -> float { return _z; }
    auto normalize() const -> Vector {
        float d = std::sqrt(_x * _x + _y * _y + _z * _z);
        return Vector(_x / d, _y / d, _z / d);
    }
    auto cross(Vector v) const -> Vector {
        return Vector(
        _y * v.z() - _z * v.y(),
        _z * v.x() - _x * v.z(),
        _x * v.y() - _y * v.z());
    }
};

class Point {
  private:
    float _x, _y, _z;

  public:
    Point(float x, float y, float z): _x(x), _y(y), _z(z) {}
    auto constexpr x() const noexcept -> float { return _x; }
    auto constexpr y() const noexcept -> float { return _y; }
    auto constexpr z() const noexcept -> float { return _z; }
};

#endif // POINT_H
