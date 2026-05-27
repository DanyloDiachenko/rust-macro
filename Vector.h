#pragma once
#include <cmath>

struct Vec3 {
  float x, y, z;

  Vec3() : x(0), y(0), z(0) {}
  Vec3(float x, float y, float z) : x(x), y(y), z(z) {}

  float Distance(const Vec3 &other) const {
    return std::sqrt((x - other.x) * (x - other.x) +
                     (y - other.y) * (y - other.y) +
                     (z - other.z) * (z - other.z));
  }
};

struct Vec2 {
  float x, y;

  Vec2() : x(0), y(0) {}
  Vec2(float x, float y) : x(x), y(y) {}
};

struct Matrix {
  float m[4][4] = {0};
};