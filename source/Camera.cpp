#include "Camera.h"

Camera::Camera(i32 w, i32 h)
{
  vec3_dup(pos, (const vec3){0, 0, 0});

  yaw = 0;
  pitch = 0;
  fov = DEFAULT_FOV;

  updatedir();
  updateview();
  mat4x4_perspective(proj, radians(fov), (f32)w / h, 0.1, 100);
}

void Camera::translate(f32 dx, f32 dy, f32 dz)
{
  vec3_add(pos, pos, (const vec3){dx, dy, dz});
  updateview();
}

void Camera::move(f32 dr, f32 du, f32 df)
{
  vec3 vr, vf;

  vec3_mul_cross(vr, dir, WORLD_UP);
  vec3_scale(vr, vr, dr / vec3_len(vr));

  vec3_dup(vf, dir);
  vf[1] = 0;
  vec3_scale(vf, vf, df / vec3_len(vf));

  pos[0] += vr[0] + vf[0];
  pos[1] += du;
  pos[2] += vr[2] + vf[2];
  updateview();
}

void Camera::rotate(f32 dyaw, f32 dpitch)
{
  yaw += radians(dyaw);
  pitch -= radians(dpitch);
  updatedir();
  updateview();
}

void Camera::setfov(f32 newfov)
{
  proj[1][1] = 1 / tanf(0.5 * radians(newfov));
  proj[0][0] *= proj[1][1] * tanf(0.5 * radians(fov));
  fov = newfov;
}

void Camera::adjust2size(i32 w, i32 h)
{
  f32 iaspect = (f32)h / w;
  proj[0][0] = iaspect / tanf(0.5 * radians(fov));
}

void Camera::updatedir()
{
  // prevent player to break their neck
  if (fabs(pitch) >= MAX_PITCH)
  {
    i32 sign = (pitch >= 0 ? 1 : -1);
    pitch = MAX_PITCH * sign;
  }

  dir[0] = cosf(yaw) * cosf(pitch);
  dir[1] = sinf(pitch);
  dir[2] = sinf(yaw) * cosf(pitch);
}

void Camera::updateview()
{
  vec3 center;
  vec3_add(center, pos, dir);
  mat4x4_look_at(view, pos, center, WORLD_UP);
}