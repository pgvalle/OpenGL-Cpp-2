#pragma once

#include "common.h"
#include <linmath.h>

struct Camera
{
  static constexpr vec3 WORLD_UP = {0, 1, 0};

  static const f32 DEFAULT_FOV = 70.0f,
                   MAX_PITCH = 0.5 * PI - 1e-3;

  vec3 pos, dir;     // READ-ONLY
  f32 yaw, pitch;    // READ-ONLY
  f32 fov;           // READ-ONLY
  mat4x4 view, proj; // READ-ONLY

  Camera(i32 w, i32 h);

  void translate(f32 dx, f32 dy, f32 dz); // use world coordinate system as reference
  void move(f32 dr, f32 du, f32 df);      // expected behavior when moving
  void rotate(f32 dyaw, f32 dpitch);
  void setfov(f32 fov);
  void adjust2size(i32 w, i32 h);

  void updatedir();
  void updateview();
};
