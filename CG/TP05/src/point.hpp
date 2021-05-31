#ifndef POINT_H
#define POINT_H

class Point {
  private:
    float _x, _y, _z;

  public:
    Point(float x, float y, float z): _x(x), _y(y), _z(z) {};
    auto constexpr x() const noexcept -> float { return _x; }
    auto constexpr y() const noexcept -> float { return _y; }
    auto constexpr z() const noexcept -> float { return _z; }
};

#endif // POINT_H
